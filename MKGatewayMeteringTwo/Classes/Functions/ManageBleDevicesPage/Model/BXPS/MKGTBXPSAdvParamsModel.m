//
//  MKGTBXPSAdvParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPSAdvParamsModel

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPSAdvParamsWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock(returnData[@"data"][@"adv_param"]);
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configAdvParams:(NSDictionary *)params
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configBXPSAdvParamsWithParams:params
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
