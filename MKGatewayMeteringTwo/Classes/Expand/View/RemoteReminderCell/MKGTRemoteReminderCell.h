//
//  MKGTRemoteReminderCell.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTRemoteReminderCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKGTRemoteReminderCellDelegate <NSObject>

- (void)bxd_remindButtonPressed:(NSInteger)index;

@end

@interface MKGTRemoteReminderCell : MKBaseCell

@property (nonatomic, strong)MKGTRemoteReminderCellModel *dataModel;

@property (nonatomic, weak)id <MKGTRemoteReminderCellDelegate>delegate;

+ (MKGTRemoteReminderCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
