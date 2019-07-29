//
//  NSBundle+IRDataPicker.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (IRDataPicker)
+ (NSString *)IR_localizedStringForKey:(NSString *)key;
+ (NSString *)IR_localizedStringForKey:(NSString *)key language:(NSString *)language;
+ (NSString *)IR_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)IR_localizedStringForKey:(NSString *)key value:(NSString *)value language:(NSString *)language;
@end

NS_ASSUME_NONNULL_END
