//
//  IRDataPicker+MonthDayHour.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (MonthDayHour)
- (void)monthDayHour_setupSelectedDate;
- (void)monthDayHour_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)monthDayHour_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
