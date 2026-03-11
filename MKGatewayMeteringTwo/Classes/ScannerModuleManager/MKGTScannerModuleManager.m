//
//  MKGTScannerModuleManager.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTScannerModuleManager.h"

#import "MKMacroDefines.h"

#import "MKScannerMQTTModuleManager.h"
#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"

static MKGTScannerModuleManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKGTScannerModuleManager

- (void)dealloc {
    NSLog(@"MKGTScannerModuleManager销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self addNotifications];
    }
    return self;
}

+ (MKGTScannerModuleManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGTScannerModuleManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

#pragma mark - note
- (void)deviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"macAddress"]];
}

- (void)receiveDeviceLwtMessage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)deviceResetByButton:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)loadChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    if (![user[@"device_info"][@"mac"] isEqualToString:[MKScannerDeviceModelManager shared].macAddress]) {
        return;
    }
    NSInteger state = [user[@"data"][@"load_state"] integerValue];
    if ([MKScannerMQTTModuleManager shared].loadChangedBlock) {
        [MKScannerMQTTModuleManager shared].loadChangedBlock(state);
    }
}

#pragma mark - Private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline:)
                                                 name:MKScannerDeviceModelOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceLwtMessage:)
                                                 name:MKGTReceiveDeviceOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceResetByButton:)
                                                 name:MKGTReceiveDeviceResetByButtonNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadChanged:)
                                                 name:MKGTReceiveLoadChangeNotification
                                               object:nil];
}

- (void)processOfflineWithMacAddress:(NSString *)macAddress {
    if (![macAddress isEqualToString:[MKScannerDeviceModelManager shared].macAddress]) {
        return;
    }
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_scanner_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    if ([MKScannerMQTTModuleManager shared].deviceOfflineBlock) {
        [MKScannerMQTTModuleManager shared].deviceOfflineBlock();
    }
}

@end
