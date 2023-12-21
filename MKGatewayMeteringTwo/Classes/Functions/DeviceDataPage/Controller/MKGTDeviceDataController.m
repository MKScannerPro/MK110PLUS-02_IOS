//
//  MKGTDeviceDataController.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTDeviceDataController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTDeviceModeManager.h"
#import "MKGTDeviceModel.h"

#import "MKGTDeviceDataPageHeaderView.h"
#import "MKGTDeviceDataPageCell.h"

#import "MKGTSettingController.h"
#import "MKGTUploadOptionController.h"
#import "MKGTManageBleDevicesController.h"
#import "MKGTNormalConnectedController.h"
#import "MKGTBXPButtonController.h"
#import "MKGTPowerMeteringController.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKGTDeviceDataController ()<UITableViewDelegate,
UITableViewDataSource,
MKGTDeviceDataPageHeaderViewDelegate,
MKGTReceiveDeviceDatasDelegate>

@property (nonatomic, strong)MKGTDeviceDataPageHeaderView *headerView;

@property (nonatomic, strong)MKGTDeviceDataPageHeaderViewModel *headerModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation MKGTDeviceDataController

- (void)dealloc {
    NSLog(@"MKGTDeviceDataController销毁");
    [MKGTDeviceModeManager sharedDealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MKGTMQTTDataManager shared].dataDelegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    if (self.headerModel.isOn) {
        [MKGTMQTTDataManager shared].dataDelegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
    [self runloopObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_gt_deviceNameChangedNotification"
                                               object:nil];
}

#pragma mark - super method
- (void)rightButtonMethod {
    MKGTSettingController *vc = [[MKGTSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGTDeviceDataPageCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGTDeviceDataPageCell *cell = [MKGTDeviceDataPageCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - MKGTDeviceDataPageHeaderViewDelegate

- (void)gt_updateLoadButtonAction {
    MKGTUploadOptionController *vc = [[MKGTUploadOptionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gt_powerButtonAction {
    MKGTPowerMeteringController *vc = [[MKGTPowerMeteringController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gt_scannerStatusChanged:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_configScanSwitchStatus:isOn
                                      macAddress:[MKGTDeviceModeManager shared].macAddress
                                           topic:[MKGTDeviceModeManager shared].subscribedTopic
                                        sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = isOn;
        [self updateStatus];
    }
                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gt_manageBleDeviceAction {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_readGatewayBleConnectStatusWithMacAddress:[MKGTDeviceModeManager shared].macAddress
                                                              topic:[MKGTDeviceModeManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        NSArray *deviceList = returnData[@"data"][@"ble_conn_list"];
        if (ValidArray(deviceList)) {
            //网关已经连接设备
            NSDictionary *connectDevice = deviceList[0];
            [self readConnectedDeviceInfoWithBleMac:connectDevice[@"mac"] normal:([connectDevice[@"type"] integerValue] == 0)];
            return;
        }
        //网关没有连接设备
        MKGTManageBleDevicesController *vc = [[MKGTManageBleDevicesController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
                                                        failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKGTReceiveDeviceDatasDelegate
- (void)mk_gt_receiveDeviceDatas:(NSDictionary *)data {
    if (!ValidDict(data) || !ValidStr(data[@"device_info"][@"mac"]) || ![[MKGTDeviceModeManager shared].macAddress isEqualToString:data[@"device_info"][@"mac"]]) {
        return;
    }
    NSArray *tempList = data[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        NSString *jsonString = [self convertToJsonData:dic];
        if (ValidStr(jsonString)) {
            MKGTDeviceDataPageCellModel *cellModel = [[MKGTDeviceDataPageCellModel alloc] init];
            cellModel.msg = jsonString;
            if (self.dataList.count == 0) {
                [self.dataList addObject:cellModel];
            }else {
                [self.dataList insertObject:cellModel atIndex:0];
            }
        }
    }
    [self needRefreshList];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if(!policyData && error){
        return @"";
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return policyStr;
}


- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![[MKGTDeviceModeManager shared].macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    self.defaultTitle = user[@"deviceName"];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_readScanSwitchStatusWithMacAddress:[MKGTDeviceModeManager shared].macAddress
                                                       topic:[MKGTDeviceModeManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = ([returnData[@"data"][@"scan_switch"] integerValue] == 1);
        self.headerView.dataModel = self.headerModel;
        [self updateStatus];
    }
                                                 failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac normal:(BOOL)normal {
    if (normal) {
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKGTMQTTInterface gt_readNormalConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKGTNormalConnectedController *vc = [[MKGTNormalConnectedController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    //BXP-Button
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGTMQTTInterface gt_readBXPButtonConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        MKGTBXPButtonController *vc = [[MKGTBXPButtonController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method

/// 当扫描状态发生改变的时候，需要动态刷新UI，如果打开则添加扫描数据监听，如果关闭，则移除扫描数据监听
- (void)updateStatus {
    [self.dataList removeAllObjects];
    [self.headerView setDataModel:self.headerModel];
    [self.headerView updateTotalNumbers:0];
    [self.tableView reloadData];
    if (self.headerModel.isOn) {
        //打开
        [MKGTMQTTDataManager shared].dataDelegate = self;
        return;
    }
    //关闭状态
    [MKGTMQTTDataManager shared].dataDelegate = nil;
}

#pragma mark - 定时刷新

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                self.headerView.dataModel = self.headerModel;
                [self.headerView updateTotalNumbers:self.dataList.count];
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKGTDeviceModeManager shared].deviceName;
    [self.rightButton setImage:LOADICON(@"MKGatewayMeteringTwo", @"MKGTDeviceDataController", @"gt_moreIcon.png") forState:UIControlStateNormal];
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
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKGTDeviceDataPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKGTDeviceDataPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 175.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (MKGTDeviceDataPageHeaderViewModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [[MKGTDeviceDataPageHeaderViewModel alloc] init];
    }
    return _headerModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
