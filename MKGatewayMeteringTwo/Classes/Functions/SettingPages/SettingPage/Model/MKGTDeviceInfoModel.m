//
//  MKGTDeviceInfoModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/1/31.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTDeviceInfoModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

@implementation MKGTDeviceInfoModel

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readDeviceInfoWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                              sucBlock:^(id  _Nonnull returnData) {
        self.deviceName = returnData[@"data"][@"device_name"];
        self.productMode = returnData[@"data"][@"product_model"];
        self.manu = returnData[@"data"][@"company_name"];
        self.firmware = returnData[@"data"][@"firmware_version"];
        self.hardware = returnData[@"data"][@"hardware_version"];
        self.software = returnData[@"data"][@"software_version"];
        self.btMac = returnData[@"data"][@"ble_mac"];
        self.wifiStaMac = [MKScannerDeviceModelManager shared].macAddress;
        if (sucBlock) {
            sucBlock([self fetchDataList]);
        }
    }
                                           failedBlock:failedBlock];
}

- (NSArray <MKScannerDeviceInfoModel *>*)fetchDataList {
    NSMutableArray *list = [NSMutableArray array];
    MKScannerDeviceInfoModel *cellModel1 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel1.key = @"Device name";
    cellModel1.value = self.deviceName;
    [list addObject:cellModel1];
    
    MKScannerDeviceInfoModel *cellModel2 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel2.key = @"Product model";
    cellModel2.value = self.productMode;
    [list addObject:cellModel2];
    
    MKScannerDeviceInfoModel *cellModel3 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel3.key = @"Manufacturer";
    cellModel3.value = self.manu;
    [list addObject:cellModel3];
    
    MKScannerDeviceInfoModel *cellModel4 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel4.key = @"Hardware version";
    cellModel4.value = self.hardware;
    [list addObject:cellModel4];
    
    MKScannerDeviceInfoModel *cellModel5 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel5.key = @"Software version";
    cellModel5.value = self.software;
    [list addObject:cellModel5];
    
    MKScannerDeviceInfoModel *cellModel6 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel6.key = @"Firmware version";
    cellModel6.value = self.firmware;
    [list addObject:cellModel6];
    
    MKScannerDeviceInfoModel *cellModel7 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel7.key = @"WIFI MAC Address";
    cellModel7.value = self.wifiStaMac;
    [list addObject:cellModel7];
    
    MKScannerDeviceInfoModel *cellModel8 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel8.key = @"BLE MAC Address";
    cellModel8.value = self.btMac;
    [list addObject:cellModel8];
    
    return list;
}

@end


@implementation MKGTDeviceInfoV2Model

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readDeviceInfoWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                              sucBlock:^(id  _Nonnull returnData) {
        self.deviceName = returnData[@"data"][@"device_name"];
        self.productMode = returnData[@"data"][@"product_model"];
        self.manu = returnData[@"data"][@"company_name"];
        self.hardware = returnData[@"data"][@"hardware_version"];
        self.software = returnData[@"data"][@"software_version"];
        self.wifiFirmware = returnData[@"data"][@"firmware_version"];
        self.wifiStaMac = returnData[@"data"][@"wifi_mac"];
        self.bleFirmware = returnData[@"data"][@"sl_ble_version"];
        self.btMac = returnData[@"data"][@"ble_mac"];
        
        if (sucBlock) {
            sucBlock([self fetchDataList]);
        }
    }
                                           failedBlock:failedBlock];
}

- (NSArray <MKScannerDeviceInfoModel *>*)fetchDataList {
    NSMutableArray *list = [NSMutableArray array];
    MKScannerDeviceInfoModel *cellModel1 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel1.key = @"Device name";
    cellModel1.value = self.deviceName;
    [list addObject:cellModel1];
    
    MKScannerDeviceInfoModel *cellModel2 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel2.key = @"Product model";
    cellModel2.value = self.productMode;
    [list addObject:cellModel2];
    
    MKScannerDeviceInfoModel *cellModel3 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel3.key = @"Manufacturer";
    cellModel3.value = self.manu;
    [list addObject:cellModel3];
    
    MKScannerDeviceInfoModel *cellModel4 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel4.key = @"Hardware version";
    cellModel4.value = self.hardware;
    [list addObject:cellModel4];
    
    MKScannerDeviceInfoModel *cellModel5 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel5.key = @"Software version";
    cellModel5.value = self.software;
    [list addObject:cellModel5];
    
    MKScannerDeviceInfoModel *cellModel6 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel6.key = @"WIFI Firmware Version";
    cellModel6.value = self.wifiFirmware;
    [list addObject:cellModel6];
    
    MKScannerDeviceInfoModel *cellModel7 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel7.key = @"WIFI MAC";
    cellModel7.value = self.wifiStaMac;
    [list addObject:cellModel7];
    
    MKScannerDeviceInfoModel *cellModel8 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel8.key = @"BLE Firmware Version";
    cellModel8.value = self.bleFirmware;
    [list addObject:cellModel8];
    
    MKScannerDeviceInfoModel *cellModel9 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel9.key = @"BLE MAC";
    cellModel9.value = self.btMac;
    [list addObject:cellModel9];
    
    return list;
}

@end
