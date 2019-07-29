//
//  IRDataPicker+Year.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker+Year.h"
#import "IRDataPickerHeader.h"

@implementation IRDataPicker (Year)
- (void)year_setupSelectedDate {
    NSString *yearString = [self.pickerView textOfSelectedRowInComponent:0];
    yearString = [yearString componentsSeparatedByString:self.yearString].firstObject;
    self.selectedComponents.year = [yearString integerValue];
}

- (void)year_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated {
    if (components.year > self.maximumComponents.year) {
        components.year = self.maximumComponents.year;
    }else if (components.year < self.minimumComponents.year) {
        components.year = self.minimumComponents.year;
    }
    NSInteger row = components.year - self.minimumComponents.year;
    [self.pickerView selectRow:row inComponent:0 animated:animated];
}
@end
