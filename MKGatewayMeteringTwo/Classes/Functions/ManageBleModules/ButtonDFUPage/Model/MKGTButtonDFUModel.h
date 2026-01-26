//
//  MKGTButtonDFUModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/11/01.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTButtonDFUModel : NSObject

@property (nonatomic, copy)NSString *bleMac;

@property (nonatomic, copy)NSString *firmwareUrl;

@property (nonatomic, copy)NSString *dataUrl;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
