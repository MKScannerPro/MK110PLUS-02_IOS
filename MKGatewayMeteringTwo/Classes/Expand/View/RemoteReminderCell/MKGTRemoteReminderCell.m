//
//  MKGTRemoteReminderCell.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTRemoteReminderCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@implementation MKGTRemoteReminderCellModel
@end

@interface MKGTRemoteReminderCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *remindButton;

@end

@implementation MKGTRemoteReminderCell

+ (MKGTRemoteReminderCell *)initCellWithTableView:(UITableView *)tableView {
    MKGTRemoteReminderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGTRemoteReminderCellIdenty"];
    if (!cell) {
        cell = [[MKGTRemoteReminderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGTRemoteReminderCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.remindButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.remindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(35.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.remindButton.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)remindButtonPressed {
    if ([self.delegate respondsToSelector:@selector(bxd_remindButtonPressed:)]) {
        [self.delegate bxd_remindButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGTRemoteReminderCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGTRemoteReminderCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UIButton *)remindButton {
    if (!_remindButton) {
        _remindButton = [MKCustomUIAdopter customButtonWithTitle:@"Remind"
                                                          target:self
                                                          action:@selector(remindButtonPressed)];
    }
    return _remindButton;
}

@end
