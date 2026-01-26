//
//  MKGTConnectedDeviceWriteAlertView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/11/01.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTConnectedDeviceWriteAlertView : UIView

- (void)showAlertWithValue:(NSString *)value
               dismissNote:(NSString *)dismissNote
              cancelAction:(void (^)(void))cancelAction
             confirmAction:(void (^)(NSString *textValue))confirmAction;

@end

NS_ASSUME_NONNULL_END
