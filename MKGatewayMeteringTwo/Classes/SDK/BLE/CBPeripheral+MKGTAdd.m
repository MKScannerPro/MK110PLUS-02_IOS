//
//  CBPeripheral+MKGTAdd.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKGTAdd.h"

#import <objc/runtime.h>

static const char *gt_manufacturerKey = "gt_manufacturerKey";
static const char *gt_deviceModelKey = "gt_deviceModelKey";
static const char *gt_hardwareKey = "gt_hardwareKey";
static const char *gt_softwareKey = "gt_softwareKey";
static const char *gt_firmwareKey = "gt_firmwareKey";

static const char *gt_passwordKey = "gt_passwordKey";
static const char *gt_disconnectTypeKey = "gt_disconnectTypeKey";
static const char *gt_customKey = "gt_customKey";

static const char *gt_passwordNotifySuccessKey = "gt_passwordNotifySuccessKey";
static const char *gt_disconnectTypeNotifySuccessKey = "gt_disconnectTypeNotifySuccessKey";
static const char *gt_customNotifySuccessKey = "gt_customNotifySuccessKey";

@implementation CBPeripheral (MKGTAdd)

- (void)gt_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &gt_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &gt_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &gt_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &gt_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &gt_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &gt_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &gt_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &gt_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)gt_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &gt_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &gt_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &gt_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)gt_connectSuccess {
    if (![objc_getAssociatedObject(self, &gt_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &gt_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &gt_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.gt_hardware || !self.gt_firmware) {
        return NO;
    }
    if (!self.gt_password || !self.gt_disconnectType || !self.gt_custom) {
        return NO;
    }
    return YES;
}

- (void)gt_setNil {
    objc_setAssociatedObject(self, &gt_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &gt_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &gt_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gt_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)gt_manufacturer {
    return objc_getAssociatedObject(self, &gt_manufacturerKey);
}

- (CBCharacteristic *)gt_deviceModel {
    return objc_getAssociatedObject(self, &gt_deviceModelKey);
}

- (CBCharacteristic *)gt_hardware {
    return objc_getAssociatedObject(self, &gt_hardwareKey);
}

- (CBCharacteristic *)gt_software {
    return objc_getAssociatedObject(self, &gt_softwareKey);
}

- (CBCharacteristic *)gt_firmware {
    return objc_getAssociatedObject(self, &gt_firmwareKey);
}

- (CBCharacteristic *)gt_password {
    return objc_getAssociatedObject(self, &gt_passwordKey);
}

- (CBCharacteristic *)gt_disconnectType {
    return objc_getAssociatedObject(self, &gt_disconnectTypeKey);
}

- (CBCharacteristic *)gt_custom {
    return objc_getAssociatedObject(self, &gt_customKey);
}

@end
