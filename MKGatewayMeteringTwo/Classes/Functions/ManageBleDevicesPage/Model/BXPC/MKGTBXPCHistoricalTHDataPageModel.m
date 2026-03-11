//
//  MKGTBXPCHistoricalTHDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPCHistoricalTHDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPCHistoricalTHDataPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPCHistoricalTHDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPCNotifyHistoricalHTDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                           notify:isOn
                                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGTReceiveBXPCHistoricalHTDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

- (void)deleteHistoricalHTDataWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPCDeleteHistoricalHTDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

#pragma mark - Notes
- (void)receiveHTDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGTManageBleDevicesManager shared].bleMac]) {
        return;
    }
    
    if (self.receiveHTDataBlock) {
        self.receiveHTDataBlock([dataDic[@"timestamp"] longLongValue], [dataDic[@"temperature"] floatValue], [dataDic[@"humidity"] floatValue]);
    }
}

@end
