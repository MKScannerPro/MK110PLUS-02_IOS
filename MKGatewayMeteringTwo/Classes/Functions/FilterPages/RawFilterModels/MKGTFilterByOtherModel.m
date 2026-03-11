//
//  MKGTFilterByOtherModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByOtherModel.h"

#import "MKMacroDefines.h"
#import "NSObject+MKModel.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTFilterRawAdvDataModel

- (BOOL)validParams {
    if (!ValidStr(self.dataType)) {
        self.dataType = @"00";
    }
    if (!ValidStr(self.dataType) || self.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.dataType]) {
        return NO;
    }
    
    if (self.minIndex == 0 && self.maxIndex == 0) {
        if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData] || (self.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (self.minIndex < 0 || self.minIndex > 29 || self.maxIndex < 0 || self.maxIndex > 29) {
        return NO;
    }
    
    if (self.maxIndex < self.minIndex) {
        return NO;
    }
    if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData]) {
        return NO;
    }
    NSInteger totalLen = (self.maxIndex - self.minIndex + 1) * 2;
    if (totalLen > 58 || self.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

@end

@implementation MKGTFilterByOtherModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterOtherDatasWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.relationship = [returnData[@"data"][@"relation"] integerValue];
        self.rawDataList = returnData[@"data"][@"rule"];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configWithRawDataList:(NSArray <NSDictionary *>*)list
                 relationship:(NSInteger)relationship
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSMutableArray *tempList = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        MKGTFilterRawAdvDataModel *model = [MKGTFilterRawAdvDataModel mk_modelWithJSON:dic];
        if (model) {
            [tempList addObject:model];
        }
    }
    [MKGTMQTTInterface gt_configFilterByOtherDatas:self.isOn
                                      relationship:relationship
                                       rawDataList:tempList
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
