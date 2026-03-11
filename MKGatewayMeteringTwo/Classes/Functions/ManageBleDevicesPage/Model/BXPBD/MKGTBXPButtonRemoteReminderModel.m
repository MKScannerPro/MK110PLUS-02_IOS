//
//  MKGTBXPButtonRemoteReminderModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPButtonRemoteReminderModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPButtonRemoteReminderModel

- (instancetype)init {
    if (self = [super init]) {
        _supportVibarate = NO;
    }
    return self;
}

- (void)ledRemoteReminderWithBlinkingTime:(NSInteger)blinkingTime
                         blinkingInterval:(NSInteger)blinkingInterval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBtnLedRemoteReminderWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                               blinkingTime:blinkingTime
                                           blinkingInterval:blinkingInterval
                                                 macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                   sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                failedBlock:failedBlock];
}

- (void)buzzerRemoteReminderWithRingingTime:(NSInteger)ringingTime
                            ringingInterval:(NSInteger)ringingInterval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBtnBuzzerRemoteReminderWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                      ringTime:ringingTime
                                                  ringInterval:ringingInterval
                                                    macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                         topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                      sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                   failedBlock:failedBlock];
}

@end
