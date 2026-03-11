
#import "MKScannerFilterByBeaconProtocol.h"
#import "MKScannerFilterByButtonProtocol.h"
#import "MKScannerFilterByOtherProtocol.h"
#import "MKScannerFilterByPirProtocol.h"
#import "MKScannerFilterByTagProtocol.h"
#import "MKScannerFilterByTLMProtocol.h"
#import "MKScannerFilterByTofProtocol.h"
#import "MKScannerFilterByUIDProtocol.h"
#import "MKScannerFilterByURLProtocol.h"
#import "MKScannerFilterByNanoBeaconProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerFilterByRawDataProtocol <NSObject>

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

@property (nonatomic, assign)BOOL nanoBeacon;

- (id <MKScannerFilterByBeaconProtocol>)beaconProtocol;

- (id <MKScannerFilterByButtonProtocol>)buttonProtocol;

- (id <MKScannerFilterByOtherProtocol>)otherProtocol;

- (id <MKScannerFilterByPirProtocol>)pirProtocol;

- (id <MKScannerFilterByTagProtocol>)tagProtocol;

- (id <MKScannerFilterByTLMProtocol>)tlmProtocol;

- (id <MKScannerFilterByUIDProtocol>)uidProtocol;

- (id <MKScannerFilterByURLProtocol>)urlProtocol;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPDeviceInfo:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPAcc:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterBXPTH:(BOOL)isOn
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

@optional
- (id <MKScannerFilterByTofProtocol>)tofProtocol;

- (id <MKScannerFilterByNanoBeaconProtocol>)nanoBeaconProtocol;


@end

NS_ASSUME_NONNULL_END
