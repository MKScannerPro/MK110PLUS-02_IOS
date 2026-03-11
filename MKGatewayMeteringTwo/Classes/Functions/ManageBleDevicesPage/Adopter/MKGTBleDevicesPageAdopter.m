//
//  MKGTBleDevicesPageAdopter.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBleDevicesPageAdopter.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTDataManager.h"
#import "MKGTMQTTInterface.h"

#import "MKGTManageBleDevicesManager.h"

#import "MKScannerBXPButtonCRController.h"
#import "MKScannerBXPButtonController.h"
#import "MKScannerBXPCController.h"
#import "MKScannerBXPDController.h"
#import "MKScannerBXPSController.h"
#import "MKScannerBXPTController.h"
#import "MKScannerPirController.h"
#import "MKScannerTofController.h"
#import "MKScannerNormalConnectedController.h"

#import "MKGTBXPButtonCRPageModel.h"
#import "MKGTBXPButtonPageModel.h"
#import "MKGTBXPCPageModel.h"
#import "MKGTBXPDPageModel.h"
#import "MKGTBXPSPageModel.h"
#import "MKGTBXPTPageModel.h"
#import "MKGTPirPageModel.h"
#import "MKGTTofPageModel.h"
#import "MKGTNormalConnectedPageModel.h"

@implementation MKGTBleDevicesPageAdopter

