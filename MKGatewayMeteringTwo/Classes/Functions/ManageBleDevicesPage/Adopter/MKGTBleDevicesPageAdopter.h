//
//  MKGTBleDevicesPageAdopter.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGTManageBleDevicesType) {
    MKGTManageBleDevicesTypeBXPBD,
    MKGTManageBleDevicesTypeBXPBCR,
    MKGTManageBleDevicesTypeBXPC,
    MKGTManageBleDevicesTypeBXPD,
    MKGTManageBleDevicesTypeBXPT,
    MKGTManageBleDevicesTypeBXPS,
    MKGTManageBleDevicesTypePIR,
    MKGTManageBleDevicesTypeTOF,
    MKGTManageBleDevicesTypeOther,
};

@interface MKGTBleDevicesPageAdopter : NSObject

+ (UIViewController *)loadBXPBCRPage;

+ (UIViewController *)loadBXPBDPage;

+ (UIViewController *)loadBXPCPage;

+ (UIViewController *)loadBXPDPage;

+ (UIViewController *)loadBXPSPage;

+ (UIViewController *)loadBXPTPage;

+ (UIViewController *)loadMKPirPage;

+ (UIViewController *)loadMKTofPage;

+ (UIViewController *)loadNormalConnectedPage;

/// 连接设备.连接设备之后，当前设备信息会放在MKGTManageBleDevicesManager管理
/// - Parameters:
///   - bleMac: 要连接设备的mac地址
///   - type: 要连接设备的类型
///   - password: 密码
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
+ (void)connectPeripheral:(NSString *)bleMac
                     type:(MKGTManageBleDevicesType)type
                 password:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取连接设备的信息。读取之后，当前设备信息会放在MKGTManageBleDevicesManager管理
/// - Parameters:
///   - bleMac: 要读取设备的mac地址
///   - type: 要读取设备的类型
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
+ (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac
                                     type:(MKGTManageBleDevicesType)type
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;



@end

NS_ASSUME_NONNULL_END
