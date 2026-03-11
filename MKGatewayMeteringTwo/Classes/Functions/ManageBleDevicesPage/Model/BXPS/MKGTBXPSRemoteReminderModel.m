//
//  MKGTBXPSRemoteReminderModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSRemoteReminderModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPSRemoteReminderModel

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPSLedRemoteReminderWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                       color:self.color
                                                blinkingTime:[self.blinkingTime integerValue]
                                            blinkingInterval:[self.blinkingInterval integerValue]
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
