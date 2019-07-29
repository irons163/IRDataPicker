//
//  IRDataPicker+Common.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (Common)
- (NSInteger)weekDayMappingFrom:(NSString *)weekString;
- (NSString *)weekMappingFrom:(NSInteger)weekDay;
- (NSInteger)howManyDaysWithMonthInThisYear:(NSInteger)year withMonth:(NSInteger)month;
@end

NS_ASSUME_NONNULL_END
