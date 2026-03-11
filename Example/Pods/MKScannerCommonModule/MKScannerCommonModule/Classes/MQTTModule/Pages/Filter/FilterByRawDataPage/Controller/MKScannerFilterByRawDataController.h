//
//  MKScannerFilterByRawDataController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/10.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerFilterByRawDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterByRawDataController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerFilterByRawDataProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
