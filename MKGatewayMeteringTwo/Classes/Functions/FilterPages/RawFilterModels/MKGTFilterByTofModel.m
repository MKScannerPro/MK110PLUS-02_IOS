//
//  MKGTFilterByTofModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/11/01.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKGTFilterByTofModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByTofModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByTofWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                               sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        if (ValidArray(returnData[@"data"][@"mfg_code"])) {
            self.codeList = returnData[@"data"][@"mfg_code"];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                            failedBlock:failedBlock];
}

- (void)configDataWithCodeList:(NSArray <NSString *>*)codeList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterByTofList:codeList
                                           isOn:self.isOn
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
