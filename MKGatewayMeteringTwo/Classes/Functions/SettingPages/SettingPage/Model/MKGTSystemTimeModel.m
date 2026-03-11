//
//  MKGTSystemTimeModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/11.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKGTSystemTimeModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

#import "MKGTNTPServerModel.h"

@implementation MKGTSystemTimeModel

- (id <MKScannerNTPServerProtocol>)ntpServerProtocol {
    return [[MKGTNTPServerModel alloc] init];
}

- (void)readUTCTimeDataWithSucBlock:(void (^)(NSDictionary *dic))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readDeviceUTCTimeWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:sucBlock
                                              failedBlock:failedBlock];
}

- (void)configTimezone:(NSInteger)timeZone
             timestamp:(NSTimeInterval)timestamp
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configDeviceTimeZone:timeZone
                                     timestamp:timestamp
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
