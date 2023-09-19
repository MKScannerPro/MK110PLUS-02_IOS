//
//  MKGTFilterCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKGTFilterCellDelegate <NSObject>

- (void)gt_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKGTFilterCell : MKBaseCell

@property (nonatomic, strong)MKGTFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKGTFilterCellDelegate>delegate;

+ (MKGTFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
