//
//  MKGTFilterByButtonModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByButtonModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByButtonModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterBXPButtonWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                   sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.singlePressIsOn = ([returnData[@"data"][@"single_press"] integerValue] == 1);
        self.doublePressIsOn = ([returnData[@"data"][@"double_press"] integerValue] == 1);
        self.longPressIsOn = ([returnData[@"data"][@"long_press"] integerValue] == 1);
        self.abnormalInactivityIsOn = ([returnData[@"data"][@"abnormal_inactivity"] integerValue] == 1);
        if (sucBlock) {
            sucBlock();
        }
    }
                                                failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterBXPButton:self
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
