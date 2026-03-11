//
//  MKGTNTPServerModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTNTPServerModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTNTPServerModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readNTPServerWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                             sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.host = returnData[@"data"][@"server"];
        if (sucBlock) {
            sucBlock();
        }
    }
                                          failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configNTPServer:self.isOn
                                     host:self.host
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
