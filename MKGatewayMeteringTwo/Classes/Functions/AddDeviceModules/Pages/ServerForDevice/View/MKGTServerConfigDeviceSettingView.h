//
//  MKGTServerConfigDeviceSettingView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTServerConfigDeviceSettingViewDelegate <NSObject>

/// 底部按钮
/// @param index 0:Export Demo File   1:Import Config File  2:Clear All Configurations
- (void)gt_mqtt_deviecSetting_fileButtonPressed:(NSInteger)index;

@end

@interface MKGTServerConfigDeviceSettingView : UIView

@property (nonatomic, weak)id <MKGTServerConfigDeviceSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
