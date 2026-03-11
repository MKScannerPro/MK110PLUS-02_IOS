//
//  MKGTSystemTimeModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/11.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerSystemTimeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTSystemTimeModel : NSObject<MKScannerSystemTimeProtocol>

- (id <MKScannerNTPServerProtocol>)ntpServerProtocol;

- (void)readUTCTimeDataWithSucBlock:(void (^)(NSDictionary *dic))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configTimezone:(NSInteger)timeZone
             timestamp:(NSTimeInterval)timestamp
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
