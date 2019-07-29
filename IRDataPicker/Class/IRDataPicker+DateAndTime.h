//
//  IRDataPicker+DateAndTime.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (DateAndTime)
- (void)dateAndTime_setupSelectedDate;
- (void)dateAndTime_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)dateAndTime_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
