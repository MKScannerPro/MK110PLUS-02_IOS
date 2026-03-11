//
//  MKGTFilterByRawDataModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTFilterByRawDataModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGTMQTTInterface.h"

#import "MKGTFilterByBeaconModel.h"
#import "MKGTFilterByButtonModel.h"
#import "MKGTFilterByNanoBeaconModel.h"
#import "MKGTFilterByOtherModel.h"
#import "MKGTFilterByPirModel.h"
#import "MKGTFilterByTagModel.h"
#import "MKGTFilterByTLMModel.h"
#import "MKGTFilterByTofModel.h"
#import "MKGTFilterByUIDModel.h"
#import "MKGTFilterByURLModel.h"

@implementation MKGTFilterByRawDataModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_readFilterByRawDataStatusWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        self.iBeacon = ([returnData[@"data"][@"ibeacon"] integerValue] == 1);
        self.uid = ([returnData[@"data"][@"eddystone_uid"] integerValue] == 1);
        
        self.url = ([returnData[@"data"][@"eddystone_url"] integerValue] == 1);
        self.tlm = ([returnData[@"data"][@"eddystone_tlm"] integerValue] == 1);
        
        self.bxpDeviceInfo = ([returnData[@"data"][@"bxp_devinfo"] integerValue] == 1);
        self.bxpAcc = ([returnData[@"data"][@"bxp_acc"] integerValue] == 1);
        
        self.bxpTH = ([returnData[@"data"][@"bxp_th"] integerValue] == 1);
        
        self.bxpButton = ([returnData[@"data"][@"bxp_button"] integerValue] == 1);
        self.bxpTag = ([returnData[@"data"][@"bxp_tag"] integerValue] == 1);
        self.pirPresence = ([returnData[@"data"][@"pir"] integerValue] == 1);
        
        self.other = ([returnData[@"data"][@"other"] integerValue] == 1);
        
        if (self.supportTof) {
            self.tof = ([returnData[@"data"][@"mk_tof"] integerValue] == 1);
        }
        
        if (self.supportNanoBeacon) {
            self.nanoBeacon = ([returnData[@"data"][@"nano_beacon_info"] integerValue] == 1);
        }
                
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

- (id <MKScannerFilterByBeaconProtocol>)beaconProtocol {
    return [[MKGTFilterByBeaconModel alloc] init];
}

- (id <MKScannerFilterByButtonProtocol>)buttonProtocol {
    return [[MKGTFilterByButtonModel alloc] init];
}

- (id <MKScannerFilterByOtherProtocol>)otherProtocol {
    return [[MKGTFilterByOtherModel alloc] init];
}

- (id <MKScannerFilterByPirProtocol>)pirProtocol {
    return [[MKGTFilterByPirModel alloc] init];
}

- (id <MKScannerFilterByTagProtocol>)tagProtocol {
    return [[MKGTFilterByTagModel alloc] init];
}

- (id <MKScannerFilterByTLMProtocol>)tlmProtocol {
    return [[MKGTFilterByTLMModel alloc] init];
}

- (id <MKScannerFilterByTofProtocol>)tofProtocol {
    return [[MKGTFilterByTofModel alloc] init];
}

- (id <MKScannerFilterByUIDProtocol>)uidProtocol {
    return [[MKGTFilterByUIDModel alloc] init];
}

- (id <MKScannerFilterByURLProtocol>)urlProtocol {
    return [[MKGTFilterByURLModel alloc] init];
}

- (id <MKScannerFilterByNanoBeaconProtocol>)nanoBeaconProtocol {
    return [[MKGTFilterByNanoBeaconModel alloc] init];
}

- (void)configFilterBXPDeviceInfo:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterFilterBXPDeviceInfo:isOn
                                               macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                              failedBlock:failedBlock];
}

- (void)configFilterBXPAcc:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterBXPAcc:isOn
                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                 failedBlock:failedBlock];
}

- (void)configFilterBXPTH:(BOOL)isOn
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGTMQTTInterface gt_configFilterBXPTH:isOn
                                 macAddress:[MKScannerDeviceModelManager shared].macAddress
                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                   sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                failedBlock:failedBlock];
}

@end
