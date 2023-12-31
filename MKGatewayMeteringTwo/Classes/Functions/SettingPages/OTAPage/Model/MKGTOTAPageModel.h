//
//  MKGTOTAPageModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTOTAPageModel : NSObject

/// 0:Wifi OTA   1:NCP OTA
@property (nonatomic, assign)NSInteger otaType;

@property (nonatomic, copy)NSString *filePath;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
