//
//  MKGTFilterByPirModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGTMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTFilterByPirModel : NSObject<mk_gt_BLEFilterPirProtocol>

@property (nonatomic, assign)BOOL isOn;

/// 0：low delay 1：medium delay 2：high delay 3：all type
@property (nonatomic, assign)NSInteger delayRespneseStatus;

/// 0：close 1：open 2：all type
@property (nonatomic, assign)NSInteger doorStatus;

/// 0：low sensitivity 1：medium sensitivity 2：high sensitivity 3：all type
@property (nonatomic, assign)NSInteger sensorSensitivity;

/// 0：no effective motion detected 1：effective motion detected 2：all type
@property (nonatomic, assign)NSInteger sensorDetectionStatus;

@property (nonatomic, copy)NSString *minMajor;

@property (nonatomic, copy)NSString *maxMajor;

@property (nonatomic, copy)NSString *minMinor;

@property (nonatomic, copy)NSString *maxMinor;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
