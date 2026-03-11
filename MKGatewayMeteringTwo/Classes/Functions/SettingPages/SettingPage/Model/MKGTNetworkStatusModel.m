//
//  MKGTNetworkStatusModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTNetworkStatusModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTNetworkStatusModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readNetworkStatusReportIntervalWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:^(id  _Nonnull returnData) {
        self.interval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"report_interval"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                            failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configNetworkStatusReportInterval:[self.interval integerValue]
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
