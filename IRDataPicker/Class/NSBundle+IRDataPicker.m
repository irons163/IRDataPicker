//
//  NSBundle+IRDataPicker.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "NSBundle+IRDataPicker.h"
#import "IRDataPicker.h"

@implementation NSBundle (IRDataPicker)
+ (instancetype)safeBundle {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[IRDataPicker class]] pathForResource:@"IRDataPickerBundle" ofType:@"bundle"]];
    }
    return bundle;
}

+ (NSString *)IR_localizedStringForKey:(NSString *)key {
    return [self IR_localizedStringForKey:key value:nil];
}

+ (NSString *)IR_localizedStringForKey:(NSString *)key language:(NSString *)language {
    if (language == nil) {
        return [self IR_localizedStringForKey:key value:nil];
    }
    return [self IR_localizedStringForKey:key value:nil language:language];
}

+ (NSString *)IR_localizedStringForKey:(NSString *)key value:(NSString *)value {
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"zh-Hant";
        }
    } else {
        language = @"en";
    }
    return [self IR_localizedStringForKey:key value:value language:language];
}

+ (NSString *)IR_localizedStringForKey:(NSString *)key value:(NSString *)value language:(NSString *)language {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle safeBundle] pathForResource:language ofType:@"lproj"]];
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
@end

