//
//  MKScannerUploadDataOptionV2Controller.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/10.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerUploadDataOptionV2Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerUploadDataOptionV2Controller : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerUploadDataOptionV2Protocol>)protocol;

@end

NS_ASSUME_NONNULL_END
