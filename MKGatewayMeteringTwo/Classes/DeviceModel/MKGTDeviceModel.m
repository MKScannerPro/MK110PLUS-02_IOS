//
//  MKGTDeviceModel.m
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGTDeviceModel.h"

#import "MKMacroDefines.h"

#import "MKGTMQTTDataManager.h"

@implementation MKGTDeviceModel

#pragma mark - public method
- (NSString *)currentSubscribedTopic {
    if (ValidStr([MKGTMQTTDataManager shared].serverParams.publishTopic)) {
        return [MKGTMQTTDataManager shared].serverParams.publishTopic;
    }
    return self.subscribedTopic;
}

- (NSString *)currentPublishedTopic {
    if (ValidStr([MKGTMQTTDataManager shared].serverParams.subscribeTopic)) {
        return [MKGTMQTTDataManager shared].serverParams.subscribeTopic;
    }
    return self.publishedTopic;
}

@end
