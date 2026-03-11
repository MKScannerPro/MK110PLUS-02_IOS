//
//  MKGTFilterByBeaconModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"


@implementation MKGTFilterByBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByBeaconWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                     topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                  sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        NSInteger tempMinMinor = [returnData[@"data"][@"min_minor"] integerValue];
        NSInteger tempMaxMinor = [returnData[@"data"][@"max_minor"] integerValue];
        NSInteger tempMinMajor = [returnData[@"data"][@"min_major"] integerValue];
        NSInteger tempMaxMajor = [returnData[@"data"][@"max_major"] integerValue];
        self.minMinor = [NSString stringWithFormat:@"%ld",(long)tempMinMinor];
        self.maxMinor = [NSString stringWithFormat:@"%ld",(long)tempMaxMinor];
        self.minMajor = [NSString stringWithFormat:@"%ld",(long)tempMinMajor];
        self.maxMajor = [NSString stringWithFormat:@"%ld",(long)tempMaxMajor];
        if (tempMinMinor == 0 && tempMaxMinor == 65535) {
            self.minMinor = @"";
            self.maxMinor = @"";
        }
        if (tempMinMajor == 0 && tempMaxMajor == 65535) {
            self.minMajor = @"";
            self.maxMajor = @"";
        }
        self.uuid = [returnData[@"data"][@"uuid"] lowercaseString];
        if (sucBlock) {
            sucBlock();
        }
    }
                                               failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *msg = [self checkParams];
    if (ValidStr(msg)) {
        [self operationFailedBlockWithMsg:msg block:failedBlock];
        return;
    }
    NSInteger tempMinMinor = [self.minMinor integerValue];
    NSInteger tempMaxMinor = [self.maxMinor integerValue];
    NSInteger tempMinMajor = [self.minMajor integerValue];
    NSInteger tempMaxMajor = [self.maxMajor integerValue];
    
    if (!ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        tempMinMinor = 0;
        tempMaxMinor = 65535;
    }
    if (!ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        tempMinMajor = 0;
        tempMaxMajor = 65535;
    }
    
    [MKGTMQTTInterface gt_configFilterByBeacon:self.isOn
                                      minMinor:tempMinMinor
                                      maxMinor:tempMaxMinor
                                      minMajor:tempMinMajor
                                      maxMajor:tempMaxMajor
                                          uuid:self.uuid
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)checkParams {
    if (!ValidStr(self.minMajor) && ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (!ValidStr(self.minMinor) && ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if (ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if ([self.minMinor integerValue] < 0 || [self.minMinor integerValue] > 65535 || [self.maxMinor integerValue] < [self.minMinor integerValue] || [self.maxMinor integerValue] > 65535) {
        return @"Minor error";
    }
    if ([self.minMajor integerValue] < 0 || [self.minMajor integerValue] > 65535 || [self.maxMajor integerValue] < [self.minMajor integerValue] || [self.maxMajor integerValue] > 65535) {
        return @"Major error";
    }
    if (!self.uuid || ![self.uuid isKindOfClass:NSString.class]) {
        return @"UUID error";
    }
    if (ValidStr(self.uuid)) {
        if (![self.uuid regularExpressions:isHexadecimal] || self.uuid.length > 32 || self.uuid.length % 2 != 0) {
            return @"UUID error";
        }
    }
    return @"";
}

@end
