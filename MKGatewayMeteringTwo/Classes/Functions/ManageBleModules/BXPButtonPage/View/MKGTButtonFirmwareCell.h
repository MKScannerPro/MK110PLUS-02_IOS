//
//  MKGTButtonFirmwareCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTButtonFirmwareCellModel : NSObject

/// cell唯一识别号
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@property (nonatomic, copy)NSString *rightButtonTitle;

@end

@protocol MKGTButtonFirmwareCellDelegate <NSObject>

- (void)gt_buttonFirmwareCell_buttonAction:(NSInteger)index;

@end

@interface MKGTButtonFirmwareCell : MKBaseCell

@property (nonatomic, strong)MKGTButtonFirmwareCellModel *dataModel;

@property (nonatomic, weak)id <MKGTButtonFirmwareCellDelegate>delegate;

+ (MKGTButtonFirmwareCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
