//
//  Target_ScannerPro_GatewayMeteringTwo_Module.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_GatewayMeteringTwo_Module.h"

#import "MKGTDeviceListController.h"

@implementation Target_ScannerPro_GatewayMeteringTwo_Module

- (UIViewController *)Action_MKScannerPro_GatewayMeteringTwo_DeviceListPage:(NSDictionary *)params {
    MKGTDeviceListController *vc = [[MKGTDeviceListController alloc] init];
    vc.connectServer = YES;
    return vc;
}

@end
