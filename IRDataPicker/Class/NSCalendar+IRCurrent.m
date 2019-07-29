//
//  NSCalendar+IRCurrent.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "NSCalendar+IRCurrent.h"
#import <objc/runtime.h>

@implementation NSCalendar (IRCurrent)
static const char currentComponentsKey = '\0';
- (void)setCurrentComponents:(NSDateComponents *)currentComponents {
    objc_setAssociatedObject(self, &currentComponentsKey, currentComponents,  OBJC_ASSOCIATION_ASSIGN);
}

- (NSDateComponents *)currentComponents {
    NSDateComponents *components = objc_getAssociatedObject(self, &currentComponentsKey);
    if (components == nil) {
        NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
        [self setCurrentComponents:[self components:unitFlags fromDate:[NSDate date]]];
    }
    return objc_getAssociatedObject(self, &currentComponentsKey);
}
@end
