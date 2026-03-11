//
//  MKGTDeviceParamsListV2Controller.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/15.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTDeviceParamsListV2Controller.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKSettingTextCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKProgressView.h"
#import "MKAlertView.h"

#import "MKScannerBleBeaconController.h"
#import "MKScannerBleDeviceInfoController.h"
#import "MKScannerBleNTPTimezoneController.h"
#import "MKScannerBleScannerFilterController.h"
#import "MKScannerBleServerForDeviceController.h"

#import "MKGTCentralManager.h"
#import "MKGTInterface+MKGTConfig.h"

#import "MKGTMQTTDataManager.h"

#import "MKGTDeviceModel.h"

#import "MKGTDeviceMQTTParamsModel.h"

#import "MKGTConnectSuccessController.h"
#import "MKGTBleWifiSettingsController.h"
#import "MKGTBleMeteringSettingsController.h"

#import "MKGTBleAdvBeaconModel.h"
#import "MKGTBleDeviceInfoV2Model.h"
#import "MKGTBleNTPTimezoneModel.h"
#import "MKGTBleScannerFilterModel.h"
#import "MKGTServerForDeviceModel.h"

static NSString *const noteMsg = @"Please note the WIFI settings and MQTT settings are required,the other settings are optional.";

@interface MKGTDeviceParamsListV2Controller ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)MKProgressView *progressView;

@property (nonatomic, strong)dispatch_source_t connectTimer;

@property (nonatomic, assign)NSInteger timeCount;

@end

@implementation MKGTDeviceParamsListV2Controller

