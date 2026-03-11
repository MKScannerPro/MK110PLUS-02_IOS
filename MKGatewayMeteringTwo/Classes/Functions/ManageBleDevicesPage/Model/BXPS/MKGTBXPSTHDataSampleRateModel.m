//
//  MKGTBXPSTHDataSampleRateModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSTHDataSampleRateModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPSTHDataSampleRateModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPSTHDataSampleRateWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                         macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        self.sampleRate = [NSString stringWithFormat:@"%@",returnData[@"data"][@"sampling_rate"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                        failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configBXPSSampleRate:[self.sampleRate integerValue]
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
