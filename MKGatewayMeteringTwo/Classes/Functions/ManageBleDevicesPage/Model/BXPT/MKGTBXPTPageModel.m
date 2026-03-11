//
//  MKGTBXPTPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPTPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

#import "MKGTButtonDFUV2Model.h"

#import "MKGTBXPTAccDataPageModel.h"
#import "MKGTBXPTAccParamsModel.h"
#import "MKGTBXPTMotionEventPageModel.h"
#import "MKGTBXPTRemoteReminderPageModel.h"
#import "MKGTTAdvParamsModel.h"


@implementation MKGTBXPTPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPTPageModel销毁");
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

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGTBXPTAccDataPageModel alloc] init];
}

- (id <MKScannerBXPTAccParamsProtocol>)accParamsProtocol {
    return [[MKGTBXPTAccParamsModel alloc] init];
}

- (id <MKScannerBXPDAdvParamsProtocol>)advProtocol {
    return [[MKGTTAdvParamsModel alloc] init];
}

- (id <MKScannerBXPSReminderProtocol>)reminderProtocol {
    return [[MKGTBXPTRemoteReminderPageModel alloc] init];
}

- (id <MKScannerBXPTMotionEventProtocol>)eventProtocol {
    return [[MKGTBXPTMotionEventPageModel alloc] init];
}

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPTConnectedStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
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
    [MKGTMQTTInterface gt_bxpBXPTPowerOffWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
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
