//
//  NSDate+IRCategory.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (IRCategory)
+ (NSDate *)setYear:(NSInteger)year;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)setMinute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
- (NSInteger)howManyDaysWithMonth;
@end

NS_ASSUME_NONNULL_END
