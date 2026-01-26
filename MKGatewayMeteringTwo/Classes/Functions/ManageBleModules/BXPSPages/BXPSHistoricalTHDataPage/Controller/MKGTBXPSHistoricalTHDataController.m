//
//  MKGTBXPSHistoricalTHDataController.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSHistoricalTHDataController.h"

#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKButtonMsgCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"
#import "MKSettingTextCell.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTDeviceModeManager.h"
#import "MKGTDeviceModel.h"

#import "MKGTBXPSHistoricalTHDataHeaderView.h"

@interface MKGTBXPSHistoricalTHDataController ()<MFMailComposeViewControllerDelegate,
MKGTBXPSHistoricalTHDataHeaderViewDelegate>

@property (nonatomic, strong)MKGTBXPSHistoricalTHDataHeaderView *headerView;

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation MKGTBXPSHistoricalTHDataController

- (void)dealloc {
    NSLog(@"MKGTBXPSHistoricalTHDataController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:  //取消
            break;
        case MFMailComposeResultSaved:      //用户保存
            break;
        case MFMailComposeResultSent:       //用户点击发送
            [self.view showCentralToast:@"send success"];
            break;
        case MFMailComposeResultFailed: //用户尝试保存或发送邮件失败
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MKGTBXPSHistoricalTHDataHeaderViewDelegate
- (void)gt_BXPSHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_bxpBXPSNotifyHistoricalHTDataWithBleMac:self.bleMac notify:isOn macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        [self.headerView updateSyncStatus:isOn];
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGTReceiveBXPSHistoricalHTDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gt_BXPSHistoricalHTDataHeaderView_deleteButtonPressed {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_bxpBXPSDeleteHistoricalHTDataWithBleMac:self.bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        self.textView.text = @"";
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gt_BXPSHistoricalHTDataHeaderView_exportButtonPressed {
    if (![MFMailComposeViewController canSendMail]) {
        //如果是未绑定有效的邮箱，则跳转到系统自带的邮箱去处理
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"MESSAGE://"]
                                           options:@{}
                                 completionHandler:nil];
        return;
    }
    NSData *emailData = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    if (!ValidData(emailData) || emailData.length == 0) {
        [self.view showCentralToast:@"Log file does not exist"];
        return;
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *bodyMsg = [NSString stringWithFormat:@"APP Version: %@ + + OS: %@",
                         version,
                         kSystemVersionString];
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    //收件人
    [mailComposer setToRecipients:@[@"Development@mokotechnology.com"]];
    //邮件主题
    [mailComposer setSubject:@"Feedback of mail"];
    [mailComposer addAttachmentData:emailData
                           mimeType:@"application/txt"
                           fileName:@"BXP-S HistoricalHTDatas.txt"];
    [mailComposer setMessageBody:bodyMsg isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

#pragma mark - Notes
- (void)receiveHTDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKGTDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.bleMac]) {
        return;
    }
    NSArray *historyList = dataDic[@"history"];
    if (!ValidArray(historyList)) {
        return;
    }
    NSString *text = @"";
    for (NSDictionary *dic in historyList) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"timestamp"] integerValue]];
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        NSString *temperature = [NSString stringWithFormat:@"%.1f",[dic[@"temperature"] floatValue]];
        NSString *humidity = [NSString stringWithFormat:@"%.1f",[dic[@"humidity"] floatValue]];
        NSString *tempString = [NSString stringWithFormat:@"\n%@      %@      %@",dateString,temperature,humidity];
        text = [tempString stringByAppendingString:text];
    }
    
    self.textView.text = [text stringByAppendingString:self.textView.text];
//    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Historical T&H data";
    [self.view addSubview:self.headerView];
    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(10.f);
        make.height.mas_equalTo(100.f);
    }];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(5.f);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKGTBXPSHistoricalTHDataHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKGTBXPSHistoricalTHDataHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = MKFont(13.f);
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.editable = NO;
        _textView.textColor = DEFAULT_TEXT_COLOR;
    }
    return _textView;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    return _dateFormatter;
}

@end
