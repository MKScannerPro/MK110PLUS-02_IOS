//
//  MKGTDeviceListCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTDeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)gt_cellDeleteButtonPressed:(NSInteger)index;

@end

@class MKGTDeviceListModel;
@interface MKGTDeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKGTDeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKGTDeviceListModel *dataModel;

+ (MKGTDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
