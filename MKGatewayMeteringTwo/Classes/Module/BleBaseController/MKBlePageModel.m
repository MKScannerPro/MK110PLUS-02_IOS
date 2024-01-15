//
//  MKBlePageModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2024/1/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKBlePageModel.h"

static MKBlePageModel *manager = nil;
static dispatch_once_t onceToken;

@interface MKBlePageModel ()

@property (nonatomic, copy)NSString *notiName;

@property (nonatomic, copy)NSString *backClassName;

@end

@implementation MKBlePageModel

- (void)dealloc {
    NSLog(@"MKBlePageModel销毁");
}

+ (MKBlePageModel *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKBlePageModel new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

- (void)configDisconnectNotification:(NSString *)notiName backToClassName:(NSString *)className {
    self.notiName = nil;
    self.notiName = notiName;
    self.backClassName = nil;
    self.backClassName = className;
}

@end
