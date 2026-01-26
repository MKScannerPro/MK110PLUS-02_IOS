//
//  MKGTAdvTriggerCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTAdvTriggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *advInterval;

/*
 对于deviceType=23的C112设备，最高支持到0dBm，其余可以支持到+6dBm
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:3dBm
 8:4dBm
 */
@property (nonatomic, assign)NSInteger txPower;

@end

@protocol MKGTAdvTriggerCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: ADV after triggered
///   - txPower: 当前Tx Power
/*
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:3dBm
 8:4dBm
 */
- (void)gt_advTriggerCell_setPressed:(NSInteger)index
                            interval:(NSString *)interval
                             txPower:(NSInteger)txPower;

@end

@interface MKGTAdvTriggerCell : MKBaseCell

@property (nonatomic, weak)id <MKGTAdvTriggerCellDelegate>delegate;

@property (nonatomic, strong)MKGTAdvTriggerCellModel *dataModel;

+ (MKGTAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
