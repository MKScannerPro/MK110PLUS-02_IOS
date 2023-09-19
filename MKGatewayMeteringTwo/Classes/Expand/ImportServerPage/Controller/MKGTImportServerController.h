//
//  MKGTImportServerController.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGTImportServerControllerDelegate <NSObject>

- (void)gt_selectedServerParams:(NSString *)fileName;

@end

@interface MKGTImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKGTImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
