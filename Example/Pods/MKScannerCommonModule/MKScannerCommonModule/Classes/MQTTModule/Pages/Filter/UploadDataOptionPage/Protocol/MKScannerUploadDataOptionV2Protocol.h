
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerUploadDataOptionV2Protocol <NSObject>

/// V2版本固件
@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, assign)BOOL timestamp;

/// V1中有此参数
@property (nonatomic, assign)BOOL rawData_advertising;

/// V1中有此参数
@property (nonatomic, assign)BOOL rawData_response;

/// V2中有此参数
@property (nonatomic, assign)BOOL adv_data;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
