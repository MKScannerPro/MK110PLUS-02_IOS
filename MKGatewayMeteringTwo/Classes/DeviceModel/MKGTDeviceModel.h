//
//  MKGTDeviceModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGatewayDeviceModel.h"

#import "MKGTDeviceModeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTDeviceModel : MKGatewayDeviceModel<MKGTDeviceModeManagerDataProtocol>

/**
 当前model的订阅主题，当用户设置了app的订阅主题时，返回设置的订阅主题，否则返回当前model的订阅主题
 
 @return subscribedTopic
 */
- (NSString *)currentSubscribedTopic;

/**
 当前model的发布主题，当用户设置了app的发布主题时，返回设置的发布主题，否则返回当前model的发布主题
 
 @return publishedTopic
 */
- (NSString *)currentPublishedTopic;


@end

NS_ASSUME_NONNULL_END
