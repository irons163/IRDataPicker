//
//  IRDataPicker+MonthDayHourMinuteSecond.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/12.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (MonthDayHourMinuteSecond)
- (void)monthDayHourMinuteSecond_setupSelectedDate;
- (void)monthDayHourMinuteSecond_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)monthDayHourMinuteSecond_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
