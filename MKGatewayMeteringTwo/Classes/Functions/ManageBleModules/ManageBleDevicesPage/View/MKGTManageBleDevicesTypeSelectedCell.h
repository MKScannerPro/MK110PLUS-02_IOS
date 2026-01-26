//
//  MKGTManageBleDevicesTypeSelectedCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTManageBleDevicesTypeSelectedCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKGTManageBleDevicesTypeSelectedCellDelegate <NSObject>

- (void)gt_manageBleDevicesTypeSelectedCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKGTManageBleDevicesTypeSelectedCell : UITableViewCell

@property (nonatomic, weak)id <MKGTManageBleDevicesTypeSelectedCellDelegate>delegate;

@property (nonatomic, strong)MKGTManageBleDevicesTypeSelectedCellModel *dataModel;

+ (MKGTManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
