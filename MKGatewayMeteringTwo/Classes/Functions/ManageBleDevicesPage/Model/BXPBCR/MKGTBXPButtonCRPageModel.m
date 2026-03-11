//
//  MKGTBXPButtonCRPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPButtonCRPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

#import "MKGTButtonDFUV2Model.h"

#import "MKGTBXPButtonCRAccDataPageModel.h"
#import "MKGTBXPButtonCRAdvParamsModel.h"
#import "MKGTBXPButtonCRAlarmEventModel.h"
#import "MKGTBXPButtonCRRemoteReminderModel.h"


@implementation MKGTBXPButtonCRPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPButtonCRPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _deviceBleInfo = [MKGTManageBleDevicesManager shared].deviceBleInfo;
        [self addNotes];
    }
    return self;
}

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol {
    return [[MKGTButtonDFUV2Model alloc] init];
}

- (id <MKScannerRemoteReminderProtocol>)remoteReminderProtocol {
    return [[MKGTBXPButtonCRRemoteReminderModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGTBXPButtonCRAccDataPageModel alloc] init];
}

- (id <MKScannerBXPButtonCRAlarmEventProtocol>)alarmEventProtocol {
    return [[MKGTBXPButtonCRAlarmEventModel alloc] init];
}

- (id <MKScannerBXPCAdvParamsProtocol>)advProtocol {
    return [[MKGTBXPButtonCRAdvParamsModel alloc] init];
}

- (void)clearEventCountWithType:(NSInteger)type
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_clearBXPButtonCREventCountWithType:type
                                               bleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPButtonCRConnectedStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                               macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                 sucBlock:sucBlock
                                                              failedBlock:failedBlock];
}

- (void)dismissBXPButtonCRAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_dismissBXPButtonCRAlarmStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                sucBlock:sucBlock
                                                             failedBlock:failedBlock];
}

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_disconnectNormalBleDeviceWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBtnCRRemotePowerOffWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                     topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                  sucBlock:sucBlock
                                               failedBlock:failedBlock];
}

#pragma mark - notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDisconnectBlock) {
        self.receiveDisconnectBlock();
    }
}

- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGTReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
}

@end
