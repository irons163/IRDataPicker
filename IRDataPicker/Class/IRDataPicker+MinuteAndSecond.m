//
//  IRDataPicker+MinuteAndSecond.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker+MinuteAndSecond.h"
#import "IRDataPickerHeader.h"
#import "IRDataPicker+Common.h"
#import "IRDataPicker+Logic.h"

@implementation IRDataPicker (MinuteAndSecond)
- (void)minuteAndSecond_setupSelectedDate {
    NSString *minuteString = [self.pickerView textOfSelectedRowInComponent:0];
    minuteString = [minuteString componentsSeparatedByString:self.minuteString].firstObject;
    self.selectedComponents.minute = [minuteString integerValue];
    
    NSString *secondString = [self.pickerView textOfSelectedRowInComponent:1];
    secondString = [secondString componentsSeparatedByString:self.secondString].firstObject;
    self.selectedComponents.second = [secondString integerValue];
}

- (void)minuteAndSecond_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated {
    if (components.minute > self.maximumComponents.minute) {
        components = self.maximumComponents;
    }
    if (components.minute < self.minimumComponents.minute) {
        components = self.minimumComponents;
    }
    NSString *string = [NSString stringWithFormat:@"%ld", components.minute];
    if (components.minute < 10) {
        string = [NSString stringWithFormat:@"0%ld", components.minute];
    }
    NSInteger row = 0;
    BOOL isExist = [self.minuteList containsObject:string];
    if (isExist) {
        row = [self.minuteList indexOfObject:string];
    }
    [self.pickerView selectRow:row inComponent:0 animated:animated];
    {
        NSString *string = [NSString stringWithFormat:@"%ld", components.second];
        if (components.second < 10) {
            string = [NSString stringWithFormat:@"0%ld", components.second];
        }
        NSInteger row = 0;
        BOOL isExist = [self.secondList containsObject:string];
        if (isExist) {
            row = [self.secondList indexOfObject:string];
        }
        [self.pickerView selectRow:row inComponent:1 animated:animated];
    }
}

- (void)minuteAndSecond_didSelectWithComponent:(NSInteger)component {
    NSDateComponents *dateComponents = [self.calendar components:self.unitFlags fromDate:[NSDate date]];
    NSString *str = [[self.pickerView textOfSelectedRowInComponent:0] componentsSeparatedByString:self.minuteString].firstObject;
    dateComponents.minute = [str integerValue];
    if (component == 0) {
        BOOL refresh = [self setSecondList3WithComponent:component dateComponents:dateComponents refresh:true];
        [self.pickerView reloadComponent:1 refresh:refresh];
    }
}
@end

