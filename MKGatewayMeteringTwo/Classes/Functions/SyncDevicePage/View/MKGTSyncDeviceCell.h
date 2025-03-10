//
//  MKGTSyncDeviceCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

#import "MKGTDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTSyncDeviceCellModel : MKGTDeviceModel

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKGTSyncDeviceCellDelegate <NSObject>

- (void)gt_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKGTSyncDeviceCell : MKBaseCell

@property (nonatomic, strong)MKGTSyncDeviceCellModel *dataModel;

@property (nonatomic, weak)id <MKGTSyncDeviceCellDelegate>delegate;

+ (MKGTSyncDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
