//
//  MKGTMeteringParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTMeteringParamsModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGTMQTTInterface.h"

#import "MKGTDeviceModeManager.h"

@interface MKGTMeteringParamsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGTMeteringParamsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMeteringSwitch]) {
            [self operationFailedBlockWithMsg:@"Read Metering switch Error" block:failedBlock];
            return;
        }
        if (![self readLoadDetection]) {
            [self operationFailedBlockWithMsg:@"Read Load detection notification Error" block:failedBlock];
            return;
        }
        if (![self readPowerInterval]) {
            [self operationFailedBlockWithMsg:@"Read Power reporting interval Error" block:failedBlock];
            return;
        }
        if (![self readEnergyInterval]) {
            [self operationFailedBlockWithMsg:@"Read Energy reporting interval Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        NSString *msg = [self checkMsg];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configMeteringSwitch]) {
            [self operationFailedBlockWithMsg:@"Config Metering switch Error" block:failedBlock];
            return;
        }
        if (!self.isOn) {
            moko_dispatch_main_safe(^{
                if (sucBlock) {
                    sucBlock();
                }
            });
            return;
        }
        if (![self configLoadDetection]) {
            [self operationFailedBlockWithMsg:@"Config Load detection notification Error" block:failedBlock];
            return;
        }
        if (![self configPowerInterval]) {
            [self operationFailedBlockWithMsg:@"Config Power reporting interval Error" block:failedBlock];
            return;
        }
        if (![self configEnergyInterval]) {
            [self operationFailedBlockWithMsg:@"Config Energy reporting interval Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readMeteringSwitch {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readMeteringSwitchWithMacAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMeteringSwitch {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_configMeteringSwitch:self.isOn macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLoadDetection {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readLoadChangeNotificationStatusWithMacAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.loadDetection = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLoadDetection {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_configLoadChangeNotificationStatus:self.loadDetection macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerInterval {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readPowerReportIntervalWithMacAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerInterval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"interval"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPowerInterval {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_configPowerReportInterval:[self.powerInterval integerValue] macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEnergyInterval {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readEnergyReportIntervalWithMacAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.energyInterval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"interval"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEnergyInterval {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_configEnergyReportInterval:[self.energyInterval integerValue] macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)checkMsg {
    if (!self.isOn) {
        return @"";
    }
    if (!ValidStr(self.powerInterval) || [self.powerInterval integerValue] < 1 || [self.powerInterval integerValue] > 86400) {
        return @"Power reporting interval Error";
    }
    if (!ValidStr(self.energyInterval) || [self.energyInterval integerValue] < 1 || [self.energyInterval integerValue] > 1440) {
        return @"Energy reporting interval Error";
    }
    return @"";
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"MeteringSettings"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("MeteringSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
