//
//  MKImportServerController.h
//  MKGatewayCommonModule_Example
//
//  Created by aa on 2024/1/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKImportServerControllerDelegate <NSObject>

- (void)mk_selectedServerParams:(NSString *)fileName;

@end

@interface MKImportServerController : MKBaseViewController

@property (nonatomic, copy)NSString *title;

@property (nonatomic, weak)id <MKImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
