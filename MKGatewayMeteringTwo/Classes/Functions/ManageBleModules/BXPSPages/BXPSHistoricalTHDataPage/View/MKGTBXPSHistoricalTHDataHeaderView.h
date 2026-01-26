//
//  MKGTBXPSHistoricalTHDataHeaderView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTBXPSHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)gt_BXPSHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gt_BXPSHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)gt_BXPSHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKGTBXPSHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKGTBXPSHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
