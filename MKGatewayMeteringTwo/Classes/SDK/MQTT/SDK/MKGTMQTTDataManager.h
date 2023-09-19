//
//  MKGTMQTTDataManager.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGTServerConfigDefines.h"

#import "MKGTMQTTTaskID.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MKGTMQTTSessionManagerStateChangedNotification;

extern NSString *const MKGTReceiveDeviceOnlineNotification;

extern NSString *const MKGTReceiveDeviceOTAResultNotification;

extern NSString *const MKGTReceiveDeviceNpcOTAResultNotification;

extern NSString *const MKGTReceiveDeviceResetByButtonNotification;

extern NSString *const MKGTReceiveDeviceUpdateEapCertsResultNotification;

extern NSString *const MKGTReceiveDeviceUpdateMqttCertsResultNotification;

extern NSString *const MKGTReceiveDeviceNetStateNotification;

extern NSString *const MKGTReceiveDeviceDatasNotification;

extern NSString *const MKGTReceiveGatewayDisconnectBXPButtonNotification;

extern NSString *const MKGTReceiveGatewayDisconnectDeviceNotification;

extern NSString *const MKGTReceiveGatewayConnectedDeviceDatasNotification;

extern NSString *const MKGTReceiveBxpButtonDfuProgressNotification;

extern NSString *const MKGTReceiveBxpButtonDfuResultNotification;


extern NSString *const MKGTReceiveDeviceOfflineNotification;

extern NSString *const MKGTReceivePowerDataNotification;

extern NSString *const MKGTReceiveEnergyDataNotification;

extern NSString *const MKGTReceiveLoadChangeNotification;

@protocol MKGTReceiveDeviceDatasDelegate <NSObject>

- (void)mk_gt_receiveDeviceDatas:(NSDictionary *)data;

@end

@interface MKGTMQTTDataManager : NSObject<MKGTServerManagerProtocol>

@property (nonatomic, weak)id <MKGTReceiveDeviceDatasDelegate>dataDelegate;

@property (nonatomic, assign, readonly)MKGTMQTTSessionManagerState state;

+ (MKGTMQTTDataManager *)shared;

+ (void)singleDealloc;

/// 当前app连接服务器参数
@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKGTServerParamsProtocol>serverParams;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentSubscribeTopic)NSString *subscribeTopic;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentPublishedTopic)NSString *publishedTopic;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKGTServerParamsProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

- (void)disconnect;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

- (void)clearAllSubscriptions;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gt_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param timeout 任务超时时间
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gt_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
