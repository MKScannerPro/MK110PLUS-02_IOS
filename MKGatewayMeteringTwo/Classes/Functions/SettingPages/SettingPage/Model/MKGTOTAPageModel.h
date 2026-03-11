//
//  MKGTOTAPageModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/11.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerOTAProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTOTAPageModel : NSObject<MKScannerOTAProtocol>

/// 0:Wifi OTA   1:NCP OTA
@property (nonatomic, assign)NSInteger otaType;

@property (nonatomic, copy)NSString *filePath;

@property (nonatomic, copy)void (^receiveOTAResult)(NSInteger result);

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
