//
//  Target_ScannerPro_GatewayMeteringTwo_Module.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_ScannerPro_GatewayMeteringTwo_Module : NSObject

/// 设备列表页面
/// @param params @{}
- (UIViewController *)Action_MKScannerPro_GatewayMeteringTwo_DeviceListPage:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
