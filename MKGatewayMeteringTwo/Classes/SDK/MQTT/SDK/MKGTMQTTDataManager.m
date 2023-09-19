//
//  MKGTMQTTDataManager.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTMQTTDataManager.h"

#import "MKMacroDefines.h"

#import "MKGTMQTTServerManager.h"

#import "MKGTMQTTOperation.h"

NSString *const MKGTMQTTSessionManagerStateChangedNotification = @"MKGTMQTTSessionManagerStateChangedNotification";

NSString *const MKGTReceiveDeviceOnlineNotification = @"MKGTReceiveDeviceOnlineNotification";
NSString *const MKGTReceiveDeviceNetStateNotification = @"MKGTReceiveDeviceNetStateNotification";
NSString *const MKGTReceiveDeviceOTAResultNotification = @"MKGTReceiveDeviceOTAResultNotification";
NSString *const MKGTReceiveDeviceNpcOTAResultNotification = @"MKGTReceiveDeviceNpcOTAResultNotification";
NSString *const MKGTReceiveDeviceResetByButtonNotification = @"MKGTReceiveDeviceResetByButtonNotification";
NSString *const MKGTReceiveDeviceUpdateEapCertsResultNotification = @"MKGTReceiveDeviceUpdateEapCertsResultNotification";
NSString *const MKGTReceiveDeviceUpdateMqttCertsResultNotification = @"MKGTReceiveDeviceUpdateMqttCertsResultNotification";

NSString *const MKGTReceiveDeviceDatasNotification = @"MKGTReceiveDeviceDatasNotification";
NSString *const MKGTReceiveGatewayDisconnectBXPButtonNotification = @"MKGTReceiveGatewayDisconnectBXPButtonNotification";
NSString *const MKGTReceiveGatewayDisconnectDeviceNotification = @"MKGTReceiveGatewayDisconnectDeviceNotification";
NSString *const MKGTReceiveGatewayConnectedDeviceDatasNotification = @"MKGTReceiveGatewayConnectedDeviceDatasNotification";

NSString *const MKGTReceiveBxpButtonDfuProgressNotification = @"MKGTReceiveBxpButtonDfuProgressNotification";
NSString *const MKGTReceiveBxpButtonDfuResultNotification = @"MKGTReceiveBxpButtonDfuResultNotification";

NSString *const MKGTReceiveDeviceOfflineNotification = @"MKGTReceiveDeviceOfflineNotification";

NSString *const MKGTReceivePowerDataNotification = @"MKGTReceivePowerDataNotification";
NSString *const MKGTReceiveEnergyDataNotification = @"MKGTReceiveEnergyDataNotification";

NSString *const MKGTReceiveLoadChangeNotification = @"MKGTReceiveLoadChangeNotification";


static MKGTMQTTDataManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKGTMQTTDataManager ()

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKGTMQTTDataManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKGTMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKGTMQTTDataManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGTMQTTDataManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKGTMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKGTServerManagerProtocol
- (void)gt_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidDict(data) || !ValidNum(data[@"msg_id"]) || !ValidStr(data[@"device_info"][@"mac"])) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *macAddress = data[@"device_info"][@"mac"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceOnlineNotification
                                                        object:nil
                                                      userInfo:@{@"macAddress":macAddress}];
    if (msgID == 3004) {
        //上报的网络状态
        NSDictionary *resultDic = @{
            @"macAddress":macAddress,
            @"data":data[@"data"]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceNetStateNotification
                                                            object:nil
                                                          userInfo:resultDic];
        return;
    }
    if (msgID == 3007) {
        //固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3014) {
        //设备通过按键恢复出厂设置
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceResetByButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3018) {
        //NCP固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceNpcOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3022) {
        //EAP证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceUpdateEapCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3032) {
        //MQTT证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceUpdateMqttCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3070) {
        //扫描到的数据
        if ([self.dataDelegate respondsToSelector:@selector(mk_gt_receiveDeviceDatas:)]) {
            [self.dataDelegate mk_gt_receiveDeviceDatas:data];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3082) {
        //电量数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceivePowerDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3084) {
        //电能数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveEnergyDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3086) {
        //负载检测
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveLoadChangeNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3108) {
        //网关与已连接的BXP-Button设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveGatewayDisconnectBXPButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3203) {
        //BXP-Button升级进度
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveBxpButtonDfuProgressNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3204) {
        //BXP-Button升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveBxpButtonDfuResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3302) {
        //网关与已连接的蓝牙设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveGatewayDisconnectDeviceNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3311) {
        //网关接收到已连接的蓝牙设备的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveGatewayConnectedDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3999) {
        //遗嘱，设备离线
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGTReceiveDeviceOfflineNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKGTMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:data onTopic:topic];
                break;
            }
        }
    }
}

- (void)gt_didChangeState:(MKGTMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGTMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKGTMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKGTMQTTServerManager shared].serverParams.publishTopic;
}

- (id<MKGTServerParamsProtocol>)currentServerParams {
    return [MKGTMQTTServerManager shared].currentServerParams;
}

- (BOOL)saveServerParams:(id <MKGTServerParamsProtocol>)protocol {
    return [[MKGTMQTTServerManager shared] saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [[MKGTMQTTServerManager shared] clearLocalData];
}

- (BOOL)connect {
    return [[MKGTMQTTServerManager shared] connect];
}

- (void)disconnect {
    if (self.operationQueue.operations.count > 0) {
        [self.operationQueue cancelAllOperations];
    }
    [[MKGTMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKGTMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKGTMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    [[MKGTMQTTServerManager shared] clearAllSubscriptions];
}

- (MKGTMQTTSessionManagerState)state {
    return [MKGTMQTTServerManager shared].state;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gt_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKGTMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gt_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKGTMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    operation.operationTimeout = timeout;
    [self.operationQueue addOperation:operation];
}

#pragma mark - private method

- (MKGTMQTTOperation *)generateOperationWithTaskID:(mk_gt_serverOperationID)taskID
                                              topic:(NSString *)topic
                                        macAddress:(NSString *)macAddress
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKGTMQTTOperation *operation = [[MKGTMQTTOperation alloc] initOperationWithID:taskID macAddress:macAddress commandBlock:^{
        [[MKGTMQTTServerManager shared] sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTDataManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
