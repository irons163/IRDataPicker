//
//  IRDataPicker.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"
#import "IRDataPickerView.h"
#import "NSBundle+IRDataPicker.h"
#import "IRDataPickerHeader.h"
#import "IRDataPicker+Year.h"
#import "IRDataPicker+YearAndMonth.h"
#import "IRDataPicker+Date.h"
#import "IRDataPicker+DateHour.h"
#import "IRDataPicker+DateHourMinute.h"
#import "IRDataPicker+DateHourMinuteSecond.h"
#import "IRDataPicker+Time.h"
#import "IRDataPicker+TimeAndSecond.h"
#import "IRDataPicker+MinuteAndSecond.h"
#import "IRDataPicker+DateAndTime.h"
#import "IRDataPicker+Common.h"
#import "IRDataPicker+Logic.h"
#import "IRDataPicker+MonthDay.h"
#import "IRDataPicker+MonthDayHour.h"
#import "IRDataPicker+MonthDayHourMinute.h"
#import "IRDataPicker+MonthDayHourMinuteSecond.h"
#import "UIColor+IRHex.h"

static NSString *const reuseIdentifier = @"IRDataPickerView";

@implementation IRDataPicker

- (instancetype)init {
    if (self = [super init]) {
        self.isHiddenMiddleText = true;
        self.isHiddenWheels = true;
        
        self.secondInterval = 1;
        self.minuteInterval = 1;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_isSelectedCancelButton) {
        return;
    }
    if (_isSubViewLayout) {
        return;
    }
    self.selectedComponents = [self.calendar components:self.unitFlags fromDate:[NSDate date]];
    _isSubViewLayout = true;
    [self setupPickerView];
}

- (void)setupPickerView {
    if (_setDate) {
        self.selectComponents = [self.calendar components:self.unitFlags fromDate:_setDate];
    }else {
        self.selectComponents = [self.calendar components:self.unitFlags fromDate:[NSDate date]];
    }
    NSInteger day = [self howManyDaysWithMonthInThisYear:self.selectComponents.year withMonth:self.selectComponents.month];
    [self setDayListForMonthDays:day];
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = self.safeAreaInsets.bottom;
    }
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - bottom);
    IRPickerView *pickerView = [[IRPickerView alloc]initWithFrame:frame];
    if (_middleText) {
        self.isHiddenMiddleText = !_middleText;
    }
    pickerView.rowHeight = self.rowHeight;
    pickerView.isHiddenMiddleText = self.isHiddenMiddleText;
    pickerView.middleTextColor = self.middleTextColor;
    pickerView.isHiddenWheels = self.isHiddenWheels;
    pickerView.lineBackgroundColor = self.lineBackgroundColor;
    if (_titleColorForOtherRow) {
        self.textColorOfOtherRow = _titleColorForOtherRow;
    }
    if (_titleColorForSelectedRow) {
        self.textColorOfSelectedRow = _titleColorForSelectedRow;
    }
    pickerView.textColorOfSelectedRow = self.textColorOfSelectedRow;
    pickerView.textFontOfSelectedRow = self.textFontOfSelectedRow;
    pickerView.textColorOfOtherRow = self.textColorOfOtherRow;
    pickerView.textFontOfOtherRow = self.textFontOfOtherRow;
    pickerView.type = (IRPickerViewLineType)self.datePickerType;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    if (_setDate) {
        [self setDate:_setDate animated:_isSetDateAnimation];
    }else {
        _setDate = [NSDate date];
        [self setDate:_setDate animated:false];
    }
    
    switch (self.datePickerMode) {
        case IRDataPickerModeCustom:
            [self setRow:_setRow animated:_isSetDateAnimation];
            break;
        default:
            break;
    }
}

- (void)tapSelectedHandler {
    if (self.autoSelected == false) {
        [self selectedDateLogic];
    }
}

- (void)selectedDateLogic {
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
        {
            [self year_setupSelectedDate];
        }
            break;
        case IRDataPickerModeYearAndMonth:
        {
            [self yearAndMonth_setupSelectedDate];
        }
            break;
        case IRDataPickerModeDate:
        {
            [self date_setupSelectedDate];
        }
            break;
        case IRDataPickerModeDateHour:
        {
            [self dateHour_setupSelectedDate];
        }
            break;
        case IRDataPickerModeDateHourMinute:
        {
            [self dateHourMinute_setupSelectedDate];
        }
            break;
        case IRDataPickerModeDateHourMinuteSecond:
        {
            [self dateHourMinuteSecond_setupSelectedDate];
        }
            break;
        case IRDataPickerModeMonthDay:
        {
            [self monthDay_setupSelectedDate];
        }
            break;
        case IRDataPickerModeMonthDayHour:
        {
            [self monthDayHour_setupSelectedDate];
        }
            break;
        case IRDataPickerModeMonthDayHourMinute:
        {
            [self monthDayHourMinute_setupSelectedDate];
        }
            break;
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            [self monthDayHourMinuteSecond_setupSelectedDate];
        }
            break;
        case IRDataPickerModeTime:
        {
            [self time_setupSelectedDate];
        }
            break;
        case IRDataPickerModeTimeAndSecond:
        {
            [self timeAndSecond_setupSelectedDate];
        }
            break;
        case IRDataPickerModeMinuteAndSecond:
        {
            [self minuteAndSecond_setupSelectedDate];
        }
            break;
        case IRDataPickerModeDateAndTime:
        {
            [self dateAndTime_setupSelectedDate];
        }
            break;
        case IRDataPickerModeCustom:
        {
            NSString *string = [self.pickerView textOfSelectedRowInComponent:0];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:didSelectCustom:)]) {
                [self.delegate datePicker:self didSelectCustom:string];
            }
            if (self.selectedCustom) {
                self.selectedCustom(string);
            }
        }
            return;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:didSelectDate:)]) {
        [self.delegate datePicker:self didSelectDate:self.selectedComponents];
    }
    if (self.selectedDate) {
        self.selectedDate(self.selectedComponents);
    }
}

