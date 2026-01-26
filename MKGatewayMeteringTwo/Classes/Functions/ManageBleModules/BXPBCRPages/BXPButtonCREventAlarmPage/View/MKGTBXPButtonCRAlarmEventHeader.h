//
//  MKGTBXPButtonCRAlarmEventHeader.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTBXPButtonCRAlarmEventHeaderDelegate <NSObject>

- (void)gt_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gt_bxpButtonCRAlarmEventHeaderView_exportButtonPressed;

@end

@interface MKGTBXPButtonCRAlarmEventHeader : UIView

@property (nonatomic, weak)id <MKGTBXPButtonCRAlarmEventHeaderDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
