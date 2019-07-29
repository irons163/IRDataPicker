//
//  IRDataPicker+Year.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (Year)
- (void)year_setupSelectedDate;
- (void)year_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
