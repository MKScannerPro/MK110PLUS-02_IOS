//
//  MKGTSystemTimeCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKGTSystemTimeCellDelegate <NSObject>

- (void)gt_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKGTSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKGTSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKGTSystemTimeCellDelegate>delegate;

+ (MKGTSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
