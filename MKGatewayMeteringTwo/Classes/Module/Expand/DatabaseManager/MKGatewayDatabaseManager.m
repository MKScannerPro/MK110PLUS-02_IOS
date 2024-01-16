//
//  MKGatewayDatabaseManager.m
//  MKGatewayCommonModule_Example
//
//  Created by aa on 2024/1/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKGatewayDatabaseManager.h"

#import <FMDB/FMDB.h>

#import "MKMacroDefines.h"

@implementation MKGatewayDatabaseModel
@end

@implementation MKGatewayDatabaseManager

+ (void)insertWithDatabaseName:(NSString *)database
                     tableName:(NSString *)tableName
                    deviceList:(NSArray <MKGatewayDatabaseModel *>*)deviceList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!deviceList || !ValidStr(database) || !ValidStr(tableName)) {
        [self operationInsertFailedBlock:failedBlock];
        return ;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(database)];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists %@ (deviceType text,clientID text,deviceName text,subscribedTopic text,publishedTopic text,macAddress text,lwtStatus text,lwtTopic text)",tableName];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(database)] inDatabase:^(FMDatabase *db) {
        
        for (MKGatewayDatabaseModel *device in deviceList) {
            BOOL exist = NO;
            FMResultSet * result = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where macAddress = ?",tableName],device.macAddress];
            while (result.next) {
                if ([device.macAddress isEqualToString:[result stringForColumn:@"macAddress"]]) {
                    exist = YES;
                }
            }
            if (exist) {
                //存在该设备，更新设备
                [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET deviceType = ?, clientID = ?, deviceName = ?,subscribedTopic = ?,publishedTopic = ?,lwtStatus = ?,lwtTopic = ? WHERE macAddress = ?",tableName],SafeStr(device.deviceType),SafeStr(device.clientID),SafeStr(device.deviceName),SafeStr(device.subscribedTopic),SafeStr(device.publishedTopic),(device.lwtStatus ? @"1" : @"0"),SafeStr(device.lwtTopic),SafeStr(device.macAddress)];
            }else{
                //不存在，插入设备
                NSString *insertString = [NSString stringWithFormat:@""];
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (deviceType,clientID,deviceName,subscribedTopic,publishedTopic,macAddress,lwtTopic,lwtStatus) VALUES (?,?,?,?,?,?,?,?)",tableName],SafeStr(device.deviceType),SafeStr(device.clientID),SafeStr(device.deviceName),SafeStr(device.subscribedTopic),SafeStr(device.publishedTopic),SafeStr(device.macAddress),SafeStr(device.lwtTopic),(device.lwtStatus ? @"1" : @"0")];
            }
        }
        
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)deleteWithDatabaseName:(NSString *)database
                     tableName:(NSString *)tableName
                    macAddress:(NSString *)macAddress
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(macAddress) || !ValidStr(database) || !ValidStr(tableName)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(database)] inDatabase:^(FMDatabase *db) {
        
        BOOL result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE macAddress = ?",tableName],macAddress];
        if (!result) {
            [self operationDeleteFailedBlock:failedBlock];
            return;
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)readLocalDeviceWithDatabaseName:(NSString *)database
                              tableName:(NSString *)tableName
                               sucBlock:(void (^)(NSArray <NSDictionary *> *deviceList))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(database) || !ValidStr(tableName)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(database)];
    if (![db open]) {
        [self operationGetDataFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(database)] inDatabase:^(FMDatabase *db) {
        NSMutableArray *tempDataList = [NSMutableArray array];
        FMResultSet * result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        while ([result next]) {
            NSDictionary *dic = @{
                @"clientID":SafeStr([result stringForColumn:@"clientID"]),
                @"deviceName":SafeStr([result stringForColumn:@"deviceName"]),
                @"subscribedTopic":SafeStr([result stringForColumn:@"subscribedTopic"]),
                @"publishedTopic":SafeStr([result stringForColumn:@"publishedTopic"]),
                @"macAddress":SafeStr([result stringForColumn:@"macAddress"]),
                @"deviceType":SafeStr([result stringForColumn:@"deviceType"]),
                @"lwtTopic":SafeStr([result stringForColumn:@"lwtTopic"]),
                @"lwtStatus":@([[result stringForColumn:@"lwtStatus"] integerValue] == 1)
            };
        
            [tempDataList addObject:dic];
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock(tempDataList);
            });
        }
        [db close];
    }];
}

+ (void)updateLocalName:(NSString *)localName
             macAddress:(NSString *)macAddress
           databaseName:(NSString *)database
              tableName:(NSString *)tableName
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(database) || !ValidStr(tableName) || !ValidStr(localName) || !ValidStr(macAddress)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(database)];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(database)] inDatabase:^(FMDatabase *db) {
        
        BOOL exist = NO;
        FMResultSet * result = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where macAddress = ?",tableName],macAddress];
        while (result.next) {
            if ([macAddress isEqualToString:[result stringForColumn:@"macAddress"]]) {
                exist = YES;
            }
        }
        if (!exist) {
            [self operationUpdateFailedBlock:failedBlock];
            [db close];
            return;
        }
        //存在该设备，更新设备
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET deviceName = ? WHERE macAddress = ?",tableName],localName,macAddress];
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)updateDeviceWithDatabaseName:(NSString *)database
                           tableName:(NSString *)tableName
                         deviceModel:(MKGatewayDatabaseModel *)deviceModel
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(database) || !ValidStr(tableName)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    if (deviceModel.lwtStatus && !ValidStr(deviceModel.lwtTopic)) {
        [self operationDeleteFailedBlock:failedBlock];
        return;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(database)];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(database)] inDatabase:^(FMDatabase *db) {
        
        BOOL exist = NO;
        FMResultSet * result = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where macAddress = ?",tableName],deviceModel.macAddress];
        while (result.next) {
            if ([deviceModel.macAddress isEqualToString:[result stringForColumn:@"macAddress"]]) {
                exist = YES;
            }
        }
        if (!exist) {
            [self operationUpdateFailedBlock:failedBlock];
            [db close];
            return;
        }
        //存在该设备，更新设备
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET clientID = ?, subscribedTopic = ? ,publishedTopic = ? , lwtStatus = ?,lwtTopic = ? WHERE macAddress = ?",tableName],SafeStr(deviceModel.clientID),SafeStr(deviceModel.subscribedTopic),SafeStr(deviceModel.publishedTopic),(deviceModel.lwtStatus ? @"1" : @"0"),SafeStr(deviceModel.lwtTopic),SafeStr(deviceModel.macAddress)];
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

#pragma mark - Private method
+ (void)operationFailedBlock:(void (^)(NSError *error))block msg:(NSString *)msg{
    if (block) {
        NSError *error = [[NSError alloc] initWithDomain:@"com.moko.databaseOperation"
                                                    code:-111111
                                                userInfo:@{@"errorInfo":msg}];
        moko_dispatch_main_safe(^{
            block(error);
        });
    }
}

+ (void)operationInsertFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"insert data error"];
}

+ (void)operationUpdateFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"update data error"];
}

+ (void)operationDeleteFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"fail to delete"];
}

+ (void)operationGetDataFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"get data error"];
}

@end
