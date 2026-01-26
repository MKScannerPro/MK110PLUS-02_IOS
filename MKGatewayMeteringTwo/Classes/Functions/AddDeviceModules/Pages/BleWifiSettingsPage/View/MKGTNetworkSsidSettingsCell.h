//
//  MKGTNetworkSsidSettingsCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/9/1.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTNetworkSsidSettingsCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@end

@protocol MKGTNetworkSsidSettingsCellDelegate <NSObject>

- (void)gt_networkSsidSettingsCell_ssidChanged:(NSString *)ssid;

- (void)gt_networkSsidSettingsCell_buttonPressed;

@end

@interface MKGTNetworkSsidSettingsCell : MKBaseCell

@property (nonatomic, strong)MKGTNetworkSsidSettingsCellModel *dataModel;

@property (nonatomic, weak)id <MKGTNetworkSsidSettingsCellDelegate>delegate;

+ (MKGTNetworkSsidSettingsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
