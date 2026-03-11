//
//  MKGTBXPSHallCountPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSHallCountPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPSHallCountPageModel

- (void)readDataWithSucBlock:(void (^)(NSString *count))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPSHallCountWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            if (failedBlock) {
                NSError *error = [[NSError alloc] initWithDomain:@"BXPSHallCountPageModel"
                                                            code:-999
                                                        userInfo:@{@"errorInfo":@"Read Failed"}];
                failedBlock(error);
            }
            return;
        }
        NSString *count = [NSString stringWithFormat:@"%@",returnData[@"data"][@"num"]];
        if (sucBlock) {
            sucBlock(count);
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)clearHallCountWithSucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_clearBXPSHallCountWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
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
