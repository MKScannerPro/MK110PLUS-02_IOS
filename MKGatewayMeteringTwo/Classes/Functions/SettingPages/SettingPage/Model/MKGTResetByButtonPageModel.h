//
//  MKGTResetByButtonPageModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/11.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerResetByButtonProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTResetByButtonPageModel : NSObject<MKScannerResetByButtonProtocol>

/// 是否支持Disable
@property (nonatomic, assign)BOOL supportDisable;

/// supportDisable=YES   0:Disable 1:Press in 1 minute after powered 2:Press any time
/// supportDisable=NO   0:Press in 1 minute after powered 1:Press any time
@property (nonatomic, assign)NSInteger type;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
