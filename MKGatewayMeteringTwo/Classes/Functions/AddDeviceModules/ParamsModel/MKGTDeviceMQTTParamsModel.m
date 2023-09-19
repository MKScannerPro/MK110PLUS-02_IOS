//
//  MKGTDeviceMQTTParamsModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTDeviceMQTTParamsModel.h"

#import "MKGTDeviceModel.h"

static MKGTDeviceMQTTParamsModel *paramsModel = nil;
static dispatch_once_t onceToken;

@implementation MKGTDeviceMQTTParamsModel

+ (MKGTDeviceMQTTParamsModel *)shared {
    dispatch_once(&onceToken, ^{
        if (!paramsModel) {
            paramsModel = [MKGTDeviceMQTTParamsModel new];
        }
    });
    return paramsModel;
}

+ (void)sharedDealloc {
    paramsModel = nil;
    onceToken = 0;
}

#pragma mark - getter
- (MKGTDeviceModel *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = [[MKGTDeviceModel alloc] init];
    }
    return _deviceModel;
}

@end
