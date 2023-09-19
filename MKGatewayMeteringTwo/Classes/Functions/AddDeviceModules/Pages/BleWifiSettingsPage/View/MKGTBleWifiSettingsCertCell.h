//
//  MKGTBleWifiSettingsCertCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/1/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTBleWifiSettingsCertCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKGTBleWifiSettingsCertCellDelegate <NSObject>

- (void)gt_bleWifiSettingsCertPressed:(NSInteger)index;

@end

@interface MKGTBleWifiSettingsCertCell : MKBaseCell

@property (nonatomic, strong)MKGTBleWifiSettingsCertCellModel *dataModel;

@property (nonatomic, weak)id <MKGTBleWifiSettingsCertCellDelegate>delegate;

+ (MKGTBleWifiSettingsCertCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
