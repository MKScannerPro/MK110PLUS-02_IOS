//
//  MKGTNTPServerModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerNTPServerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTNTPServerModel : NSObject<MKScannerNTPServerProtocol>

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *host;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