- (void)dealloc {
    NSLog(@"MKGTDeviceParamsListV2Controller销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [MKGTDeviceMQTTParamsModel sharedDealloc];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //本页面禁止右划退出手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [MKGTDeviceMQTTParamsModel shared].deviceModel.deviceType = @"11";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_gt_peripheralConnectStateChangedNotification
                                               object:nil];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [self popToViewControllerWithClassName:@"MKGTScanPageController"];
    [[MKGTCentralManager shared] disconnect];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 20.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *header = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    header.headerModel = self.headerList[section];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Network Settings
        MKGTBleWifiSettingsController *vc = [[MKGTBleWifiSettingsController alloc] init];
        vc.isV2 = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //MQTT settings
        MKGTServerForDeviceModel *model = [[MKGTServerForDeviceModel alloc] init];
        MKScannerBleServerForDeviceController *vc = [[MKScannerBleServerForDeviceController alloc] initWithProtocol:model];
        vc.updateCompleteBlock = ^(BOOL success) {
            [MKGTDeviceMQTTParamsModel shared].mqttConfig = success;
            [MKGTDeviceMQTTParamsModel shared].deviceModel.clientID = (success ? model.clientID : @"");
            [MKGTDeviceMQTTParamsModel shared].deviceModel.deviceName = (success ? model.deviceName : @"");
            [MKGTDeviceMQTTParamsModel shared].deviceModel.subscribedTopic = (success ? model.subscribeTopic : @"");
            [MKGTDeviceMQTTParamsModel shared].deviceModel.publishedTopic = (success ? model.publishTopic : @"");
            [MKGTDeviceMQTTParamsModel shared].deviceModel.macAddress = (success ? model.macAddress : @"");
            [MKGTDeviceMQTTParamsModel shared].deviceModel.lwtStatus = (success ? model.lwtStatus : NO);
            [MKGTDeviceMQTTParamsModel shared].deviceModel.lwtTopic = (success ? model.lwtTopic : @"");
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        //NTP & Timezone
        MKGTBleNTPTimezoneModel *model = [[MKGTBleNTPTimezoneModel alloc] init];
        MKScannerBleNTPTimezoneController *vc = [[MKScannerBleNTPTimezoneController alloc] initWithProtocol:model];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //Scanner Filter
        BOOL supportInterval = [[MKGTDeviceMQTTParamsModel shared].deviceModel.deviceType isEqualToString:@"11"];
        MKGTBleScannerFilterModel *model = [[MKGTBleScannerFilterModel alloc] init];
        model.title = (supportInterval ? @"Scan & Upload" : @"Scanner Filter");
        model.supportInterval = supportInterval;
        MKScannerBleScannerFilterController *vc = [[MKScannerBleScannerFilterController alloc] initWithProtocol:model];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        //Advertise iBeacon
        MKGTBleAdvBeaconModel *model = [[MKGTBleAdvBeaconModel alloc] init];
        model.isV2 = YES;
        MKScannerBleBeaconController *vc = [[MKScannerBleBeaconController alloc] initWithProtocol:model];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        //Metering Settings
        MKGTBleMeteringSettingsController *vc = [[MKGTBleMeteringSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 4) {
        //Device Information
        MKGTBleDeviceInfoV2Model *model = [[MKGTBleDeviceInfoV2Model alloc] init];
        MKScannerBleDeviceInfoController *vc = [[MKScannerBleDeviceInfoController alloc] initWithProtocol:model];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    return cell;
}

#pragma mark - note
- (void)deviceConnectStateChanged {
    if ([MKGTCentralManager shared].connectStatus == mk_gt_centralConnectStatusConnected) {
        return;
    }
    //设备断开连接，返回上一级页面
    if (self.progressView) {
        [self.progressView dismiss];
    }
    [self.view showCentralToast:@"Device disconnect!"];
    [self performSelector:@selector(gobackToScanPage) withObject:nil afterDelay:0.5f];
}

- (void)receiveDeviceOnline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![[MKGTDeviceMQTTParamsModel shared].deviceModel.macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    //接收到设备的网络状态上报，认为设备入网成功
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MKGTReceiveDeviceOnlineNotification
                                                  object:nil];
    if (self.connectTimer) {
        dispatch_cancel(self.connectTimer);
    }
    self.timeCount = 0;
    [self.progressView setProgress:1.f animated:YES];
    [self performSelector:@selector(connectSuccess) withObject:nil afterDelay:.5f];
}

#pragma mark - event method
- (void)connectButtonPressed {
    if ([MKGTMQTTDataManager shared].state == MKGTMQTTSessionManagerStateConnected) {
        [self sendSTACmdToDevice:YES];
        return;
    }
    //app与MQTT服务器未连接
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"NO" handler:^{
        
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"YES" handler:^{
        @strongify(self);
        [self sendSTACmdToDevice:NO];
    }];
    NSString *msg = @"APP connects to the MQTT broker failed, do you need continue to send configurations to gateway?";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"" message:msg notificationName:@"mk_scanner_needDismissAlert"];
}

#pragma mark - connect process
- (void)startMqttProcess {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:mk_gt_peripheralConnectStateChangedNotification
                                                  object:nil];
    NSString *topic = @"";
    if (ValidStr([MKGTMQTTDataManager shared].serverParams.subscribeTopic)) {
        //查看是否设置了服务器的订阅topic
        topic = [MKGTMQTTDataManager shared].serverParams.subscribeTopic;
    }else {
        topic = [MKGTDeviceMQTTParamsModel shared].deviceModel.publishedTopic;
    }
    [self.progressView show];
    [[MKGTMQTTDataManager shared] subscriptions:@[topic]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceOnline:)
                                                 name:MKGTReceiveDeviceOnlineNotification
                                               object:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.connectTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timeCount = 0;
    dispatch_source_set_timer(self.connectTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.connectTimer, ^{
        @strongify(self);
        if (self.timeCount >= 90) {
            //接受数据超时
            dispatch_cancel(self.connectTimer);
            self.timeCount = 0;
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:MKGTReceiveDeviceOnlineNotification
                                                          object:nil];
            moko_dispatch_main_safe(^{
                [self.progressView dismiss];
                [self showConnectFailedAlert];
            });
            return ;
        }
        self.timeCount ++;
        moko_dispatch_main_safe(^{
            [self.progressView setProgress:(self.timeCount / 90.f) animated:NO];
        });
    });
    dispatch_resume(self.connectTimer);
}

