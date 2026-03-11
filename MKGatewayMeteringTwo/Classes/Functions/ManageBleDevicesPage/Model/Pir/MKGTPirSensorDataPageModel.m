//
//  MKGTPirSensorDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTPirSensorDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTPirSensorDataPageModel

- (void)dealloc {
    NSLog(@"MKGTPirSensorDataPageModel销毁");
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
    NSString *doorState = ([dataDic[@"hall_status"] integerValue] == 1 ? @"Door open" : @"Door close");
    NSString *pirState = ([dataDic[@"pir_status"] integerValue] == 1 ? @"occupied" : @"not occupied");
    if (self.receiveSensorDataBlock) {
        self.receiveSensorDataBlock(doorState, pirState);
    }
}


#pragma mark - Public method
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_notifyMKPirSensorDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                   notify:isOn
                                               macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveSensorDatas:)
                                                         name:MKGTReceiveMKPirSensorDataNotification
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
