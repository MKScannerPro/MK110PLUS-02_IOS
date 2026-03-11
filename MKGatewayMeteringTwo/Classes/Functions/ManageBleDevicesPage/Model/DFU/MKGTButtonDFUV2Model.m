//
//  MKGTButtonDFUV2Model.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/6/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTButtonDFUV2Model.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

@implementation MKGTButtonDFUV2Model

- (void)dealloc {
    NSLog(@"MKGTButtonDFUV2Model销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self addNotes];
    }
    return self;
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (![self validParams]) {
        if (failedBlock) {
            NSError *error = [[NSError alloc] initWithDomain:@"buttonDFUParams"
                                                        code:-999
                                                    userInfo:@{@"errorInfo":@"File URL error"}];
            failedBlock(error);
        }
        return;
    }
    NSString *password = @"";
    if (self.type == 7 || self.type == 8) {
        password = @"MOKOMOKO";
    }
    NSString *bleMac = [MKGTManageBleDevicesManager shared].bleMac;
    [MKGTMQTTInterface gt_startBXPDfuWithBeaconType:self.type
                                        firmwareUrl:self.firmwareUrl
                                            dataUrl:self.dataUrl
                                            dfuList:@[@{@"mac":bleMac,@"password":password}]
                                         macAddress:[MKScannerDeviceModelManager shared].macAddress
                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                           sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                        failedBlock:failedBlock];
}

#pragma mark - Notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGTManageBleDevicesManager shared].bleMac]) {
        return;
    }
    if (self.deviceDisconnectBlock) {
        self.deviceDisconnectBlock([MKScannerDeviceModelManager shared].macAddress, [MKGTManageBleDevicesManager shared].bleMac);
    }
}

- (void)receiveDfuProgress:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    if (!ValidStr(user[@"data"][@"mac"]) || ![[MKGTManageBleDevicesManager shared].bleMac isEqualToString:user[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDfuProgressBlock) {
        NSString *percent = [NSString stringWithFormat:@"%@",user[@"data"][@"percent"]];
        self.receiveDfuProgressBlock([MKScannerDeviceModelManager shared].macAddress, [MKGTManageBleDevicesManager shared].bleMac, percent);
    }
}

- (void)receiveDfuFailed:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSInteger resultCode = [user[@"data"][@"multi_dfu_result_code"] integerValue];
    NSArray *failList = user[@"data"][@"fail_dev"];
    NSInteger result = 1;
    if (resultCode == 1 && failList.count == 0) {
        //升级成功
        result = 0;
    }
    if (self.receiveDfuResultBlock) {
        self.receiveDfuResultBlock([MKScannerDeviceModelManager shared].macAddress, [MKGTManageBleDevicesManager shared].bleMac, result);
    }
}

#pragma mark - private method
- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDfuProgress:)
                                                 name:MKGTReceiveBxpButtonDfuProgressNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGTReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDfuFailed:)
                                                 name:MKGTReceiveBxpDfuFailedNotification
                                               object:nil];
}

- (BOOL)validParams {
    if (self.type < 1 || self.type > 8) {
        return NO;
    }
    if (!ValidStr(self.firmwareUrl) || self.firmwareUrl.length > 256) {
        return NO;
    }
    if (self.type != 5 && self.type != 6 && !ValidStr(self.dataUrl) || self.dataUrl.length > 256) {
        return NO;
    }
    return YES;
}

@end