- (void)connectSuccess {
    if (self.progressView) {
        [self.progressView dismiss];
    }
    
    MKGTDeviceModel *deviceModel = [[MKGTDeviceModel alloc] init];
    deviceModel.deviceType = [MKGTDeviceMQTTParamsModel shared].deviceModel.deviceType;
    deviceModel.clientID = [MKGTDeviceMQTTParamsModel shared].deviceModel.clientID;
    deviceModel.subscribedTopic = [MKGTDeviceMQTTParamsModel shared].deviceModel.subscribedTopic;
    deviceModel.publishedTopic = [MKGTDeviceMQTTParamsModel shared].deviceModel.publishedTopic;
    deviceModel.macAddress = [MKGTDeviceMQTTParamsModel shared].deviceModel.macAddress;
    deviceModel.deviceName = [MKGTDeviceMQTTParamsModel shared].deviceModel.deviceName;
    deviceModel.lwtStatus = [MKGTDeviceMQTTParamsModel shared].deviceModel.lwtStatus;
    deviceModel.lwtTopic = [MKGTDeviceMQTTParamsModel shared].deviceModel.lwtTopic;
        
    MKGTConnectSuccessController *vc = [[MKGTConnectSuccessController alloc] init];
    vc.deviceModel = deviceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gobackToScanPage {
    [self popToViewControllerWithClassName:@"MKGTScanPageController"];
}

#pragma mark - private method
- (void)backToDeviceListPage {
    [self popToViewControllerWithClassName:@"MKGTDeviceListController"];
    [[MKGTCentralManager shared] disconnect];
}

- (void)sendSTACmdToDevice:(BOOL)connected {
    if (!self.originMode) {
        //非初始状态，不需要走连接流程，只是发送命令给设备，然后返回扫描页面
        [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
        [MKGTInterface gt_enterSTAModeWithSucBlock:^{
            [[MKHudManager share] hide];
            if (connected) {
                [self.view showCentralToast:@"New settings are applying to device, device is connecting to network and MQTT"];
                [self performSelector:@selector(backToDeviceListPage) withObject:nil afterDelay:1.f];
            }else {
                //没有连接，则弹出第二个弹窗
                [self showConfigSuccessAlert];
            }
            
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (![MKGTDeviceMQTTParamsModel shared].wifiConfig || ![MKGTDeviceMQTTParamsModel shared].mqttConfig) {
        [self.view showCentralToast:@"Please configure WIFI and MQTT settings first!"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGTInterface gt_enterSTAModeWithSucBlock:^{
        [[MKHudManager share] hide];
        if (connected) {
            [self startMqttProcess];
        }else {
            //没有连接，则弹出第二个弹窗
            [self showConfigSuccessAlert];
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)showConfigSuccessAlert {
    @weakify(self);
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        [self backToDeviceListPage];
    }];
    NSString *msg = @"Configurations are successfully sent to gateway.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"" message:msg notificationName:@"mk_scanner_needDismissAlert"];
}

- (void)showConnectFailedAlert {
    @weakify(self);
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        [self gobackToScanPage];
    }];
    NSString *msg = @"The APP is unable to subscribe messages from the gateway. This may be caused by the failure connection with MQTT broker of the gayteway or an incorrect subscription topic set for the APP.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"" message:msg notificationName:@"mk_scanner_needDismissAlert"];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    for (NSInteger i = 0; i < 2; i ++) {
        MKTableSectionLineHeaderModel *model = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:model];
    }
    
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"WIFI Settings";
    [self.section0List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"MQTT Settings";
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"NTP & Timezone";
    [self.section1List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Scan & Upload";
    [self.section1List addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Advertisement Settings";
    [self.section1List addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"Metering Settings";
    [self.section1List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"Device Information";
    [self.section1List addObject:cellModel5];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Settings for Device";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 150.f)];
        
        CGSize noteSize = [NSString sizeWithText:noteMsg
                                         andFont:MKFont(12.f)
                                      andMaxSize:CGSizeMake(kViewWidth - 2 * 15.f, MAXFLOAT)];
        UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f,
                                                                       15.f,
                                                                       kViewWidth - 2 * 15.f,
                                                                       noteSize.height)];
        noteLabel.textColor = DEFAULT_TEXT_COLOR;
        noteLabel.textAlignment = NSTextAlignmentLeft;
        noteLabel.font = MKFont(12.f);
        noteLabel.text = noteMsg;
        noteLabel.numberOfLines = 0;
        [_footerView addSubview:noteLabel];
        
        UIButton *connectButton = [MKCustomUIAdopter customButtonWithTitle:@"Connect"
                                                                    target:self
                                                                    action:@selector(connectButtonPressed)];
        
        connectButton.frame = CGRectMake(30.f, 15.f + noteSize.height + 20.f, kViewWidth - 2 * 30.f, 40.f);
        [_footerView addSubview:connectButton];
    }
    return _footerView;
}

- (MKProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[MKProgressView alloc] initWithTitle:@"Connecting now!"
                                                      message:@"Make sure your device is as close to your router as possible"];
    }
    return _progressView;
}

@end
