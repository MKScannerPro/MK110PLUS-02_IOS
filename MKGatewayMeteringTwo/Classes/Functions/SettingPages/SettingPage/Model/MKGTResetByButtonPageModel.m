//
//  MKGTResetByButtonPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/11.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKGTResetByButtonPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTResetByButtonPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readKeyResetTypeWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        self.type = [returnData[@"data"][@"key_reset_type"] integerValue];
        if (sucBlock) {
            sucBlock();
        }
    }
                                             failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configKeyResetType:self.type
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
