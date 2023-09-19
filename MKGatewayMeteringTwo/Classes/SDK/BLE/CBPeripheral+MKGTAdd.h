//
//  CBPeripheral+MKGTAdd.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKGTAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gt_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gt_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gt_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gt_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gt_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *gt_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *gt_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *gt_custom;

- (void)gt_updateCharacterWithService:(CBService *)service;

- (void)gt_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)gt_connectSuccess;

- (void)gt_setNil;

@end

NS_ASSUME_NONNULL_END
