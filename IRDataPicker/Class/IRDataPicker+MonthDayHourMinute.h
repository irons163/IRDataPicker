//
//  IRDataPicker+MonthDayHourMinute.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/12.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (MonthDayHourMinute)
- (void)monthDayHourMinute_setupSelectedDate;
- (void)monthDayHourMinute_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)monthDayHourMinute_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