- (NSInteger)rowsInComponent:(NSInteger)component {
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
            return self.yearList.count;
        case IRDataPickerModeYearAndMonth:
        {
            if (component == 1) {
                return self.monthList.count;
            }
            return self.yearList.count;
        }
        case IRDataPickerModeDate:
        {
            if (component == 1) {
                return self.monthList.count;
            }
            if (component == 2) {
                return self.dayList.count;
            }
            return self.yearList.count;
        }
        case IRDataPickerModeDateHour:
        {
            if (component == 0) {
                return self.yearList.count;
            }
            if (component == 1) {
                return self.monthList.count;
            }
            if (component == 2) {
                return self.dayList.count;
            }
            if (component == 3) {
                return self.hourList.count;
            }
        }
        case IRDataPickerModeDateHourMinute:
        {
            if (component == 0) {
                return self.yearList.count;
            }
            if (component == 1) {
                return self.monthList.count;
            }
            if (component == 2) {
                return self.dayList.count;
            }
            if (component == 3) {
                return self.hourList.count;
            }
            if (component == 4) {
                return self.minuteList.count;
            }
        }
        case IRDataPickerModeDateHourMinuteSecond:
        {
            if (component == 0) {
                return self.yearList.count;
            }
            if (component == 1) {
                return self.monthList.count;
            }
            if (component == 2) {
                return self.dayList.count;
            }
            if (component == 3) {
                return self.hourList.count;
            }
            if (component == 4) {
                return self.minuteList.count;
            }
            if (component == 5) {
                return self.secondList.count;
            }
        }
        case IRDataPickerModeMonthDay:
        {
            if (component == 1) {
                return self.dayList.count;
            }
            return self.monthList.count;
        }
        case IRDataPickerModeMonthDayHour:
        {
            if (component == 0) {
                return self.monthList.count;
            }
            if (component == 1) {
                return self.dayList.count;
            }
            if (component == 2) {
                return self.hourList.count;
            }
        }
        case IRDataPickerModeMonthDayHourMinute:
        {
            if (component == 0) {
                return self.monthList.count;
            }
            if (component == 1) {
                return self.dayList.count;
            }
            if (component == 2) {
                return self.hourList.count;
            }
            if (component == 3) {
                return self.minuteList.count;
            }
        }
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            if (component == 0) {
                return self.monthList.count;
            }
            if (component == 1) {
                return self.dayList.count;
            }
            if (component == 2) {
                return self.hourList.count;
            }
            if (component == 3) {
                return self.minuteList.count;
            }
            if (component == 4) {
                return self.secondList.count;
            }
        }
        case IRDataPickerModeTime:
        {
            if (component == 1) {
                return self.minuteList.count;
            }
            return self.hourList.count;
        }
        case IRDataPickerModeTimeAndSecond:
        {
            if (component == 0) {
                return self.hourList.count;
            }
            if (component == 1) {
                return self.minuteList.count;
            }
            if (component == 2) {
                return self.secondList.count;
            }
        }
        case IRDataPickerModeMinuteAndSecond:
        {
            if (component == 0) {
                return self.minuteList.count;
            }
            if (component == 1) {
                return self.secondList.count;
            }
        }
        case IRDataPickerModeDateAndTime:
        {
            if (component == 1) {
                return self.hourList.count;
            }
            if (component == 2) {
                return self.minuteList.count;
            }
            return self.dateAndTimeList.count;
        }
        case IRDataPickerModeCustom:
        {
            return self.customList.count;
        }
        default:
            break;
    }
    return 0;
}

