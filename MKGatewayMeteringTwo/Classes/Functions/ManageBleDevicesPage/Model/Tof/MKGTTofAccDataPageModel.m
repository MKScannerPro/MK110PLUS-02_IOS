//
//  MKGTTofAccDataPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTTofAccDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTTofAccDataPageModel

- (void)dealloc {
    NSLog(@"MKGTTofAccDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _mailFileName = @"Tof AccData.txt";
    }
    return self;
}

#pragma mark - Notes
- (void)receiveAccDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGTManageBleDevicesManager shared].bleMac]) {
        return;
    }
    NSString *xAxisData = [NSString stringWithFormat:@"%@",dataDic[@"x_axis_data"]];
    NSString *yAxisData = [NSString stringWithFormat:@"%@",dataDic[@"y_axis_data"]];
    NSString *zAxisData = [NSString stringWithFormat:@"%@",dataDic[@"z_axis_data"]];
    if (self.receiveAccDataBlock) {
        self.receiveAccDataBlock(xAxisData, yAxisData, zAxisData);
    }
}


#pragma mark - Public method

/// 监听Acc数据
- (void)notifyAccData:(BOOL)isOn
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpMKTofNotifyAccDataWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                   notify:isOn
                                               macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveAccDatas:)
                                                         name:MKGTReceiveMKTofAccDataNotification
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
