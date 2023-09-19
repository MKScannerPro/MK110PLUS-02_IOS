//
//  MKGTUserCredentialsView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKGTUserCredentialsViewDelegate <NSObject>

- (void)gt_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)gt_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKGTUserCredentialsView : UIView

@property (nonatomic, strong)MKGTUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKGTUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
