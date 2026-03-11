//
//  MKGTBXPTRemoteReminderPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPTRemoteReminderPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPTRemoteReminderPageModel

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPTLedRemoteReminderWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
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
