//
//  MKGTMQTTLWTForDeviceView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2023/9/18.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGTMQTTLWTForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKGTMQTTLWTForDeviceViewDelegate <NSObject>

- (void)gt_lwt_statusChanged:(BOOL)isOn;

- (void)gt_lwt_retainChanged:(BOOL)isOn;

- (void)gt_lwt_qosChanged:(NSInteger)qos;

- (void)gt_lwt_topicChanged:(NSString *)text;

- (void)gt_lwt_payloadChanged:(NSString *)text;

@end

@interface MKGTMQTTLWTForDeviceView : UIView

@property (nonatomic, strong)MKGTMQTTLWTForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKGTMQTTLWTForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
