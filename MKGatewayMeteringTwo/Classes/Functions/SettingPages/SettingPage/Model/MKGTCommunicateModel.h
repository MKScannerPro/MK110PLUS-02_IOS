//
//  MKGTCommunicateModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerCommunicateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTCommunicateModel : NSObject<MKScannerCommunicateProtocol>

@property (nonatomic, copy)NSString *timeout;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
