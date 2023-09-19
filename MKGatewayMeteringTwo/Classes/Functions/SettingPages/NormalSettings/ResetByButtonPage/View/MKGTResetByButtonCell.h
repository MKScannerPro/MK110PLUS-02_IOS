//
//  MKGTResetByButtonCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTResetByButtonCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKGTResetByButtonCellDelegate <NSObject>

- (void)gt_resetByButtonCellAction:(NSInteger)index;

@end

@interface MKGTResetByButtonCell : MKBaseCell

@property (nonatomic, weak)id <MKGTResetByButtonCellDelegate>delegate;

@property (nonatomic, strong)MKGTResetByButtonCellModel *dataModel;

+ (MKGTResetByButtonCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