+ (UIViewController *)loadBXPBCRPage {
    MKGTBXPButtonCRPageModel *model = [[MKGTBXPButtonCRPageModel alloc] init];
    MKScannerBXPButtonCRController *vc = [[MKScannerBXPButtonCRController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPBDPage {
    MKGTBXPButtonPageModel *model = [[MKGTBXPButtonPageModel alloc] init];
    MKScannerBXPButtonController *vc = [[MKScannerBXPButtonController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPCPage {
    MKGTBXPCPageModel *model = [[MKGTBXPCPageModel alloc] init];
    MKScannerBXPCController *vc = [[MKScannerBXPCController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPDPage {
    MKGTBXPDPageModel *model = [[MKGTBXPDPageModel alloc] init];
    MKScannerBXPDController *vc = [[MKScannerBXPDController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPSPage {
    MKGTBXPSPageModel *model = [[MKGTBXPSPageModel alloc] init];
    MKScannerBXPSController *vc = [[MKScannerBXPSController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPTPage {
    MKGTBXPTPageModel *model = [[MKGTBXPTPageModel alloc] init];
    MKScannerBXPTController *vc = [[MKScannerBXPTController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadMKPirPage {
    MKGTPirPageModel *model = [[MKGTPirPageModel alloc] init];
    MKScannerPirController *vc = [[MKScannerPirController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadMKTofPage {
    MKGTTofPageModel *model = [[MKGTTofPageModel alloc] init];
    MKScannerTofController *vc = [[MKScannerTofController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadNormalConnectedPage {
    MKGTNormalConnectedPageModel *model = [[MKGTNormalConnectedPageModel alloc] init];
    MKScannerNormalConnectedController *vc = [[MKScannerNormalConnectedController alloc] initWithProtocol:model];
    return vc;
}

+ (void)connectPeripheral:(NSString *)bleMac
                     type:(MKGTManageBleDevicesType)type
                 password:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (type == MKGTManageBleDevicesTypeBXPBD) {
        //BXP-B-D
        [self connectBXPButtonWithPassword:password
                                    bleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPBCR) {
        //BXP-B-CR
        [self connectBXPButtonCRWithPassword:password
                                      bleMac:bleMac
                                    sucBlock:sucBlock
                                 failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPC) {
        //BXP-C
        [self connectBXPCWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPD) {
        //BXP-D
        [self connectBXPDWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPT) {
        //BXP-T
        [self connectBXPTWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPS) {
        //BXP-S
        [self connectBXPSWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypePIR) {
        //MK Pir
        [self connectMKPirWithPassword:password
                                bleMac:bleMac
                              sucBlock:sucBlock
                           failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeTOF) {
        //MK Tof
        [self connectMKTofWithPassword:password
                                bleMac:bleMac
                              sucBlock:sucBlock
                           failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeOther) {
        //Normal Connected
        [self connectNormalDeviceWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (failedBlock) {
        failedBlock([self getErrorWithMsg:@"Type error"]);
    }
}

+ (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac
                                     type:(MKGTManageBleDevicesType)type
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    if (type == MKGTManageBleDevicesTypeBXPBD) {
        //BXP-B-D
        [self readBXPButtonDeviceInfoWithBleMac:bleMac
                                       sucBlock:sucBlock
                                    failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPBCR) {
        //BXP-B-CR
        [self readBXPButtonCRDeviceInfoWithBleMac:bleMac
                                         sucBlock:sucBlock
                                      failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPC) {
        //BXP-C
        [self readBXPCDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPD) {
        //BXP-D
        [self readBXPDDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPT) {
        //BXP-T
        [self readBXPTDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeBXPS) {
        //BXP-S
        [self readBXPSDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypePIR) {
        //MK Pir
        [self readMKPIRDeviceInfoWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeTOF) {
        //MK Tof
        [self readMKTOFDeviceInfoWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (type == MKGTManageBleDevicesTypeOther) {
        //Normal Connected
        [self readNormalDeviceInfoWithBleMac:bleMac
                                    sucBlock:sucBlock
                                 failedBlock:failedBlock];
        return;
    }
    if (failedBlock) {
        failedBlock([self getErrorWithMsg:@"Type error"]);
    }
}

#pragma mark - 连接设备
+ (void)connectBXPButtonWithPassword:(NSString *)password
                              bleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPButtonWithPassword:password
                                                bleMac:bleMac
                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                              sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                           failedBlock:failedBlock];
}

+ (void)connectBXPButtonCRWithPassword:(NSString *)password
                                bleMac:(NSString *)bleMac
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPButtonCRWithPassword:password
                                                  bleMac:bleMac
                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                             failedBlock:failedBlock];
}

+ (void)connectBXPCWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPCWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPDWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPDWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPTWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPTWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPSWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectBXPSWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectMKPirWithPassword:(NSString *)password
                          bleMac:(NSString *)bleMac
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectMKPirWithPassword:password
                                            bleMac:bleMac
                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                       failedBlock:failedBlock];
}

+ (void)connectMKTofWithPassword:(NSString *)password
                          bleMac:(NSString *)bleMac
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectMKTofWithPassword:password
                                            bleMac:bleMac
                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                       failedBlock:failedBlock];
}

+ (void)connectNormalDeviceWithBleMac:(NSString *)bleMac
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_connectNormalBleDeviceWithBleMac:bleMac
                                                macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                     topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                  sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                               failedBlock:failedBlock];
}

#pragma mark - 读取设备信息
+ (void)readBXPButtonDeviceInfoWithBleMac:(NSString *)bleMac
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPButtonConnectedDeviceInfoWithBleMacAddress:bleMac
                                                                 macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                   sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                                failedBlock:failedBlock];
}

+ (void)readBXPButtonCRDeviceInfoWithBleMac:(NSString *)bleMac
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPButtonCRConnectedDeviceInfoWithBleMacAddress:bleMac
                                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                     sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                                  failedBlock:failedBlock];
}

+ (void)readBXPCDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPCConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPDDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPDConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPTDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPTConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPSDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readBXPSConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readMKPIRDeviceInfoWithBleMac:(NSString *)bleMac
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readMKPirConnectedDeviceInfoWithBleMacAddress:bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                            failedBlock:failedBlock];
}

+ (void)readMKTOFDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readMKTofConnectedDeviceInfoWithBleMacAddress:bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                            failedBlock:failedBlock];
}

+ (void)readNormalDeviceInfoWithBleMac:(NSString *)bleMac
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readNormalConnectedDeviceInfoWithBleMacAddress:bleMac
                                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                sucBlock:^(id  _Nonnull returnData) {
        [MKGTManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                             failedBlock:failedBlock];
}

+ (NSError *)getErrorWithMsg:(NSString *)msg {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.ManageBleDevicesManager"
                                                code:-99
                                            userInfo:@{@"errorInfo":msg}];
    return error;
}

@end
