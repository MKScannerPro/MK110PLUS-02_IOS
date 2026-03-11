//
//  MKGTBXPCAdvParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPCAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPCAdvParamsModel

- (instancetype)init {
    if (self = [super init]) {
        _multiples = 100;
    }
    return self;
}

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPCAdvParamsWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock(returnData[@"data"][@"adv_param"]);
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configAdvParamsWithChannel:(NSInteger)channel
                          interval:(NSInteger)interval
                           txPower:(NSInteger)txPower
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configBXPCAdvParamsWithChannel:channel
                                                interval:interval
                                                 txPower:txPower
                                                  bleMac:[MKGTManageBleDevicesManager shared].bleMac
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
