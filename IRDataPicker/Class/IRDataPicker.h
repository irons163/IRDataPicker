//
//  IRDataPicker.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSDate+IRCategory.h"
//#import "UIColor+PGHex.h"
#import "NSCalendar+IRCurrent.h"
//#import "IRPickerView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IRDataPickerMode) {
    IRDataPickerModeYear, //年
    IRDataPickerModeYearAndMonth, //年月
    IRDataPickerModeDate, //年月日
    IRDataPickerModeDateHour, //年月日时
    IRDataPickerModeDateHourMinute, //年月日时分
    IRDataPickerModeDateHourMinuteSecond, //年月日时分秒
    IRDataPickerModeMonthDay, //月日
    IRDataPickerModeMonthDayHour, //月日时
    IRDataPickerModeMonthDayHourMinute, //月日时分
    IRDataPickerModeMonthDayHourMinuteSecond, //月日时分秒
    IRDataPickerModeTime, //时分
    IRDataPickerModeTimeAndSecond, //时分秒
    IRDataPickerModeMinuteAndSecond, //分秒
    IRDataPickerModeDateAndTime, //月日周 时分
    IRDataPickerModeCustom
};

typedef NS_ENUM(NSUInteger, IRDataPickerType) {
    IRDataPickerType1,
    IRDataPickerType2,
    IRDataPickerType3,
};

typedef NS_ENUM(NSUInteger, IRShowUnitType) {
    IRShowUnitTypeAll,
    IRShowUnitTypeCenter,
    IRShowUnitTypeNone,
};

#define IRDataPickerDeprecated(instead) __attribute__((deprecated(instead)))

@protocol IRDataPickerDelegate;

@interface IRDataPicker : UIControl
@property (nonatomic, weak) id<IRDataPickerDelegate> delegate;
@property (nonatomic, assign) IRDataPickerMode datePickerMode; // default is IRDataPickerModeYear
@property(nonatomic, assign) IRDataPickerType datePickerType;

@property (nonatomic, strong) NSArray *customList;

/*
 默认是false
 如果设置为true，则不用按下确定按钮也可以得到选中的日期
 每次滑动都会自动执行IRDataPickerDelegate代理方法，得到选中的日期
 */
@property(nonatomic, assign) BOOL autoSelected;
/*
 默认是false
 如果设置为true，只会显示中间的文字，其他行的文字则不会显示
 */
@property(nonatomic, assign) BOOL middleText IRDataPickerDeprecated("已过时，请使用isHiddenMiddleText进行替换");

/**
 设置行高
 */
@property (nonatomic, assign) CGFloat rowHeight; //default is 50

/*
 默认是true
 如果设置为false，只会显示中间的文字，其他行的文字则不会显示
 */
@property(nonatomic, assign) BOOL isHiddenMiddleText; // default is true

@property(nonatomic, assign) IRShowUnitType showUnit;
@property(nonatomic, copy) UIColor *middleTextColor;

@property (nonatomic, strong)UIColor *titleColorForSelectedRow IRDataPickerDeprecated("已过时，请使用textColorOfSelectedRow进行替换");
@property (nonatomic, strong)UIColor *titleColorForOtherRow IRDataPickerDeprecated("已过时，请使用textColorOfOtherRow进行替换");

@property (nonatomic, strong)UIColor *textColorOfSelectedRow;     //default is #69BDFF
@property(nonatomic, strong) UIFont *textFontOfSelectedRow;       //default is 17

@property (nonatomic, strong)UIColor *textColorOfOtherRow;        // default is [UIColor lightGrayColor]
@property(nonatomic, strong) UIFont *textFontOfOtherRow;          //default is 17

@property(nonatomic, strong) UIColor *lineBackgroundColor;       //default is #69BDFF

@property (nonatomic, strong) NSLocale   *locale;   // default is [NSLocale currentLocale]. setting nil returns to default
@property (nonatomic, copy)   NSCalendar *calendar; // default is [NSCalendar currentCalendar]. setting nil returns to default
@property (nonatomic, strong) NSTimeZone *timeZone; // default is nil. use current time zone or time zone from calendar

@property (nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nonatomic, strong) NSDate *maximumDate; // default is nil

@property (nonatomic, copy) void(^selectedDate)(NSDateComponents *dateComponents);

@property (nonatomic, copy) void(^selectedCustom)(NSString* customString);

@property(nonatomic, assign) BOOL isHiddenWheels; // default is true  true -> hidden
/*
 简体中文  language = zh-Hans
 繁体中文  language = zh-Hant
 英语     language = en
 */
@property(nonatomic, copy) NSString *language;
/**
 相当于确定按钮，执行此方法IRDataPickerDelegate代理方法会得到值
 */
- (void)tapSelectedHandler;

- (void)setDate:(NSDate *)date;
- (void)setDate:(NSDate *)date animated:(BOOL)animated;
- (void)setRow:(NSInteger)row animated:(BOOL)animated;

//在时分的时候，只显示时
@property (nonatomic) BOOL isOnlyHourFlag;

//MonthDay
@property (nonatomic) BOOL isOnlyMonthFlag;

//分间隔 默认时1
@property (nonatomic) NSInteger minuteInterval;

//秒间隔 默认时1
@property (nonatomic) NSInteger secondInterval;

@end

@protocol IRDataPickerDelegate <NSObject>

- (void)datePicker:(IRDataPicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents;
- (void)datePicker:(IRDataPicker *)datePicker didSelectCustom:(NSString*)customString;
@end


NS_ASSUME_NONNULL_END

#import <IRDataPicker/IRDataPickerManager.h>
//#import <IRDataPicker/IRPickerView.h>
//#import "IRDataPickerManager.h"