- (void)setDate:(NSDate *)date {
    [self setDate:date animated:false];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    _isSetDateAnimation = animated;
    _setDate = date;
    if (!_isSubViewLayout) {
        return;
    }
    NSDateComponents *components = [self.calendar components:self.unitFlags fromDate:_setDate];
    if (self.minimumDate == nil && animated && !_isSetDate) {
        NSInteger year = components.year - 10;
        if (year <= self.minimumComponents.year) {
            year = self.minimumComponents.year;
        }else {
            components.year = year;
        }
        components.month = 1;
        components.day = 1;
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        _isSetDate = true;
        animated = false;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self setDate:_setDate animated:_isSetDateAnimation];
        });
    }
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
        {
            [self year_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeYearAndMonth:
        {
            [self yearAndMonth_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeDate:
        {
            [self date_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeDateHour:
        {
            [self dateHour_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeDateHourMinute:
        {
            [self dateHourMinute_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeDateHourMinuteSecond:
        {
            [self dateHourMinuteSecond_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeMonthDay:
        {
            [self monthDay_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeMonthDayHour:
        {
            [self monthDayHour_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeMonthDayHourMinute:
        {
            [self monthDayHourMinute_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            [self monthDayHourMinuteSecond_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeTime:
        {
            [self time_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeTimeAndSecond:
        {
            [self timeAndSecond_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeMinuteAndSecond:
        {
            [self minuteAndSecond_setDateWithComponents:components animated:animated];
        }
            break;
            
        case IRDataPickerModeDateAndTime:
        {
            [self dateAndTime_setDateWithComponents:components animated:animated];
        }
            break;
        case IRDataPickerModeCustom:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)setRow:(NSInteger)row animated:(BOOL)animated {
    _isSetDateAnimation = animated;
    _setRow = row;
    if (!_isSubViewLayout) {
        return;
    }
    _isSetDate = true;
    
    switch (self.datePickerMode) {
        case IRDataPickerModeCustom:
        {
            [self.pickerView selectRow:row inComponent:0 animated:animated];
        }
            break;
        default:
            break;
    }
}

#pragma mark - IRPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(IRPickerView *)pickerView {
    return self.components;
}

- (NSInteger)pickerView:(IRPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self rowsInComponent:component];
}

- (void)pickerView:(IRPickerView *)pickerView title:(NSString *)title didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (!_isDelay && _isSetDateAnimation) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.40 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            _isDelay = true;
        });
        return;
    }
    row = row + 1;
    switch (self.datePickerMode) {
        case IRDataPickerModeYearAndMonth:
        {
            [self yearAndMonth_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeDate:
        {
            [self date_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeDateHour:
        {
            [self dateHour_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeDateHourMinute:
        {
            [self dateHourMinute_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeDateHourMinuteSecond:
        {
            [self dateHourMinuteSecond_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeMonthDay:
        {
            [self monthDay_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeMonthDayHour:
        {
            [self monthDayHour_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeMonthDayHourMinute:
        {
            [self monthDayHourMinute_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            [self monthDayHourMinuteSecond_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeTime:
        {
            [self time_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeTimeAndSecond:
        {
            [self timeAndSecond_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeMinuteAndSecond:
        {
            [self minuteAndSecond_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeDateAndTime:
        {
            [self dateAndTime_didSelectWithComponent:component];
        }
            break;
        case IRDataPickerModeCustom:
        {
            
        }
            break;
        default:
            break;
    }
    if (self.autoSelected) {
        [self selectedDateLogic];
    }
}

- (NSString *)pickerView:(IRPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
            return [self.yearList[row] stringByAppendingString:self.yearString];
        case IRDataPickerModeYearAndMonth:
        {
            if (component == 1) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            return [self.yearList[row] stringByAppendingString:self.yearString];
        }
        case IRDataPickerModeDate:
        {
            if (component == 1) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 2) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            return [self.yearList[row] stringByAppendingString:self.yearString];
        }
        case IRDataPickerModeDateHour:
        {
            if (component == 0) {
                return [self.yearList[row] stringByAppendingString:self.yearString];
            }
            if (component == 1) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 2) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 3) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
        }
        case IRDataPickerModeDateHourMinute:
        {
            if (component == 0) {
                return [self.yearList[row] stringByAppendingString:self.yearString];
            }
            if (component == 1) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 2) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 3) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 4) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
        }
        case IRDataPickerModeDateHourMinuteSecond:
        {
            if (component == 0) {
                return [self.yearList[row] stringByAppendingString:self.yearString];
            }
            if (component == 1) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 2) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 3) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 4) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            if (component == 5) {
                return [self.secondList[row] stringByAppendingString:self.secondString];
            }
        }
        case IRDataPickerModeMonthDay:
        {
            if (component == 0) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            return [self.dayList[row] stringByAppendingString:self.dayString];
        }
        case IRDataPickerModeMonthDayHour:
        {
            if (component == 0) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 1) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 2) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
        }
        case IRDataPickerModeMonthDayHourMinute:
        {
            if (component == 0) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 1) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 2) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 3) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
        }
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            if (component == 0) {
                return [self.monthList[row] stringByAppendingString:self.monthString];
            }
            if (component == 1) {
                return [self.dayList[row] stringByAppendingString:self.dayString];
            }
            if (component == 2) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 3) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            if (component == 4) {
                return [self.secondList[row] stringByAppendingString:self.secondString];
            }
        }
        case IRDataPickerModeTime:
        {
            if (component == 1) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            return [self.hourList[row] stringByAppendingString:self.hourString];
        }
        case IRDataPickerModeTimeAndSecond:
        {
            if (component == 0) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 1) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            if (component == 2) {
                return [self.secondList[row] stringByAppendingString:self.secondString];
            }
        }
        case IRDataPickerModeMinuteAndSecond:
        {
            if (component == 0) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            if (component == 1) {
                return [self.secondList[row] stringByAppendingString:self.secondString];
            }
        }
        case IRDataPickerModeDateAndTime:
        {
            if (component == 1) {
                return [self.hourList[row] stringByAppendingString:self.hourString];
            }
            if (component == 2) {
                return [self.minuteList[row] stringByAppendingString:self.minuteString];
            }
            return self.dateAndTimeList[row];
        }
        case IRDataPickerModeCustom:
        {
            return self.customList[row];
        }
        default:
            break;
    }
    return @"";
}

- (NSString *)pickerView:(IRPickerView *)pickerView middleTextForcomponent:(NSInteger)component {
    if (_showUnit == IRShowUnitTypeNone) {
        return @"";
    }
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
            return self.middleYearString;
        case IRDataPickerModeYearAndMonth:
        {
            if (component == 1) {
                return self.middleMonthString;
            }
            return self.middleYearString;
        }
        case IRDataPickerModeDate:
        {
            if (component == 1) {
                return self.middleMonthString;
            }
            if (component == 2) {
                return self.middleDayString;
            }
            return self.middleYearString;
        }
        case IRDataPickerModeDateHour:
        {
            if (component == 0) {
                return self.middleYearString;
            }
            if (component == 1) {
                return self.middleMonthString;
            }
            if (component == 2) {
                return self.middleDayString;
            }
            if (component == 3) {
                return self.middleHourString;
            }
        }
        case IRDataPickerModeDateHourMinute:
        {
            if (component == 0) {
                return self.middleYearString;
            }
            if (component == 1) {
                return self.middleMonthString;
            }
            if (component == 2) {
                return self.middleDayString;
            }
            if (component == 3) {
                return self.middleHourString;
            }
            if (component == 4) {
                return self.middleMinuteString;
            }
        }
        case IRDataPickerModeDateHourMinuteSecond:
        {
            if (component == 0) {
                return self.middleYearString;
            }
            if (component == 1) {
                return self.middleMonthString;
            }
            if (component == 2) {
                return self.middleDayString;
            }
            if (component == 3) {
                return self.middleHourString;
            }
            if (component == 4) {
                return self.middleMinuteString;
            }
            if (component == 5) {
                return self.middleSecondString;
            }
        }
        case IRDataPickerModeMonthDay:
        {
            if (component == 0) {
                return self.middleMonthString;
            }
            return self.middleDayString;
        }
        case IRDataPickerModeMonthDayHour:
        {
            if (component == 0) {
                return self.middleMonthString;
            }
            if (component == 1) {
                return self.middleDayString;
            }
            if (component == 2) {
                return self.middleHourString;
            }
        }
        case IRDataPickerModeMonthDayHourMinute:
        {
            if (component == 0) {
                return self.middleMonthString;
            }
            if (component == 1) {
                return self.middleDayString;
            }
            if (component == 2) {
                return self.middleHourString;
            }
            if (component == 3) {
                return self.middleMinuteString;
            }
        }
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            if (component == 0) {
                return self.middleMonthString;
            }
            if (component == 1) {
                return self.middleDayString;
            }
            if (component == 2) {
                return self.middleHourString;
            }
            if (component == 3) {
                return self.middleMinuteString;
            }
            if (component == 4) {
                return self.middleSecondString;
            }
        }
        case IRDataPickerModeTime:
        {
            if (component == 1) {
                return self.middleMinuteString;
            }
            return self.middleHourString;
        }
        case IRDataPickerModeTimeAndSecond:
        {
            if (component == 0) {
                return self.middleHourString;
            }
            if (component == 1) {
                return self.middleMinuteString;
            }
            if (component == 2) {
                return self.middleSecondString;
            }
        }
        case IRDataPickerModeMinuteAndSecond:
        {
            if (component == 0) {
                return self.middleMinuteString;
            }
            if (component == 1) {
                return self.middleSecondString;
            }
        }
        case IRDataPickerModeDateAndTime:
        {
            if (component == 1) {
                return self.middleHourString;
            }
            if (component == 2) {
                return self.middleMinuteString;
            }
            return @"";
        }
        case IRDataPickerModeCustom:
        {
            return @"";
        }
        default:
            break;
    }
    return @"";
}

- (CGFloat)pickerView:(IRPickerView *)pickerView middleTextSpaceForcomponent:(NSInteger)component {
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
            return 20;
        case IRDataPickerModeYearAndMonth:
        {
            if (component == 0) {
                return 20;
            }
            if (component == 1) {
                return 10;
            }
        }
        case IRDataPickerModeDate:
        {
            if (component == 0) {
                return 22;
            }
            if (component == 1) {
                return 10;
            }
            if (component == 2) {
                return 10;
            }
        }
        case IRDataPickerModeDateHour:
        {
            if (component == 0) {
                return 20;
            }
            if (component == 1) {
                return 10;
            }
            if (component == 2) {
                return 10;
            }
            if (component == 3) {
                return 10;
            }
        }
        case IRDataPickerModeDateHourMinute:
        {
            if (component == 0) {
                return 20;
            }
            if (component == 1) {
                return 10;
            }
            if (component == 2) {
                return 10;
            }
            if (component == 3) {
                return 10;
            }
            if (component == 4) {
                return 10;
            }
        }
        case IRDataPickerModeDateHourMinuteSecond:
        {
            if (component == 0) {
                return 17;
            }
            if (component == 1) {
                return 10;
            }
            if (component == 2) {
                return 10;
            }
            if (component == 3) {
                return 10;
            }
            if (component == 4) {
                return 10;
            }
            if (component == 5) {
                return 13;
            }
        }
        case IRDataPickerModeMonthDay:
        {
            return 10;
        }
        case IRDataPickerModeMonthDayHour:
        {
            return 10;
        }
        case IRDataPickerModeMonthDayHourMinute:
        {
            return 10;
        }
        case IRDataPickerModeMonthDayHourMinuteSecond:
        {
            return 10;
        }
        case IRDataPickerModeTime:
        {
            if (component == 0) {
                return 17;
            }
            if (component == 1) {
                return 13;
            }
        }
        case IRDataPickerModeTimeAndSecond:
        {
            if (component == 0) {
                return 17;
            }
            if (component == 1) {
                return 13;
            }
            if (component == 2) {
                return 13;
            }
        }
        case IRDataPickerModeMinuteAndSecond:
        {
            if (component == 0) {
                return 17;
            }
            if (component == 1) {
                return 13;
            }
        }
        case IRDataPickerModeDateAndTime:
        {
            if (component == 0) {
                return 17;
            }
            if (component == 1) {
                return 13;
            }
            if (component == 2) {
                return 13;
            }
        }
        case IRDataPickerModeCustom:
        {
            if (component == 0) {
                return 17;
            }
        }
        default:
            break;
    }
    return 0;
}

#pragma mark - Setter

- (void)setDatePickerMode:(IRDataPickerMode)datePickerMode {
    _datePickerMode = datePickerMode;
    [self.pickerView reloadAllComponents];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.minimumComponents = [self.calendar components:self.unitFlags fromDate:minimumDate];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.maximumComponents = [self.calendar components:self.unitFlags fromDate:maximumDate];
}

#pragma mark - Getter
- (NSDateComponents *)minimumComponents {
    if (self.minimumDate) {
        _minimumComponents = [self.calendar components:self.unitFlags fromDate:self.minimumDate];
    }else {
        _minimumComponents = [self.calendar components:self.unitFlags fromDate:[NSDate distantPast]];
        _minimumComponents.day = 1;
        _minimumComponents.month = 1;
        _minimumComponents.hour = 0;
        _minimumComponents.minute = 0;
        _minimumComponents.second = 0;
    }
    return _minimumComponents;
}

- (NSDateComponents *)maximumComponents {
    if (self.maximumDate) {
        _maximumComponents = [self.calendar components:self.unitFlags fromDate:self.maximumDate];
    }else {
        _maximumComponents = [self.calendar components:self.unitFlags fromDate:[NSDate distantFuture]];
        NSInteger day = [self howManyDaysWithMonthInThisYear:self.currentComponents.year withMonth:self.currentComponents.month];
        _maximumComponents.day = day;
        _maximumComponents.month = 12;
        _maximumComponents.hour = 23;
        _maximumComponents.minute = 59;
        _maximumComponents.second = 59;
    }
    return _maximumComponents;
}

- (NSDateComponents *)currentComponents {
    if (!_currentComponents) {
        _currentComponents = [self.calendar components:self.unitFlags fromDate:[NSDate date]];
    }
    return _currentComponents;
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
        _calendar.timeZone = self.timeZone;
        _calendar.locale = self.locale;
    }
    return _calendar;
}

- (NSLocale *)locale {
    if (!_locale) {
        _locale = [NSLocale currentLocale];
    }
    return _locale;
}

- (BOOL)isHiddenMiddleText{
    if (_showUnit == IRShowUnitTypeCenter) {
        return NO;
    }else if (_showUnit == IRShowUnitTypeAll){
        return YES;
    }
    return _isHiddenMiddleText;
}

- (NSArray *)yearList {
    if (!_yearList) {
        NSInteger index = self.maximumComponents.year - self.minimumComponents.year;
        NSMutableArray *years = [NSMutableArray arrayWithCapacity:index];
        for (NSUInteger i = self.minimumComponents.year; i <= self.maximumComponents.year; i++) {
            [years addObject:[@(i) stringValue]];
        }
        _yearList = years;
    }
    return _yearList;
}

- (NSArray *)monthList {
    if (!_monthList) {
        NSInteger minimum = 1;
        NSInteger maximum = 12;
        if (_setDate == nil && self.maximumComponents.year <= self.currentComponents.year) {
            maximum = self.maximumComponents.month;
        }
        if (self.selectComponents.year == self.minimumComponents.year) {
            minimum = self.minimumComponents.month;
        }
        if (self.selectComponents.year == self.maximumComponents.year) {
            maximum = self.maximumComponents.month;
        }
        if (self.minimumComponents.year == self.maximumComponents.year) {
            minimum = self.minimumComponents.month;
            maximum = self.maximumComponents.month;
            
        }
        NSMutableArray *months = [NSMutableArray arrayWithCapacity:maximum];
        for (NSUInteger i = minimum; i <= maximum; i++) {
            [months addObject:[@(i) stringValue]];
        }
        _monthList = months;
    }
    return _monthList;
}

- (NSArray *)hourList {
    if (!_hourList) {
        NSInteger minimum = 0;
        NSInteger maximum = 23;
        
        if (self.selectComponents.year == self.maximumComponents.year &&
            self.selectComponents.month == self.maximumComponents.month &&
            self.selectComponents.day == self.maximumComponents.day) {
            maximum = self.maximumComponents.hour;
        }
        if (self.selectComponents.year == self.minimumComponents.year &&
            self.selectComponents.month == self.minimumComponents.month &&
            self.selectComponents.day == self.minimumComponents.day) {
            minimum = self.minimumComponents.hour;
        }
        if (self.maximumComponents.year == self.minimumComponents.year &&
            self.maximumComponents.month == self.minimumComponents.month &&
            self.maximumComponents.day == self.minimumComponents.day) {
            minimum = self.minimumComponents.hour;
            maximum = self.maximumComponents.hour;
        }
        NSInteger index = maximum - minimum;
        if (self.datePickerMode == IRDataPickerModeTime || self.datePickerMode == IRDataPickerModeTimeAndSecond) {
            index = self.maximumComponents.hour - self.minimumComponents.hour;
            minimum = self.minimumComponents.hour;
            maximum = self.maximumComponents.hour;
            if (index < 0) {
                index = 23;
                minimum = 0;
                maximum = index;
            }
        }
        NSMutableArray *hours = [NSMutableArray arrayWithCapacity:index];
        for (NSUInteger i = minimum; i <= maximum; i++) {
            if (i < 10) {
                [hours addObject:[NSString stringWithFormat:@"0%ld", i]];
            }else {
                [hours addObject:[@(i) stringValue]];
            }
        }
        _hourList = hours;
    }
    return _hourList;
}

- (NSArray *)minuteList {
    if (!_minuteList) {
        NSInteger minimum = 0;
        NSInteger maximum = 59;
        if (self.selectComponents.year == self.maximumComponents.year &&
            self.selectComponents.month == self.maximumComponents.month &&
            self.selectComponents.day == self.maximumComponents.day &&
            self.selectComponents.hour >= self.maximumComponents.hour) {
            maximum = self.maximumComponents.minute;
        }
        if (self.selectComponents.year == self.minimumComponents.year &&
            self.selectComponents.month == self.minimumComponents.month &&
            self.selectComponents.day == self.minimumComponents.day &&
            self.selectComponents.hour <= self.minimumComponents.hour) {
            minimum = self.minimumComponents.minute;
        }
        if (self.maximumComponents.year == self.minimumComponents.year &&
            self.maximumComponents.month == self.minimumComponents.month &&
            self.maximumComponents.day == self.minimumComponents.day &&
            self.maximumComponents.hour == self.minimumComponents.hour) {
            minimum = self.minimumComponents.minute;
            maximum = self.maximumComponents.minute;
        }
        if (self.datePickerMode == IRDataPickerModeTime || self.datePickerMode == IRDataPickerModeTimeAndSecond) {
            if (self.selectComponents.hour == self.minimumComponents.hour) {
                minimum = self.minimumComponents.minute;
            }
            if (self.selectComponents.hour == self.maximumComponents.hour) {
                maximum = self.maximumComponents.minute;
            }
        }
        NSInteger index = maximum - minimum;
        if (self.datePickerMode == IRDataPickerModeMinuteAndSecond) {
            index = self.maximumComponents.minute - self.minimumComponents.minute;
            minimum = self.minimumComponents.minute;
            maximum = self.maximumComponents.minute;
            if (index < 0) {
                index = 23;
                minimum = 0;
                maximum = index;
            }
        }
        NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:index];
        for (NSUInteger i = minimum; i <= maximum; i+=self.minuteInterval) {
            if (i < 10) {
                [minutes addObject:[NSString stringWithFormat:@"0%ld", i]];
            }else {
                [minutes addObject:[@(i) stringValue]];
            }
        }
        _minuteList = minutes;
    }
    return _minuteList;
}

- (NSArray *)secondList {
    if (!_secondList) {
        NSInteger minimum = 0;
        NSInteger maximum = 59;
        if (self.selectComponents.year == self.maximumComponents.year &&
            self.selectComponents.month == self.maximumComponents.month &&
            self.selectComponents.day == self.maximumComponents.day &&
            self.selectComponents.hour == self.maximumComponents.hour &&
            self.selectComponents.minute == self.maximumComponents.minute) {
            maximum = self.maximumComponents.second;
        }
        if (self.selectComponents.year == self.minimumComponents.year &&
            self.selectComponents.month == self.minimumComponents.month &&
            self.selectComponents.day == self.minimumComponents.day &&
            self.selectComponents.hour == self.minimumComponents.hour &&
            self.selectComponents.minute == self.minimumComponents.minute) {
            minimum = self.minimumComponents.second;
        }
        if (self.maximumComponents.year == self.minimumComponents.year &&
            self.maximumComponents.month == self.minimumComponents.month &&
            self.maximumComponents.day == self.minimumComponents.day &&
            self.maximumComponents.hour == self.minimumComponents.hour &&
            self.maximumComponents.minute == self.minimumComponents.minute) {
            minimum = self.minimumComponents.second;
            maximum = self.maximumComponents.second;
        }
        if (self.datePickerMode == IRDataPickerModeTime || self.datePickerMode == IRDataPickerModeTimeAndSecond) {
            if (self.selectComponents.hour == self.minimumComponents.hour &&
                self.selectComponents.minute == self.minimumComponents.minute) {
                minimum = self.minimumComponents.second;
            }
            if (self.selectComponents.hour == self.maximumComponents.hour &&
                self.selectComponents.minute == self.maximumComponents.minute) {
                maximum = self.maximumComponents.second;
            }
        }
        NSInteger index = maximum - minimum;
        NSMutableArray *seconds = [NSMutableArray arrayWithCapacity:index];
        for (NSUInteger i = minimum; i <= maximum; i+=self.secondInterval) {
            if (i < 10) {
                [seconds addObject:[NSString stringWithFormat:@"0%ld", i]];
            }else {
                [seconds addObject:[@(i) stringValue]];
            }
        }
        _secondList = seconds;
    }
    return _secondList;
}

- (NSArray *)dateAndTimeList {
    if (!_dateAndTimeList) {
        NSMutableArray *array = [NSMutableArray array];
        NSInteger firstIndex = self.minimumComponents.month - 1;
        NSInteger lastIndex = self.maximumComponents.month - 1;
        NSString *monthString = [NSBundle IR_localizedStringForKey:@"monthString" language:self.language];
        NSString *dayString = [NSBundle IR_localizedStringForKey:@"dayString" language:self.language];
        
        for (NSInteger i = firstIndex; i <= lastIndex; i++) {
            NSString *month = self.monthList[i];
            NSInteger day = [self howManyDaysWithMonthInThisYear:self.currentComponents.year withMonth:[month integerValue]];
            {
                NSMutableArray *days = [NSMutableArray arrayWithCapacity:day];
                NSInteger minDay = 1, maxDay = day;
                if (i == firstIndex) {
                    minDay = self.minimumComponents.day;
                }
                if (i == lastIndex && self.maximumComponents.day != 1) {
                    maxDay = self.maximumComponents.day;
                }
                for (NSUInteger i = minDay; i <= maxDay; i++) {
                    [days addObject:[@(i) stringValue]];
                }
                self.dayList = days;
            }
            [self.dayList enumerateObjectsUsingBlock:^(NSString*  _Nonnull day, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger weekDay = [self.calendar component:NSCalendarUnitWeekday fromDate:[NSDate setYear:self.currentComponents.year month:[month integerValue] day:[day integerValue]]];
                
                NSString *string = [NSString stringWithFormat:@"%@%@%@%@ %@ ", month, monthString, day, dayString, [self weekMappingFrom:weekDay]];
                [array addObject:string];
            }];
        }
        _dateAndTimeList = array;
    }
    return _dateAndTimeList;
}

- (NSCalendarUnit)unitFlags {
    if (!_unitFlags) {
        _unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    }
    return _unitFlags;
}

- (NSInteger)components {
    switch (self.datePickerMode) {
        case IRDataPickerModeYear:
            return 1;
        case IRDataPickerModeYearAndMonth:
            return 2;
        case IRDataPickerModeDate:
            return 3;
        case IRDataPickerModeDateHour:
            return 4;
        case IRDataPickerModeDateHourMinute:
            return 5;
        case IRDataPickerModeDateHourMinuteSecond:
            return 6;
        case IRDataPickerModeMonthDay:
            if(!self.isOnlyMonthFlag) {
                return 2;
            }
            else return 1;
        case IRDataPickerModeMonthDayHour:
            return 3;
        case IRDataPickerModeMonthDayHourMinute:
            return 4;
        case IRDataPickerModeMonthDayHourMinuteSecond:
            return 5;
        case IRDataPickerModeTime:
            if(!self.isOnlyHourFlag) {
                return 2;
            }
            else return 1;
        case IRDataPickerModeTimeAndSecond:
            return 3;
        case IRDataPickerModeMinuteAndSecond:
            return 2;
        case IRDataPickerModeDateAndTime:
            return 3;
        case IRDataPickerModeCustom:
            return 1;
        default:
            break;
    }
    return 0;
}

- (UIColor *)lineBackgroundColor {
    if (!_lineBackgroundColor) {
        _lineBackgroundColor = [UIColor ir_colorWithHexString:@"#69BDFF"];
    }
    return _lineBackgroundColor;
}

- (UIColor *)textColorOfOtherRow {
    if (!_textColorOfOtherRow) {
        _textColorOfOtherRow = [UIColor lightGrayColor];
    }
    return _textColorOfOtherRow;
}

- (UIColor *)textColorOfSelectedRow {
    if (!_textColorOfSelectedRow) {
        _textColorOfSelectedRow = [UIColor ir_colorWithHexString:@"#69BDFF"];
    }
    return _textColorOfSelectedRow;
}

- (UIFont *)textFontOfSelectedRow {
    if (!_textFontOfSelectedRow) {
        _textFontOfSelectedRow = [UIFont systemFontOfSize:17];
    }
    return _textFontOfSelectedRow;
}

- (UIFont *)textFontOfOtherRow {
    if (!_textFontOfOtherRow) {
        _textFontOfOtherRow = [UIFont systemFontOfSize:17];
    }
    return _textFontOfOtherRow;
}

- (CGFloat)rowHeight {
    if (!_rowHeight) {
        _rowHeight = 50;
    }
    return _rowHeight;
}

- (UIColor *)middleTextColor {
    if (!_middleTextColor) {
        _middleTextColor = [UIColor ir_colorWithHexString:@"#69BDFF"];
    }
    return _middleTextColor;
}

- (NSString *)yearString {
    if (!_yearString) {
        if (!self.isHiddenMiddleText) {
            _yearString = @"";
        }else {
            _yearString = [NSBundle IR_localizedStringForKey:@"yearString" language:self.language];
        }
    }
    return _yearString;
}

- (NSString *)middleYearString {
    if (!_middleYearString) {
        _middleYearString = [NSBundle IR_localizedStringForKey:@"yearString" language:self.language];
    }
    return _middleYearString;
}

- (NSString *)monthString {
    if (!_monthString) {
        if (!self.isHiddenMiddleText) {
            _monthString = @"";
        }else {
            _monthString = [NSBundle IR_localizedStringForKey:@"monthString" language:self.language];
        }
    }
    return _monthString;
}

- (NSString *)middleMonthString {
    if (!_middleMonthString) {
        _middleMonthString = [NSBundle IR_localizedStringForKey:@"monthString" language:self.language];
    }
    return _middleMonthString;
}

- (NSString *)dayString {
    if (!_dayString) {
        if (!self.isHiddenMiddleText) {
            _dayString = @"";
        }else {
            _dayString = [NSBundle IR_localizedStringForKey:@"dayString" language:self.language];
        }
    }
    return _dayString;
}

- (NSString *)middleDayString {
    if (!_middleDayString) {
        _middleDayString = [NSBundle IR_localizedStringForKey:@"dayString" language:self.language];
    }
    return _middleDayString;
}

- (NSString *)hourString {
    if (!_hourString) {
        if (!self.isHiddenMiddleText) {
            _hourString = @"";
        }else {
            _hourString = [NSBundle IR_localizedStringForKey:@"hourString" language:self.language];
        }
    }
    return _hourString;
}

- (NSString *)middleHourString {
    if (!_middleHourString) {
        _middleHourString = [NSBundle IR_localizedStringForKey:@"hourString" language:self.language];
    }
    return _middleHourString;
}

- (NSString *)minuteString {
    if (!_minuteString) {
        if (!self.isHiddenMiddleText) {
            _minuteString = @"";
        }else {
            _minuteString = [NSBundle IR_localizedStringForKey:@"minuteString" language:self.language];
        }
    }
    return _minuteString;
}

- (NSString *)middleMinuteString {
    if (!_middleMinuteString) {
        _middleMinuteString = [NSBundle IR_localizedStringForKey:@"minuteString" language:self.language];
    }
    return _middleMinuteString;
}

- (NSString *)secondString {
    if (!_secondString) {
        if (!self.isHiddenMiddleText) {
            _secondString = @"";
        }else {
            _secondString = [NSBundle IR_localizedStringForKey:@"secondString" language:self.language];
        }
    }
    return _secondString;
}

- (NSString *)middleSecondString {
    if (!_middleSecondString) {
        _middleSecondString = [NSBundle IR_localizedStringForKey:@"secondString" language:self.language];
    }
    return _middleSecondString;
}

- (NSString *)mondayString {
    if (!_mondayString) {
        _mondayString = [NSBundle IR_localizedStringForKey:@"mondayString" language:self.language];
    }
    return _mondayString;
}

- (NSString *)tuesdayString {
    if (!_tuesdayString) {
        _tuesdayString = [NSBundle IR_localizedStringForKey:@"tuesdayString" language:self.language];
    }
    return _tuesdayString;
}

- (NSString *)wednesdayString {
    if (!_wednesdayString) {
        _wednesdayString = [NSBundle IR_localizedStringForKey:@"wednesdayString" language:self.language];
    }
    return _wednesdayString;
}

- (NSString *)thursdayString {
    if (!_thursdayString) {
        _thursdayString = [NSBundle IR_localizedStringForKey:@"thursdayString" language:self.language];
    }
    return _thursdayString;
}

- (NSString *)fridayString {
    if (!_fridayString) {
        _fridayString = [NSBundle IR_localizedStringForKey:@"fridayString" language:self.language];
    }
    return _fridayString;
}

- (NSString *)saturdayString {
    if (!_saturdayString) {
        _saturdayString = [NSBundle IR_localizedStringForKey:@"saturdayString" language:self.language];
    }
    return _saturdayString;
}

- (NSString *)sundayString {
    if (!_sundayString) {
        _sundayString = [NSBundle IR_localizedStringForKey:@"sundayString" language:self.language];
    }
    return _sundayString;
}
@end

