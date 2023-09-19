//
//  MKGTMQTTServerManager.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseMQTTModule/MKMQTTServerManager.h>

#import "MKGTServerConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTMQTTServerManager : NSObject<MKMQTTServerProtocol>

@property (nonatomic, assign, readonly)MKGTMQTTSessionManagerState state;

@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKGTServerParamsProtocol>serverParams;

@property (nonatomic, strong, readonly)NSMutableArray <id <MKGTServerManagerProtocol>>*managerList;

+ (MKGTMQTTServerManager *)shared;

/// 销毁单例
+ (void)singleDealloc;

/// 将一个满足MKGTServerManagerProtocol的对象加入到管理列表
/// @param dataManager MKGTServerManagerProtocol
- (void)loadDataManager:(nonnull id <MKGTServerManagerProtocol>)dataManager;

/// 将满足MKGTServerManagerProtocol的对象移除管理列表
/// @param dataManager MKGTServerManagerProtocol的对象
- (BOOL)removeDataManager:(nonnull id <MKGTServerManagerProtocol>)dataManager;

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

/// 如果是从壳工程进入的设备列表页面，接收不到需要网络改变导致需要联网的通知，所以需要走网络改变的流程
- (void)startWork;

- (void)disconnect;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

- (void)clearAllSubscriptions;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        sucBlock:(void (^)(void))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
