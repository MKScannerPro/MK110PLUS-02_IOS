//
//  MKGTPressEventCountCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/19.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTPressEventCountCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *count;

@end

@protocol MKGTPressEventCountCellDelegate <NSObject>

- (void)gt_pressEventCountCell_clearButtonPressed:(NSInteger)index;

@end

@interface MKGTPressEventCountCell : MKBaseCell

@property (nonatomic, weak)id <MKGTPressEventCountCellDelegate>delegate;

@property (nonatomic, strong)MKGTPressEventCountCellModel *dataModel;

+ (MKGTPressEventCountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
