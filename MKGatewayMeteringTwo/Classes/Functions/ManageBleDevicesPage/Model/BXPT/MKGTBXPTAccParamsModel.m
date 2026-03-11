//
//  MKGTBXPTAccParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPTAccParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPTAccParamsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPTAccParamsWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        self.scale = [returnData[@"data"][@"full_scale"] integerValue];
        self.sampleRate = [returnData[@"data"][@"sampling_rate"] integerValue];
        self.sensitivity = [NSString stringWithFormat:@"%@",returnData[@"data"][@"sensitivity"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configBXPTAccParamsWithScale:self.scale
                                            sampleRate:self.sampleRate
                                           sensitivity:[self.sensitivity integerValue]
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

@end
