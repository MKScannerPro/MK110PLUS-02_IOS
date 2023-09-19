//
//  MKGTDeviceDataPageHeaderView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTDeviceDataPageHeaderViewModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@end

@protocol MKGTDeviceDataPageHeaderViewDelegate <NSObject>

- (void)gt_updateLoadButtonAction;

- (void)gt_powerButtonAction;

- (void)gt_scannerStatusChanged:(BOOL)isOn;

- (void)gt_manageBleDeviceAction;

@end

@interface MKGTDeviceDataPageHeaderView : UIView

@property (nonatomic, strong)MKGTDeviceDataPageHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKGTDeviceDataPageHeaderViewDelegate>delegate;

- (void)updateTotalNumbers:(NSInteger)numbers;

@end

NS_ASSUME_NONNULL_END
