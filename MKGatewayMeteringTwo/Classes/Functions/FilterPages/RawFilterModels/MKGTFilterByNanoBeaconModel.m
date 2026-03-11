//
//  MKGTFilterByNanoBeaconModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/10/20.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKGTFilterByNanoBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterByNanoBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByNanoBeaconWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                         topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                      sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.triggerType = [returnData[@"data"][@"adv_type"] integerValue];
        if (ValidArray(returnData[@"data"][@"mf_id"])) {
            self.manufactureList = returnData[@"data"][@"mf_id"];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                                   failedBlock:failedBlock];
}

- (void)configDataWithManufactureList:(NSArray <NSString *>*)manufactureList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (![self validParams:manufactureList]) {
        [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
        return;
    }
    [MKGTMQTTInterface gt_configFilterByNanoBeacon:self.isOn
                                           advType:self.triggerType
                                 manufactureIDList:manufactureList
                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                       failedBlock:failedBlock];
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"FilterByNanoBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams:(NSArray <NSString *>*)manufactureList {
    if (manufactureList.count > 10) {
        return NO;
    }
    for (NSString *manufacture in manufactureList) {
        if ((manufacture.length != 4) || ![manufacture regularExpressions:isHexadecimal]) {
            return NO;
        }
    }
    return YES;
}

@end
