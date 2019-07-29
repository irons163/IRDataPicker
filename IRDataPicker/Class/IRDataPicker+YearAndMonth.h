//
//  IRDataPicker+YearAndMonth.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (YearAndMonth)
- (void)yearAndMonth_setupSelectedDate;
- (void)yearAndMonth_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)yearAndMonth_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
