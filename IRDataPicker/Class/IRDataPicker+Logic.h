//
//  IRDataPicker+Logic.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPicker (Logic)
- (void)setDayListForMonthDays:(NSInteger)day;
/*
 1、年月日时分 (IRDataPickerModeDateHourMinute)
 2、年月日时分秒 (IRDataPickerModeDateHourMinuteSecond)
 3、年月日 (IRDataPickerModeDate)
 */
- (BOOL)setDayListWithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;

/*
 IRDataPickerModeMonthDay, //月日
 IRDataPickerModeMonthDayHour, //月日时
 IRDataPickerModeMonthDayHourMinute, //月日时分
 IRDataPickerModeMonthDayHourMinuteSecond, //月日时分秒
 */
- (BOOL)setDayList2WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeDateAndTime, //月日周 时分
 */
- (BOOL)setHourListWithDateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 1、IRDataPickerModeDateHourMinuteSecond, //年月日时分秒
 2、IRDataPickerModeDateHourMinute, //年月日时分
 */
- (BOOL)setHourList2WithDateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;

/*
 IRDataPickerModeMonthDayHour, //月日时
 IRDataPickerModeMonthDayHourMinute, //月日时分
 IRDataPickerModeMonthDayHourMinuteSecond, //月日时分秒
 */
- (BOOL)setHourList3WithDateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeTime, //时分
 */
- (BOOL)setMinuteListWithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 1、IRDataPickerModeDateHourMinuteSecond, //年月日时分秒
 2、IRDataPickerModeDateHourMinute, //年月日时分
 */
- (BOOL)setMinuteList2WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeTimeAndSecond, //时分秒
 */
- (BOOL)setMinuteList3WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeTimeAndSecond, //时分秒
 */
- (BOOL)setMinuteList4WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeMonthDayHourMinute, //月日时分
 IRDataPickerModeMonthDayHourMinuteSecond, //月日时分秒
 */
- (BOOL)setMinuteList5WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeTimeAndSecond, //时分秒
 */
- (BOOL)setSecondListWithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeDateHourMinuteSecond, //年月日时分秒
 */
- (BOOL)setSecondList2WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeMinuteAndSecond, //分秒
 */
- (BOOL)setSecondList3WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeMonthDayHourMinuteSecond, //月日时分秒
 */
- (BOOL)setSecondList4WithComponent:(NSInteger)component dateComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
/*
 IRDataPickerModeYearAndMonth, //年月
 IRDataPickerModeDate, //年月日
 IRDataPickerModeDateHourMinute, //年月日时分
 IRDataPickerModeDateHourMinuteSecond, //年月日时分秒
 */
- (BOOL)setMonthListWithComponents:(NSDateComponents *)dateComponents refresh:(BOOL)refresh;
@end


NS_ASSUME_NONNULL_END
