//
//  MKScannerFilterByRawDataController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/10.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerFilterByRawDataController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"

#import "MKScannerFilterByBeaconController.h"
#import "MKScannerFilterByUIDController.h"
#import "MKScannerFilterByURLController.h"
#import "MKScannerFilterByTLMController.h"
#import "MKScannerFilterByButtonController.h"
#import "MKScannerFilterByTagController.h"
#import "MKScannerFilterByPirController.h"
#import "MKScannerFilterByTofController.h"
#import "MKScannerFilterByOtherController.h"
#import "MKScannerFilterByNanoBeaconController.h"

@interface MKScannerFilterByRawDataController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)id <MKScannerFilterByRawDataProtocol>protocol;

@end

@implementation MKScannerFilterByRawDataController

- (void)dealloc {
    NSLog(@"MKScannerFilterByRawDataController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerFilterByRawDataProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDataFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //iBeacon
        id <MKScannerFilterByBeaconProtocol>protocol = self.protocol.beaconProtocol;
        if (protocol) {
            MKScannerFilterByBeaconController *vc = [[MKScannerFilterByBeaconController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Eddystone-UID
        id <MKScannerFilterByUIDProtocol>protocol = self.protocol.uidProtocol;
        if (protocol) {
            MKScannerFilterByUIDController *vc = [[MKScannerFilterByUIDController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Eddystone-URL
        id <MKScannerFilterByURLProtocol>protocol = self.protocol.urlProtocol;
        if (protocol) {
            MKScannerFilterByURLController *vc = [[MKScannerFilterByURLController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Eddystone-TLM
        id <MKScannerFilterByTLMProtocol>protocol = self.protocol.tlmProtocol;
        if (protocol) {
            MKScannerFilterByTLMController *vc = [[MKScannerFilterByTLMController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        //BXP-Button
        id <MKScannerFilterByButtonProtocol>protocol = self.protocol.buttonProtocol;
        if (protocol) {
            MKScannerFilterByButtonController *vc = [[MKScannerFilterByButtonController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        //BXP-Tag
        id <MKScannerFilterByTagProtocol>protocol = self.protocol.tagProtocol;
        if (protocol) {
            MKScannerFilterByTagController *vc = [[MKScannerFilterByTagController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        //PIR
        id <MKScannerFilterByPirProtocol>protocol = self.protocol.pirProtocol;
        if (protocol) {
            MKScannerFilterByPirController *vc = [[MKScannerFilterByPirController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        //MK TOF
        id <MKScannerFilterByTofProtocol>protocol = self.protocol.tofProtocol;
        if (protocol) {
            MKScannerFilterByTofController *vc = [[MKScannerFilterByTofController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        //Nano Beacon
        id <MKScannerFilterByNanoBeaconProtocol>protocol = self.protocol.nanoBeaconProtocol;
        if (protocol) {
            MKScannerFilterByNanoBeaconController *vc = [[MKScannerFilterByNanoBeaconController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        //Other
        id <MKScannerFilterByOtherProtocol>protocol = self.protocol.otherProtocol;
        if (protocol) {
            MKScannerFilterByOtherController *vc = [[MKScannerFilterByOtherController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return (self.protocol.supportTof ? self.section3List.count : 0);
    }
    if (section == 4) {
        return (self.protocol.supportNanoBeacon ? self.section4List.count : 0);
    }
    if (section == 5) {
        return self.section5List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 4) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section5List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //BeaconX Pro – Device info
        [self configFilterBXPDeviceInfo:isOn];
        return;
    }
    if (index == 1) {
        //BeaconX Pro – ACC
        [self configFilterBXPACC:isOn];
        return;
    }
    if (index == 2) {
        //BeaconX Pro – T&H
        [self configFilterBXPTH:isOn];
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self updateCellStatus];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configFilterBXPDeviceInfo:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configFilterBXPDeviceInfo:isOn
                                    sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        self.protocol.bxpDeviceInfo = isOn;
    }
                                 failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)configFilterBXPACC:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configFilterBXPAcc:isOn
                             sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
        self.protocol.bxpAcc = isOn;
    }
                          failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)configFilterBXPTH:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configFilterBXPTH:isOn sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[2];
        cellModel.isOn = isOn;
        self.protocol.bxpTH = isOn;
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    
    [self.tableView reloadData];
}

- (void)updateCellStatus {
    MKNormalTextCellModel *cellModel1 = self.section0List[0];
    cellModel1.rightMsg = (self.protocol.iBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel2 = self.section0List[1];
    cellModel2.rightMsg = (self.protocol.uid ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel3 = self.section0List[2];
    cellModel3.rightMsg = (self.protocol.url ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel4 = self.section0List[3];
    cellModel4.rightMsg = (self.protocol.tlm ? @"ON" : @"OFF");
    
    MKTextSwitchCellModel *cellModel5 = self.section1List[0];
    cellModel5.isOn = self.protocol.bxpDeviceInfo;
    
    MKTextSwitchCellModel *cellModel6 = self.section1List[1];
    cellModel6.isOn = self.protocol.bxpAcc;
    
    MKTextSwitchCellModel *cellModel7 = self.section1List[2];
    cellModel7.isOn = self.protocol.bxpTH;
    
    MKNormalTextCellModel *cellModel8 = self.section2List[0];
    cellModel8.rightMsg = (self.protocol.bxpButton ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel9 = self.section2List[1];
    cellModel9.rightMsg = (self.protocol.bxpTag ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel10 = self.section2List[2];
    cellModel10.rightMsg = (self.protocol.pirPresence ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel11 = self.section3List[0];
    cellModel11.rightMsg = (self.protocol.tof ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel12 = self.section4List[0];
    cellModel12.rightMsg = (self.protocol.nanoBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel13 = self.section5List[0];
    cellModel13.rightMsg = (self.protocol.other ? @"ON" : @"OFF");
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"iBeacon";
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Eddystone-UID";
    [self.section0List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"Eddystone-URL";
    [self.section0List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.showRightIcon = YES;
    cellModel4.leftMsg = @"Eddystone-TLM";
    [self.section0List addObject:cellModel4];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"BXP - Device info";
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"BXP – ACC";
    [self.section1List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"BXP – T&H";
    [self.section1List addObject:cellModel3];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"BXP-Button";
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"BXP-Tag/Sensor";
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"PIR Presence";
    [self.section2List addObject:cellModel3];
}

- (void)loadSection3Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"MK TOF";
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"NanoBeacon info";
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Other";
    [self.section5List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Filter by Raw Data";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
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

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

@end
