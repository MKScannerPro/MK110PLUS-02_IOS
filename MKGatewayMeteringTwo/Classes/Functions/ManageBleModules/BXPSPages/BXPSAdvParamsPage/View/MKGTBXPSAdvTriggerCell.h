//
//  MKGTBXPSAdvTriggerCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGTBXPSAdvTriggerCellSlotType) {
    MKGTBXPSAdvTriggerCellSlotTypeUID,
    MKGTBXPSAdvTriggerCellSlotTypeURL,
    MKGTBXPSAdvTriggerCellSlotTypeTLM,
    MKGTBXPSAdvTriggerCellSlotTypeBeacon,
    MKGTBXPSAdvTriggerCellSlotTypeTHInfo,
    MKGTBXPSAdvTriggerCellSlotTypeSensorInfo,
    MKGTBXPSAdvTriggerCellSlotTypeNoData,
};

@interface MKGTBXPSAdvTriggerCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

@property (nonatomic, assign)MKGTBXPSAdvTriggerCellSlotType slotType;

@property (nonatomic, copy)NSString *advInterval;

/*
 0:-20dBm
 1:-16dBm
 2:-12dBm
 3:-8dBm
 4:-4dBm
 5:0dBm
 6:3dBm
 7:4dBm
 8:6dBm
 */
@property (nonatomic, assign)NSInteger txPower;

- (CGFloat)fetchCellHeight;

@end

@protocol MKGTBXPSAdvTriggerCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)gt_BXPSAdvTriggerCell_setPressed:(NSInteger)index
                                interval:(NSString *)interval
                                 txPower:(NSInteger)txPower;

@end

@interface MKGTBXPSAdvTriggerCell : MKBaseCell

@property (nonatomic, weak)id <MKGTBXPSAdvTriggerCellDelegate>delegate;

@property (nonatomic, strong)MKGTBXPSAdvTriggerCellModel *dataModel;

+ (MKGTBXPSAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
