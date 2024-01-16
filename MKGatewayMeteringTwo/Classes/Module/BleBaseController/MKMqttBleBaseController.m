//
//  MKMqttBleBaseController.m
//  MKGatewayCommonModule_Example
//
//  Created by aa on 2024/1/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKMqttBleBaseController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKBlePageModel.h"

@interface MKMqttBleBaseController ()

@end

@implementation MKMqttBleBaseController

- (void)dealloc {
    NSLog(@"MKMqttBleBaseController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnectNotification)
                                                 name:[MKBlePageModel shared].notiName
                                               object:nil];
}

- (void)receiveDisconnectNotification {
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [self.view showCentralToast:@"Device disconnect!"];
    [self performSelector:@selector(gotoScanPage) withObject:nil afterDelay:0.5f];
}

#pragma mark - private method
- (void)gotoScanPage {
    [self popToViewControllerWithClassName:[MKBlePageModel shared].backClassName];
}

@end
