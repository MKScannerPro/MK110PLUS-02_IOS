//
//  MKGTWifiSettingsBandCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTWifiSettingsBandCellModel : NSObject

@property (nonatomic, assign)NSInteger country;

@end

@protocol MKGTWifiSettingsBandCellDelegate <NSObject>

- (void)gt_wifiSettingsBandCell_countryChanged:(NSInteger)country;

@end

@interface MKGTWifiSettingsBandCell : MKBaseCell

@property (nonatomic, strong)MKGTWifiSettingsBandCellModel *dataModel;

@property (nonatomic, weak)id <MKGTWifiSettingsBandCellDelegate>delegate;

+ (MKGTWifiSettingsBandCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
