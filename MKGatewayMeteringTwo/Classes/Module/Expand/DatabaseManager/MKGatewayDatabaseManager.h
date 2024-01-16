//
//  MKGatewayDatabaseManager.h
//  MKGatewayCommonModule_Example
//
//  Created by aa on 2024/1/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGatewayDatabaseModel : NSObject

/// 设备类型
@property (nonatomic, copy)NSString *deviceType;

/// MTQQ通信所需的ID，如果存在重复的，会出现交替上线的情况
@property (nonatomic, copy)NSString *clientID;

/**
 设备广播名字
 */
@property (nonatomic, copy)NSString *deviceName;

/**
 订阅主题
 */
@property (nonatomic, copy)NSString *subscribedTopic;

/**
 发布主题
 */
@property (nonatomic, copy)NSString *publishedTopic;

/**
 mac地址，注意此处用的是wifi的mac而非ble的
 */
@property (nonatomic, copy)NSString *macAddress;

/// 遗言是否打开，如果用户设置了遗言topic，则也需要订阅
@property (nonatomic, assign)BOOL lwtStatus;

/// 遗言topic，如果用户设置了遗言topic，则也需要订阅
@property (nonatomic, copy)NSString *lwtTopic;

@end

@interface MKGatewayDatabaseManager : NSObject

/// 设备入库，key为mac地址，如果本地已经存在则覆盖，不存在则插入
/// - Parameters:
///   - database: 本地数据库的名字
///   - tableName: 数据库中数据表的名字
///   - deviceList: 要入库的设备列表
///   - sucBlock: 入库成功回调
///   - failedBlock: 入库失败回调
+ (void)insertWithDatabaseName:(NSString *)database
                     tableName:(NSString *)tableName
                    deviceList:(NSArray <MKGatewayDatabaseModel *>*)deviceList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 删除本地数据库指定mac地址的设备
/// - Parameters:
///   - database: 本地数据库的名字
///   - tableName: 数据库中数据表的名字
///   - macAddress: 要删除的设备的mac地址
///   - sucBlock: 删除成功回调
///   - failedBlock: 删除失败回调
+ (void)deleteWithDatabaseName:(NSString *)database
                     tableName:(NSString *)tableName
                    macAddress:(NSString *)macAddress
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取本地设备列表
/*
 读取成功之后，返回的是NSDictionary数组
 @{
    @"clientID":"clientID",
    @"deviceName":"deviceName",
    @"subscribedTopic":"subscribedTopic",
    @"publishedTopic":"publishedTopic",
    @"macAddress":"macAddress",
    @"deviceType":"deviceType",
    @"lwtTopic":"lwtTopic",
    @"lwtStatus":@(YES),
 }
 */
/// @param database 本地数据库的名字
/// @param tableName 数据库中数据表的名字
/// @param sucBlock 读取成功回调
/// @param failedBlock 读取失败回调
+ (void)readLocalDeviceWithDatabaseName:(NSString *)database
                              tableName:(NSString *)tableName
                               sucBlock:(void (^)(NSArray <NSDictionary *> *deviceList))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// 更新本地存储的名字
/// @param localName 要更新的名字
/// @param macAddress 本地存储的key
/// @param database 本地数据库的名字
/// @param tableName 数据库中数据表的名字
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
+ (void)updateLocalName:(NSString *)localName
             macAddress:(NSString *)macAddress
           databaseName:(NSString *)database
              tableName:(NSString *)tableName
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// 更新本地数据库，注意，目前这个不会更新本地存储的localName和deviceType
/// @param database 本地数据库的名字
/// @param tableName 数据库中数据表的名字
/// @param deviceModel 要更新的model
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调

+ (void)updateDeviceWithDatabaseName:(NSString *)database
                           tableName:(NSString *)tableName
                         deviceModel:(MKGatewayDatabaseModel *)deviceModel
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
