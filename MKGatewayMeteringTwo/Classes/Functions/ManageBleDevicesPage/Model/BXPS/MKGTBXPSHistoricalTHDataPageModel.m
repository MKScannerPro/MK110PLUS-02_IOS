//
//  MKGTBXPSHistoricalTHDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSHistoricalTHDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPSHistoricalTHDataPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPSHistoricalTHDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPSNotifyAccDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                  notify:isOn
                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGTReceiveBXPSHistoricalHTDataNotification
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
    [MKGTMQTTInterface gt_bxpBXPSDeleteHistoricalHTDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
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
    NSArray *historyList = dataDic[@"history"];
    if (!ValidArray(historyList)) {
        return;
    }
    if (self.receiveHTDataBlock) {
        self.receiveHTDataBlock(historyList);
    }
}

@end
