//
//  IRDataPicker+TimeAndSecond.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (TimeAndSecond)
- (void)timeAndSecond_setupSelectedDate;
- (void)timeAndSecond_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)timeAndSecond_didSelectWithComponent:(NSInteger)component;
@end


NS_ASSUME_NONNULL_END
