//
//  MKGTBXPButtonCRAlarmEventModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTBXPButtonCRAlarmEventModel : NSObject

- (void)notifyDataWithBleMac:(NSString *)bleMac
                      notify:(BOOL)notify
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
