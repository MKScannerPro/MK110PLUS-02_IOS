//
//  MKGTScanPageCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKGTScanPageModel;
@interface MKGTScanPageCell : MKBaseCell

@property (nonatomic, strong)MKGTScanPageModel *dataModel;

+ (MKGTScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
