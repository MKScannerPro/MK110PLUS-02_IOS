//
//  MKGTFilterByRawDataModel.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerFilterByRawDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTFilterByRawDataModel : NSObject<MKScannerFilterByRawDataProtocol>

/// 是否支持MK Tof
@property (nonatomic, assign)BOOL supportTof;

/// 是否支持NanoBeacon
@property (nonatomic, assign)BOOL supportNanoBeacon;



@property (nonatomic, assign)BOOL iBeacon;

@property (nonatomic, assign)BOOL uid;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL tlm;

@property (nonatomic, assign)BOOL bxpDeviceInfo;

@property (nonatomic, assign)BOOL bxpAcc;

@property (nonatomic, assign)BOOL bxpTH;

@property (nonatomic, assign)BOOL bxpButton;

@property (nonatomic, assign)BOOL bxpTag;

@property (nonatomic, assign)BOOL pirPresence;

@property (nonatomic, assign)BOOL other;

@property (nonatomic, assign)BOOL tof;

/// V2 版本固件后支持
@property (nonatomic, assign)BOOL nanoBeacon;

- (id <MKScannerFilterByBeaconProtocol>)beaconProtocol;

- (id <MKScannerFilterByButtonProtocol>)buttonProtocol;

- (id <MKScannerFilterByOtherProtocol>)otherProtocol;

- (id <MKScannerFilterByPirProtocol>)pirProtocol;

- (id <MKScannerFilterByTagProtocol>)tagProtocol;

- (id <MKScannerFilterByTLMProtocol>)tlmProtocol;

- (id <MKScannerFilterByTofProtocol>)tofProtocol;

- (id <MKScannerFilterByUIDProtocol>)uidProtocol;

- (id <MKScannerFilterByURLProtocol>)urlProtocol;

- (id <MKScannerFilterByNanoBeaconProtocol>)nanoBeaconProtocol;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPDeviceInfo:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPAcc:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPTH:(BOOL)isOn
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
