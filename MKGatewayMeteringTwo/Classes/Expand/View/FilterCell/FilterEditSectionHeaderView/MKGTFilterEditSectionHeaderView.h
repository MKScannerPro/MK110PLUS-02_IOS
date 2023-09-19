//
//  MKGTFilterEditSectionHeaderView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKGTFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_gt_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_gt_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKGTFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKGTFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKGTFilterEditSectionHeaderViewDelegate>delegate;

+ (MKGTFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
