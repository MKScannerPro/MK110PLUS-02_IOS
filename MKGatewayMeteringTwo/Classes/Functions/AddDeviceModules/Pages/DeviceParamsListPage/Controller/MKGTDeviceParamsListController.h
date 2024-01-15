//
//  MKGTDeviceParamsListController.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKMqttBleBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTDeviceParamsListController : MKMqttBleBaseController

@property (nonatomic, copy)NSString *deviceType;

@end

NS_ASSUME_NONNULL_END
