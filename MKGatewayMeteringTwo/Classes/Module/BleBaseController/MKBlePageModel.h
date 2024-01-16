//
//  MKBlePageModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/1/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBlePageModel : NSObject

/// 设备蓝牙断开连接的通知名字
@property (nonatomic, copy, readonly)NSString *notiName;

/// 断开连接后返回的页面类型的字符串
@property (nonatomic, copy, readonly)NSString *backClassName;

+ (MKBlePageModel *)shared;

+ (void)sharedDealloc;

/// 配置参数
/// - Parameters:
///   - notiName: 设备蓝牙断开连接的通知名字
///   - className: 断开连接后返回的页面类型的字符串
- (void)configDisconnectNotification:(NSString *)notiName backToClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
