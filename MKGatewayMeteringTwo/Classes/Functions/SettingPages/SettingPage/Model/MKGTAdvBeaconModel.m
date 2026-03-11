//
//  MKGTAdvBeaconModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTAdvBeaconModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@interface MKGTAdvBeaconParamsModel : NSObject<gt_advertiseBeaconV2Protocol>

@property (nonatomic, assign)BOOL advertise;

@property (nonatomic, assign)NSInteger major;

@property (nonatomic, assign)NSInteger minor;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, assign)NSInteger advInterval;

/*
 0：-24dbm
 1：-21dbm
 2：-18dbm
 3：-15dbm
 4：-12dbm
 5：-9dbm
 6：-6dbm
 7：-3dbm
 8：0dbm
 9：3dbm
 10：6dbm
 11：9dbm
 12：12dbm
 13：15dbm
 14：18dbm
 15：21dbm
 */
@property (nonatomic, assign)NSInteger txPower;

@property (nonatomic, assign)NSInteger rssi1M;

@property (nonatomic, assign)BOOL connectable;

@end

@implementation MKGTAdvBeaconParamsModel
@end

@implementation MKGTAdvBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readAdvertiseBeaconParamsWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        self.advertise = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.major = [NSString stringWithFormat:@"%@",returnData[@"data"][@"major"]];
        self.minor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"minor"]];
        self.uuid = SafeStr(returnData[@"data"][@"uuid"]);
        self.advInterval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"adv_interval"]];
        self.txPower = [returnData[@"data"][@"tx_power"] integerValue];
        if (self.isV2) {
            self.connectable = ([returnData[@"data"][@"connectable"] integerValue] == 1);
            self.rssi1m = [returnData[@"data"][@"rssi_1m"] integerValue];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    MKGTAdvBeaconParamsModel *dataModel = [[MKGTAdvBeaconParamsModel alloc] init];
    dataModel.advertise = self.advertise;
    dataModel.major = [self.major integerValue];
    dataModel.minor = [self.minor integerValue];
    dataModel.uuid = self.uuid;
    dataModel.advInterval = [self.advInterval integerValue];
    dataModel.txPower = self.txPower;
    
    
    if (self.isV2) {
        dataModel.rssi1M = self.rssi1m;
        dataModel.connectable = self.connectable;
        [MKGTMQTTInterface gt_configV2AdvertiseBeaconParams:dataModel
                                                 macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                   sucBlock:^(id  _Nonnull returnData) {
            if (sucBlock) {
                sucBlock();
            }
        }
                                                failedBlock:failedBlock];
        return;
    }
    [MKGTMQTTInterface gt_configAdvertiseBeaconParams:dataModel
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
