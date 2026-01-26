//
//  MKGTBXPDAccParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBXPDAccParamsModel.h"

#import "MKMacroDefines.h"

#import "MKGTDeviceModeManager.h"

#import "MKGTMQTTInterface.h"

#import "MKMacroDefines.h"

#import "MKGTDeviceModeManager.h"

#import "MKGTMQTTInterface.h"

@interface MKGTBXPDAccParamsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGTBXPDAccParamsModel

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAccAdvParams:bleMac]) {
            [self operationFailedBlockWithMsg:@"Read Params Error" block:failedBlock];
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
        if (![self configAccAdvParams:bleMac]) {
            [self operationFailedBlockWithMsg:@"Config Params Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readAccAdvParams:(NSString *)bleMac {
    __block BOOL success = NO;
    [MKGTMQTTInterface gt_readBXPDAccParamsWithBleMacAddress:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.scale = [returnData[@"data"][@"full_scale"] integerValue];
        self.sampleRate = [returnData[@"data"][@"sampling_rate"] integerValue];
        self.sensitivity = [NSString stringWithFormat:@"%@",returnData[@"data"][@"sensitivity"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAccAdvParams:(NSString *)bleMac {
    __block BOOL success = NO;
    
    [MKGTMQTTInterface gt_configBXPDAccParamsWithScale:self.scale sampleRate:self.sampleRate sensitivity:[self.sensitivity integerValue] bleMac:bleMac macAddress:[MKGTDeviceModeManager shared].macAddress topic:[MKGTDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"BXPDAccParams"
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
