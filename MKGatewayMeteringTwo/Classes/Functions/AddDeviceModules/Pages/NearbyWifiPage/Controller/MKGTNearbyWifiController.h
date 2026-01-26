//
//  MKGTNearbyWifiController.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/9/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTNearbyWifiControllerDelegate <NSObject>

- (void)gt_nearbyWifiController_selectedWifi:(NSString *)ssid;

@end

@interface MKGTNearbyWifiController : MKBaseViewController

@property (nonatomic, weak)id <MKGTNearbyWifiControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
