//
//  UIColor+IRHex.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (IRHex)
+ (UIColor *)ir_colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
