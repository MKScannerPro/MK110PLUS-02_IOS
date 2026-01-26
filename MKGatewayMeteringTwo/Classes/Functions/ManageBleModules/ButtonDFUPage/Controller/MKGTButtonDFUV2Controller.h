//
//  MKGTButtonDFUV2Controller.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/6/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGTButtonDFUV2Controller : MKGTBaseViewController

/// 1:BXP-B-D   2:BXP-B-CR  3:BXP-C 4:BXP-D 5:BXP-TAG   6:BXP-S 7:PIR   8:TOF
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, copy)NSString *bleMacAddress;

@end

NS_ASSUME_NONNULL_END
