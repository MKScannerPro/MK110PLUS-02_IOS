//
//  MKGTManageBleDevicesTypeSelectedCell.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTManageBleDevicesTypeSelectedCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKGTManageBleDevicesTypeSelectedCellModel
@end

@interface MKGTManageBleDevicesTypeSelectedCell ()

@property (nonatomic, strong)UIControl *backControl;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIImageView *selectedIcon;

@end

@implementation MKGTManageBleDevicesTypeSelectedCell

+ (MKGTManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView {
    MKGTManageBleDevicesTypeSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGTManageBleDevicesTypeSelectedCellIdenty"];
    if (!cell) {
        cell = [[MKGTManageBleDevicesTypeSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGTManageBleDevicesTypeSelectedCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_WHITE_MACROS;
        [self.contentView addSubview:self.backControl];
        [self.backControl addSubview:self.msgLabel];
        [self.backControl addSubview:self.selectedIcon];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.selectedIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(15.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectedIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-25.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)selectedCurrentCell {
    self.backControl.selected = !self.backControl.selected;
    self.selectedIcon.image = (self.backControl.selected ? LOADICON(@"MKGatewayMeteringTwo", @"MKGTManageBleDevicesTypeSelectedCell", @"gt_listButtonSelectedIcon.png") : LOADICON(@"MKGatewayMeteringTwo", @"MKGTManageBleDevicesTypeSelectedCell", @"gt_listButtonUnselectedIcon.png"));
    if ([self.delegate respondsToSelector:@selector(gt_manageBleDevicesTypeSelectedCell_selected:index:)]) {
        [self.delegate gt_manageBleDevicesTypeSelectedCell_selected:self.backControl.selected index:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGTManageBleDevicesTypeSelectedCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGTManageBleDevicesTypeSelectedCellModel.class]) {
        return;
    }
    self.selectedIcon.image = (_dataModel.selected ? LOADICON(@"MKGatewayMeteringTwo", @"MKGTManageBleDevicesTypeSelectedCell", @"gt_listButtonSelectedIcon.png") : LOADICON(@"MKGatewayMeteringTwo", @"MKGTManageBleDevicesTypeSelectedCell", @"gt_listButtonUnselectedIcon.png"));
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc] init];
        _backControl.backgroundColor = COLOR_WHITE_MACROS;
        [_backControl addTarget:self
                         action:@selector(selectedCurrentCell)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _backControl;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(14.f);
    }
    return _msgLabel;
}

- (UIImageView *)selectedIcon {
    if (!_selectedIcon) {
        _selectedIcon = [[UIImageView alloc] init];
    }
    return _selectedIcon;
}

@end
