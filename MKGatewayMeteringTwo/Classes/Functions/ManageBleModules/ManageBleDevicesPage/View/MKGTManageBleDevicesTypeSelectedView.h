//
//  MKGTManageBleDevicesTypeSelectedView.h
//  MKGatewayMeteringTwo_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGTManageBleDevicesTypeSelectedViewType) {
    MKGTManageBleDevicesTypeSelectedViewTypeBXPBD,
    MKGTManageBleDevicesTypeSelectedViewTypeBXPBCR,
    MKGTManageBleDevicesTypeSelectedViewTypeBXPC,
    MKGTManageBleDevicesTypeSelectedViewTypeBXPD,
    MKGTManageBleDevicesTypeSelectedViewTypeBXPT,
    MKGTManageBleDevicesTypeSelectedViewTypeBXPS,
    MKGTManageBleDevicesTypeSelectedViewTypePIR,
    MKGTManageBleDevicesTypeSelectedViewTypeTOF,
    MKGTManageBleDevicesTypeSelectedViewTypeOther,
};

@interface MKGTManageBleDevicesTypeSelectedView : UIView

+ (void)showWithType:(MKGTManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKGTManageBleDevicesTypeSelectedViewType selectedType))selecteBlock;

@end

NS_ASSUME_NONNULL_END
