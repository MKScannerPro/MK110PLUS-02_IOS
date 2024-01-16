//
//  MKGTFilterBeaconCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKGTFilterBeaconCellDelegate <NSObject>

- (void)mk_gt_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_gt_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKGTFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKGTFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKGTFilterBeaconCellDelegate>delegate;

+ (MKGTFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
