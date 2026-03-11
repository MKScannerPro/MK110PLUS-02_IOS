//
//  MKGTIndicatorSetingsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTIndicatorSetingsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTIndicatorSetingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readIndicatorLightStatusWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                           topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                        sucBlock:^(id  _Nonnull returnData) {
        self.server_connecting = [returnData[@"data"][@"server_connecting_led"] boolValue];
        self.server_connected = [returnData[@"data"][@"server_connected_led"] boolValue];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                     failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configIndicatorLightStatus:self
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
