//
//  MKGTReconnectTimeModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTReconnectTimeModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTReconnectTimeModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readNetworkReconnectTimeoutWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        self.timeout = [NSString stringWithFormat:@"%@",returnData[@"data"][@"timeout"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                        failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configReconnectTimeout:[self.timeout integerValue]
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
