//
//  MKGTBXPSAdvTriggerTwoStateCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGTBXPSAdvTriggerTwoStateCellSlotType) {
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeUID,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeURL,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeTLM,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeBeacon,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeTHInfo,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeSensorInfo,
    MKGTBXPSAdvTriggerTwoStateCellSlotTypeNoData,
};

@interface MKGTBXPSAdvTriggerTwoStateCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

@property (nonatomic, assign)MKGTBXPSAdvTriggerTwoStateCellSlotType beforeSlotType;

@property (nonatomic, copy)NSString *beforeTriggerInterval;

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
@property (nonatomic, assign)NSInteger beforeTriggerTxPower;

@property (nonatomic, assign)MKGTBXPSAdvTriggerTwoStateCellSlotType afterSlotType;

@property (nonatomic, copy)NSString *afterTriggerInterval;

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
@property (nonatomic, assign)NSInteger afterTriggerTxPower;

- (CGFloat)fetchCellHeight;

@end

@protocol MKGTBXPSAdvTriggerTwoStateCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - beforeInterval: ADV before triggered ADV interval
///   - beforeTxPower: ADV before triggered Tx Power
///   - afterInterval: ADV after triggered ADV interval
///   - afterTxPower: ADV after triggered Tx Power
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
- (void)gt_BXPSAdvTriggerTwoStateCell_setPressed:(NSInteger)index
                                  beforeInterval:(NSString *)beforeInterval
                                   beforeTxPower:(NSInteger)beforeTxPower
                                   afterInterval:(NSString *)afterInterval
                                    afterTxPower:(NSInteger)afterTxPower;

@end

@interface MKGTBXPSAdvTriggerTwoStateCell : MKBaseCell

@property (nonatomic, weak)id <MKGTBXPSAdvTriggerTwoStateCellDelegate>delegate;

@property (nonatomic, strong)MKGTBXPSAdvTriggerTwoStateCellModel *dataModel;

+ (MKGTBXPSAdvTriggerTwoStateCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
