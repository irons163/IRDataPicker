//
//  IRPickerView.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IRPickerViewLineType) {
    IRPickerViewLineTypeline,
    IRPickerViewLineTypelineSegment,
    IRPickerViewLineTypelineVertical,
};

@protocol IRPickerViewDataSource, IRPickerViewDelegate;
@interface IRPickerView : UIView
@property(nonatomic, assign) IRPickerViewLineType type;
@property(nonatomic,weak) id<IRPickerViewDataSource> dataSource;    // default is nil. weak reference
@property(nonatomic,weak) id<IRPickerViewDelegate>   delegate;      // default is nil. weak reference

@property(nonatomic, strong) UIColor *lineBackgroundColor;          // default is [UIColor grayColor]
@property (nonatomic, assign) CGFloat lineHeight;                   // default is 0.5

@property(nonatomic, strong) UIColor *verticalLineBackgroundColor; // default is [UIColor grayColor] type3 vertical line
@property (nonatomic, assign) CGFloat verticalLineWidth; // default is 0.5

@property (nonatomic, strong)UIColor *textColorOfSelectedRow;     // [UIColor blackColor]
@property(nonatomic, strong) UIFont *textFontOfSelectedRow;

@property (nonatomic, strong)UIColor *textColorOfOtherRow;        // default is [UIColor grayColor]
@property(nonatomic, strong) UIFont *textFontOfOtherRow;

// info that was fetched and cached from the data source and delegate
@property(nonatomic,readonly) NSInteger numberOfComponents;

@property (nonatomic) CGFloat rowHeight;             // default is 44

@property(nonatomic, assign) BOOL isHiddenMiddleText; // default is true  true -> hidden
@property(nonatomic, strong) UIColor *middleTextColor;
@property(nonatomic, strong) UIFont *middleTextFont;

@property(nonatomic, assign) BOOL isHiddenWheels; // default is true  true -> hidden


- (NSInteger)numberOfRowsInComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;// scrolls the specified row to center.

- (NSInteger)selectedRowInComponent:(NSInteger)component;// returns selected row. -1 if nothing selected
- (NSString *)textOfSelectedRowInComponent:(NSInteger)component;
// Reloading whole view or single component
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)reloadComponent:(NSInteger)component refresh:(BOOL)refresh;
@end

@protocol IRPickerViewDataSource<NSObject>
@required
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(IRPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(IRPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@protocol IRPickerViewDelegate<NSObject>
@optional
// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(IRPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSAttributedString *)pickerView:(IRPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component; // attributed title is favored if both methods are implemented
- (UIColor *)pickerView:(IRPickerView *)pickerView viewBackgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickerView:(IRPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)pickerView:(IRPickerView *)pickerView title:(NSString *)title didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (CGFloat)rowHeightInPickerView:(IRPickerView *)pickerView forComponent:(NSInteger)component;

- (NSString *)pickerView:(IRPickerView *)pickerView middleTextForcomponent:(NSInteger)component;
- (CGFloat)pickerView:(IRPickerView *)pickerView middleTextSpaceForcomponent:(NSInteger)component;

// type is IRPickerViewLineTypelineVertical vertical line
- (UIColor *)pickerView:(IRPickerView *)pickerView verticalLineBackgroundColorForComponent:(NSInteger)component;
- (CGFloat)pickerView:(IRPickerView *)pickerView verticalLineWidthForComponent:(NSInteger)component;

- (UIColor *)pickerView:(IRPickerView *)pickerView upLineBackgroundColorForComponent:(NSInteger)component;
- (UIColor *)pickerView:(IRPickerView *)pickerView downLineBackgroundColorForComponent:(NSInteger)component;

- (CGFloat)pickerView:(IRPickerView *)pickerView upLineHeightForComponent:(NSInteger)component;
- (CGFloat)pickerView:(IRPickerView *)pickerView downLineHeightForComponent:(NSInteger)component;

- (UIFont *)pickerView:(IRPickerView *)pickerView textFontOfSelectedRowInComponent:(NSInteger)component;
- (UIFont *)pickerView:(IRPickerView *)pickerView textFontOfOtherRowInComponent:(NSInteger)component;

- (UIColor *)pickerView:(IRPickerView *)pickerView textColorOfSelectedRowInComponent:(NSInteger)component;
- (UIColor *)pickerView:(IRPickerView *)pickerView textColorOfOtherRowInComponent:(NSInteger)component;

- (UIFont *)pickerView:(IRPickerView *)pickerView textFontOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
- (UIColor *)pickerView:(IRPickerView *)pickerView textColorOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
