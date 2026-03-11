//
//  MKGTNearbyWifiModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTNearbyWifiModel.h"

#import "MKGTCentralManager.h"
#import "MKGTInterface+MKGTConfig.h"

@interface MKGTNearbyWifiModel ()<mk_gt_centralManagerScanWifiDelegate>

@end

@implementation MKGTNearbyWifiModel

#pragma mark - mk_gt_centralManagerScanWifiDelegate
- (void)mk_gt_receiveWifi:(NSString *)content {
    if (self.receiveWifiBlock) {
        self.receiveWifiBlock(content);
    }
}

- (void)startWifiScanWithSucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTInterface gt_startWifiScanWithSucBlock:^{
        [MKGTCentralManager shared].wifiDelegate = self;
    } failedBlock:failedBlock];
}

@end
