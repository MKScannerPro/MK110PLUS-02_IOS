//
//  MKGTPirSensorParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTPirSensorParamsModel.h"

#import "MKMacroDefines.h"

#import "MKGTDeviceModeManager.h"

#import "MKGTMQTTInterface.h"

#import "MKMacroDefines.h"

#import "MKGTDeviceModeManager.h"

#import "MKGTMQTTInterface.h"

@interface MKGTPirSensorParamsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGTPirSensorParamsModel

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSensitivity:bleMac]) {
            [self operationFailedBlockWithMsg:@"Read Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self readDelay:bleMac]) {
            [self operationFailedBlockWithMsg:@"Read Delay Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithBleMac:(NSString *)bleMac
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configSensitivity:bleMac]) {
            [self operationFailedBlockWithMsg:@"Config Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self configDelay:bleMac]) {
            [self operationFailedBlockWithMsg:@"Config Delay Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readSensitivity:(NSString *)bleMac {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readMKPirSensorSensitivityWithBleMac:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sensitivity = [returnData[@"data"][@"sensitivity"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSensitivity:(NSString *)bleMac {
    __block BOOL success = NO;
    
    [MKGTMQTTInterface gt_configMKPirSensorSensitivityWithBleMac:bleMac sensitivity:self.sensitivity macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

- (BOOL)readDelay:(NSString *)bleMac {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readMKPirSensorDelayWithBleMac:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.delay = [returnData[@"data"][@"delay_status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDelay:(NSString *)bleMac {
    __block BOOL success = NO;
    
    [MKGTMQTTInterface gt_configMKPirSensorDelayWithBleMac:bleMac delay:self.delay macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

#pragma mark - private method


- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"PirSensorParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("BXPDAccParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
