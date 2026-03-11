//
//  MKGTManageBleDevicesManager.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTManageBleDevicesManager.h"

#import "MKMacroDefines.h"

static MKGTManageBleDevicesManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKGTManageBleDevicesManager

+ (MKGTManageBleDevicesManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGTManageBleDevicesManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

- (NSString *)bleMac {
    if (!ValidDict(self.deviceBleInfo)) {
        return @"";
    }
    return self.deviceBleInfo[@"data"][@"mac"];
}

- (void)setDeviceBleInfo:(NSDictionary *)deviceBleInfo {
    _deviceBleInfo = nil;
    _deviceBleInfo = deviceBleInfo;
}

@end
