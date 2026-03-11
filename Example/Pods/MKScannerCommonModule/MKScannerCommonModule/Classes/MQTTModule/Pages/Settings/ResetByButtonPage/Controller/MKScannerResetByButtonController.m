//
//  MKScannerResetByButtonController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerResetByButtonController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"

#import "MKScannerResetByButtonCell.h"

typedef NS_ENUM(NSInteger, MKResetButtonType) {
    MKResetButtonTypeDisable = 0,           // 禁用
    MKResetButtonTypeAfterPowered = 1,       // 上电后1分钟内
    MKResetButtonTypeAnyTime = 2             // 任意时间
};

@interface MKScannerResetByButtonController () <UITableViewDelegate, UITableViewDataSource, MKScannerResetByButtonCellDelegate>

@property (nonatomic, strong) MKBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *section0List;  // Disable选项（仅在支持且Debug模式下显示）
@property (nonatomic, strong) NSMutableArray *section1List;  // 其他选项
@property (nonatomic, strong) id<MKScannerResetByButtonProtocol> protocol;

@end

@implementation MKScannerResetByButtonController

#pragma mark - Lifecycle

- (void)dealloc {
    NSLog(@"MKScannerResetByButtonController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerResetByButtonProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 根据Disable选项是否显示，动态返回section数量
    BOOL shouldShowDisable = [self shouldShowDisableSection];
    return shouldShowDisable ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if ([self shouldShowDisableSection]) {
            return self.section0List.count;
        } else {
            return self.section1List.count;
        }
    }
    // section1
    return self.section1List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKScannerResetByButtonCell *cell = [MKScannerResetByButtonCell initCellWithTableView:tableView];
    
    if ([self shouldShowDisableSection]) {
        if (indexPath.section == 0) {
            cell.dataModel = self.section0List[indexPath.row];
        } else {
            cell.dataModel = self.section1List[indexPath.row];
        }
    } else {
        // 不显示Disable时，所有数据都在section1List中
        cell.dataModel = self.section1List[indexPath.row];
    }
    
    cell.delegate = self;
    return cell;
}

#pragma mark - MKScannerResetByButtonCellDelegate

- (void)mk_scanner_resetByButtonCellAction:(NSInteger)index {
    // 根据选择的索引更新协议type
    [self updateProtocolTypeWithSelectedIndex:index];
    [self configDataToDevice];
}

#pragma mark - Data Operations

/// 判断是否需要显示Disable选项的section
- (BOOL)shouldShowDisableSection {
#ifdef DEBUG
    // Debug模式下：协议支持时才显示
    return self.protocol.supportDisable;
#else
    // Release模式下：永远不显示Disable选项
    return NO;
#endif
}

/// 从设备读取数据
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError *error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

/// 配置数据到设备
- (void)configDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Setup succeed!"];
        [self updateCellSelectionState];
    } failedBlock:^(NSError *error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

/// 更新Cell选中状态
- (void)updateCellSelectionState {
    // 更新section0的选中状态（如果存在）
    if ([self shouldShowDisableSection] && self.section0List.count > 0) {
        MKScannerResetByButtonCellModel *disableModel = self.section0List[0];
        disableModel.selected = (self.protocol.type == MKResetButtonTypeDisable);
    }
    
    // 更新section1的选中状态
    for (MKScannerResetByButtonCellModel *model in self.section1List) {
        model.selected = [self isCellSelectedForIndex:model.index];
    }
    
    [self.tableView reloadData];
}

/// 判断指定索引的Cell是否应该被选中
- (BOOL)isCellSelectedForIndex:(NSInteger)index {
    if (self.protocol.supportDisable) {
        // 支持Disable时：type值直接对应选项
        return (self.protocol.type == index);
    } else {
        // 不支持Disable时：需要映射关系
        // type=0 -> AfterPowered(index=1)
        // type=1 -> AnyTime(index=2)
        if (index == MKResetButtonTypeAfterPowered) {
            return (self.protocol.type == 0);
        } else if (index == MKResetButtonTypeAnyTime) {
            return (self.protocol.type == 1);
        }
        return NO;
    }
}

/// 更新协议type值（根据用户选择的索引）
- (void)updateProtocolTypeWithSelectedIndex:(NSInteger)selectedIndex {
    if (self.protocol.supportDisable) {
        // 支持Disable时：直接使用选择的索引作为type
        self.protocol.type = selectedIndex;
    } else {
        // 不支持Disable时：需要映射
        // AfterPowered(index=1) -> type=0
        // AnyTime(index=2) -> type=1
        if (selectedIndex == MKResetButtonTypeAfterPowered) {
            self.protocol.type = 0;
        } else if (selectedIndex == MKResetButtonTypeAnyTime) {
            self.protocol.type = 1;
        }
    }
}

#pragma mark - Load Section Datas

- (void)loadSectionDatas {
    // 清空旧数据
    [self.section0List removeAllObjects];
    [self.section1List removeAllObjects];
    
    // 加载Disable选项（仅在需要显示时）
    if ([self shouldShowDisableSection]) {
        [self loadDisableSectionData];
    }
    
    // 加载其他选项
    [self loadOtherOptionsData];
    
    [self.tableView reloadData];
}

/// 加载Disable选项数据
- (void)loadDisableSectionData {
    BOOL selected = (self.protocol.type == MKResetButtonTypeDisable);
    
    MKScannerResetByButtonCellModel *cellModel = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel.index = MKResetButtonTypeDisable;
    cellModel.msg = @"Disable";
    cellModel.selected = selected;
    [self.section0List addObject:cellModel];
}

/// 加载其他选项数据
- (void)loadOtherOptionsData {
    BOOL afterPoweredSelected = NO;
    BOOL anyTimeSelected = NO;
    
    if (self.protocol.supportDisable) {
        // 支持Disable时：type直接对应
        afterPoweredSelected = (self.protocol.type == MKResetButtonTypeAfterPowered);
        anyTimeSelected = (self.protocol.type == MKResetButtonTypeAnyTime);
    } else {
        // 不支持Disable时：需要映射
        afterPoweredSelected = (self.protocol.type == 0);
        anyTimeSelected = (self.protocol.type == 1);
    }
    
    // Press in 1 minute after powered
    MKScannerResetByButtonCellModel *cellModel1 = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel1.index = MKResetButtonTypeAfterPowered;
    cellModel1.msg = @"Press in 1 minute after powered";
    cellModel1.selected = afterPoweredSelected;
    [self.section1List addObject:cellModel1];
    
    // Press any time
    MKScannerResetByButtonCellModel *cellModel2 = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel2.index = MKResetButtonTypeAnyTime;
    cellModel2.msg = @"Press any time";
    cellModel2.selected = anyTimeSelected;
    [self.section1List addObject:cellModel2];
}

#pragma mark - UI Setup

- (void)loadSubViews {
    self.defaultTitle = @"Reset device by button";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - Getters

- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

@end
