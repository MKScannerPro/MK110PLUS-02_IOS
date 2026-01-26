//
//  MKGTBXPCHistoricalTHDataHeaderView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTBXPCHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)gt_bxpcHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gt_bxpcHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)gt_bxpcHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKGTBXPCHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKGTBXPCHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
