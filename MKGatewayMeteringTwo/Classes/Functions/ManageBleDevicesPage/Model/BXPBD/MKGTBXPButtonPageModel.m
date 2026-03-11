//
//  MKGTBXPButtonPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPButtonPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

#import "MKGTButtonDFUModel.h"
#import "MKGTButtonDFUV2Model.h"

#import "MKGTBXPButtonAccDataPageModel.h"
#import "MKGTBXPButtonAdvParamsModel.h"
#import "MKGTBXPButtonRemoteReminderModel.h"

@implementation MKGTBXPButtonPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPButtonPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _isV2 = [MKScannerDeviceModelManager shared].isV2;
        _deviceBleInfo = [MKGTManageBleDevicesManager shared].deviceBleInfo;
        [self addNotes];
    }
    return self;
}

- (id <MKScannerButtonDfuV1Protocol>)dfuProtocol1 {
    return [[MKGTButtonDFUModel alloc] init];
}

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol2 {
    return [[MKGTButtonDFUV2Model alloc] init];
}

- (id <MKScannerRemoteReminderProtocol>)remoteReminderProtocol {
    return [[MKGTBXPButtonRemoteReminderModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGTBXPButtonAccDataPageModel alloc] init];
}

- (id <MKScannerBXPCAdvParamsProtocol>)advProtocol {
    return [[MKGTBXPButtonAdvParamsModel alloc] init];
}

- (void)clearTriggerEventCountWithType:(NSInteger)type
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_clearTriggerEventCount:type
                                          bleMac:[MKGTManageBleDevicesManager shared].bleMac
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
    [MKGTMQTTInterface gt_readBXPButtonConnectedStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:sucBlock
                                                            failedBlock:failedBlock];
}

- (void)dismissBXPButtonAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_dismissBXPButtonAlarmStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
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
    [MKGTMQTTInterface gt_bxpBtnRemotePowerOffWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
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
