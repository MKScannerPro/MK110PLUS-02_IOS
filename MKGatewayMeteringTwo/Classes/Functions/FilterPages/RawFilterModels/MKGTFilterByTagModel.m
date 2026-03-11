//
//  MKGTFilterByTagModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByTagModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByTagModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterBXPTagWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.precise = ([returnData[@"data"][@"precise"] integerValue] == 1);
        self.reverse = ([returnData[@"data"][@"reverse"] integerValue] == 1);
        if (ValidArray(returnData[@"data"][@"tagid"])) {
            self.tagIDList = returnData[@"data"][@"tagid"];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                             failedBlock:failedBlock];
}

- (void)configDataWithTagIDList:(NSArray <NSString *>*)tagIDList
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterByTag:self.isOn
                               preciseMatch:self.precise
                              reverseFilter:self.reverse
                                  tagIDList:tagIDList
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
