//
//  MKGTBXPSPageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPSPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

#import "MKGTButtonDFUV2Model.h"

#import "MKGTBXPSAccDataPageModel.h"
#import "MKGTBXPSAdvParamsModel.h"
#import "MKGTBXPSHallCountPageModel.h"
#import "MKGTBXPSHistoricalTHDataPageModel.h"
#import "MKGTBXPSRealTimeTHDataPageModel.h"
#import "MKGTBXPSRemoteReminderModel.h"
#import "MKGTBXPSTHDataSampleRateModel.h""


@implementation MKGTBXPSPageModel

- (void)dealloc {
    NSLog(@"MKGTBXPSPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _deviceBleInfo = [MKGTManageBleDevicesManager shared].deviceBleInfo;
        [self addNotes];
    }
    return self;
}

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol {
    return [[MKGTButtonDFUV2Model alloc] init];
}

- (id <MKScannerRealTimeTHDataProtocol>)realTimeTHDataProtocol {
    return [[MKGTBXPSRealTimeTHDataPageModel alloc] init];
}

- (id <MKScannerBXPSHistoricalTHDataProtocol>)historicalTHDataProtocol {
    return [[MKGTBXPSHistoricalTHDataPageModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGTBXPSAccDataPageModel alloc] init];
}

- (id <MKScannerTHDataSampleRateProtocol>)sampleRateProtocol {
    return [[MKGTBXPSTHDataSampleRateModel alloc] init];
}

- (id <MKScannerBXPSHallCountProtocol>)hallCountProtocol {
    return [[MKGTBXPSHallCountPageModel alloc] init];
}

- (id <MKScannerBXPSReminderProtocol>)remoteReminderProtocol {
    return [[MKGTBXPSRemoteReminderModel alloc] init];
}

- (id <MKScannerBXPSAdvParamsProtocol>)advProtocol {
    return [[MKGTBXPSAdvParamsModel alloc] init];
}


- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPSConnectedStatusWithBleMacAddress:[MKGTManageBleDevicesManager shared].bleMac
                                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                          sucBlock:sucBlock
                                                       failedBlock:failedBlock];
}

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_disconnectNormalBleDeviceWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_bxpBXPSPowerOffWithBleMac:[MKGTManageBleDevicesManager shared].bleMac
                                         macAddress:[MKScannerDeviceModelManager shared].macAddress
                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                           sucBlock:sucBlock
                                        failedBlock:failedBlock];
}

#pragma mark - notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDisconnectBlock) {
        self.receiveDisconnectBlock();
    }
}

- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGTReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
}

@end
