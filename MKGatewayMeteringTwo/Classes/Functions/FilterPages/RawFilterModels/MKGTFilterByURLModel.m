//
//  MKGTFilterByURLModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByURLModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByURLModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByUrlWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                               sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.url = [returnData[@"data"][@"url"] lowercaseString];;
        if (sucBlock) {
            sucBlock();
        }
    }
                                            failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterByURL:self.isOn
                                        url:self.url
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
