//
//  MKGTFilterByUIDModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByUIDModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByUIDModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByUIDWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                               sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.instanceID = [returnData[@"data"][@"instance"] lowercaseString];
        self.namespaceID = returnData[@"data"][@"namespace"];
        if (sucBlock) {
            sucBlock();
        }
    }
                                            failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterByUID:self.isOn
                                namespaceID:self.namespaceID
                                 instanceID:self.instanceID
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
