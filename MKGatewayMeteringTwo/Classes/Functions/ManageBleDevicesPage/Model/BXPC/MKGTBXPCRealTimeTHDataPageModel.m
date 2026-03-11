//
//  MKGTBXPCRealTimeTHDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPCRealTimeTHDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTBXPCRealTimeTHDataPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPCRealTimeTHDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _mailFileName = @"BXP-C RealTimeHTDatas.txt";
    }
    return self;
}

- (void)notifyRealTimeHTData:(BOOL)isOn
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPCNotifyRealTimeHTDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                         notify:isOn
                                                     macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                          topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                       sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGTReceiveBXPCRealTimeHTDataNotification
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
    NSString *temperature = [NSString stringWithFormat:@"%.1f",[dataDic[@"temperature"] floatValue]];
    NSString *humidity = [NSString stringWithFormat:@"%.1f",[dataDic[@"humidity"] floatValue]];
    if (self.receiveHTDataBlock) {
        self.receiveHTDataBlock(temperature, humidity);
    }
}

@end
