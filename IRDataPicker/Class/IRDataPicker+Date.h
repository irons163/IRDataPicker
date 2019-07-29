//
//  IRDataPicker+Date.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (Date)
- (void)date_setupSelectedDate;
- (void)date_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
- (void)date_didSelectWithComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
