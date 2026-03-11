//
//  MKGTTofSensorDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTTofSensorDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTTofSensorDataPageModel

- (void)dealloc {
    NSLog(@"MKGTTofSensorDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notes
- (void)receiveSensorDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGTManageBleDevicesManager shared].bleMac]) {
        return;
    }
    NSString *distance = [NSString stringWithFormat:@"%@",dataDic[@"distance"]];
    if (self.receiveSensorDataBlock) {
        self.receiveSensorDataBlock(distance);
    }
}


#pragma mark - Public method
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpMKTofNotifySensorDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                      notify:isOn
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveSensorDatas:)
                                                         name:MKGTReceiveMKTofDistanceDataNotification
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

@end
