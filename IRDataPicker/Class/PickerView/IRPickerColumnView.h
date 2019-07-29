//
//  IRPickerColumnView.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IRPickerColumnViewDelegate;

@interface IRPickerColumnView : UIView
@property (nonatomic, weak) id<IRPickerColumnViewDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSUInteger component;
@property (nonatomic, assign) NSUInteger selectedRow;
@property (nonatomic, strong) NSArray<UIColor *> *viewBackgroundColors;
@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, copy) NSString *textOfSelectedRow;
@property (nonatomic, strong)UIColor *textColorOfSelectedRow;
@property(nonatomic, strong) UIFont *textFontOfSelectedRow;

@property (nonatomic, strong)UIColor *textColorOfOtherRow;
@property(nonatomic, strong) UIFont *textFontOfOtherRow;

@property(nonatomic, assign) BOOL isHiddenWheels;

- (instancetype)initWithFrame:(CGRect)frame rowHeight:(CGFloat)rowHeight upLineHeight:(CGFloat)upLineHeight downLineHeight:(CGFloat)downLineHeight;
- (void)selectRow:(NSInteger)row animated:(BOOL)animated;
@end

@protocol IRPickerColumnViewDelegate<NSObject>
@optional
- (void)pickerColumnView:(IRPickerColumnView *)pickerColumnView didSelectRow:(NSInteger)row;
- (void)pickerColumnView:(IRPickerColumnView *)pickerColumnView title:(NSString *)title didSelectRow:(NSInteger)row;

- (UIFont *)pickerColumnView:(IRPickerColumnView *)pickerColumnView textFontOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
- (UIColor *)pickerColumnView:(IRPickerColumnView *)pickerColumnView textColorOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
@end


NS_ASSUME_NONNULL_END
