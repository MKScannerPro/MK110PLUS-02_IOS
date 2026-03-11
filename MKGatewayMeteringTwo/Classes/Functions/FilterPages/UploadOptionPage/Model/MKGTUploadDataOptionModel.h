//
//  MKGTUploadDataOptionModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerUploadDataOptionV2Protocol.h"

#import "MKGTMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTUploadDataOptionModel : NSObject<MKScannerUploadDataOptionV2Protocol,gt_uploadDataOptionProtocol>

/// V2版本固件
@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, assign)BOOL timestamp;

/// V1中有此参数
@property (nonatomic, assign)BOOL rawData_advertising;

/// V1中有此参数
@property (nonatomic, assign)BOOL rawData_response;

/// V2中有此参数
@property (nonatomic, assign)BOOL adv_data;

/// V2中有此参数
@property (nonatomic, assign)BOOL parse_adv_data;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
