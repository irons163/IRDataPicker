//
//  IRDataPickerManager.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPickerManager.h"
#import "IRDataPickerManagerHeaderView.h"
#import "UIColor+IRHex.h"

@interface IRDataPickerManager ()
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) IRDataPickerManagerHeaderView *headerView;
@property (nonatomic, weak) UIView *dismissView;
@end

@implementation IRDataPickerManager

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self setupDismissViewTapHandler];
        [self headerViewButtonHandler];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.headerView.language = self.dataPicker.language;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.headerView.style = self.style;
    self.dismissView.frame = self.view.bounds;
    self.contentView.backgroundColor = self.dataPicker.backgroundColor;
    if (self.style == IRDataPickerManagerStyleSheet) {
        [self setupStyleSheet];
    }else if (self.style == IRDataPickerManagerStyleAlert) {
        [self setupStyleAlert];
    }else {
        [self setupStyle3];
    }
    [self.view bringSubviewToFront:self.contentView];
}

- (void)setupDismissViewTapHandler {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissViewTapMonitor)];
    [self.dismissView addGestureRecognizer:tap];
}

- (void)headerViewButtonHandler {
    __weak id weak_self = self;
    self.headerView.cancelButtonHandlerBlock = ^{
        __strong IRDataPickerManager *strong_self = weak_self;
        [strong_self cancelButtonHandler];
        if (strong_self.cancelButtonMonitor) {
            strong_self.cancelButtonMonitor();
        }
    };
    self.headerView.confirmButtonHandlerBlock =^{
        __strong IRDataPickerManager *strong_self = weak_self;
        [strong_self.dataPicker tapSelectedHandler];
        [strong_self cancelButtonHandler];
    };
}

- (void)cancelButtonHandler {
    if (self.style == IRDataPickerManagerStyleSheet) {
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.origin.y = self.view.bounds.size.height;
        [UIView animateWithDuration:0.2 animations:^{
            self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            self.contentView.frame = contentViewFrame;
        }completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:false completion:nil];
        }];
    }else {
        [self dismissViewControllerAnimated:false completion:nil];
    }
}

- (void)dismissViewTapMonitor {
    [self cancelButtonHandler];
    if (self.cancelButtonMonitor) {
        self.cancelButtonMonitor();
    }
}

- (void)setupStyleSheet {
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = self.view.safeAreaInsets.bottom;
    }
    CGFloat rowHeight = self.dataPicker.rowHeight;
    CGFloat headerViewHeight = self.headerHeight;
    CGFloat contentViewHeight = rowHeight * 5 + headerViewHeight;
    CGFloat datePickerHeight = contentViewHeight - headerViewHeight - bottom;
    CGRect contentViewFrame = CGRectMake(0,
                                         self.view.bounds.size.height - contentViewHeight,
                                         self.view.bounds.size.width,
                                         contentViewHeight);
    CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, headerViewHeight);
    CGRect datePickerFrame = CGRectMake(0,
                                        CGRectGetMaxY(headerViewFrame),
                                        self.view.bounds.size.width,
                                        datePickerHeight);
    
    self.contentView.frame = CGRectMake(0,
                                        self.view.bounds.size.height,
                                        self.view.bounds.size.width,
                                        contentViewHeight);
    self.headerView.frame = headerViewFrame;
    self.dataPicker.frame = datePickerFrame;
    self.headerView.backgroundColor = self.headerViewBackgroundColor;
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isShadeBackgroud) {
            self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        }
        self.contentView.frame = contentViewFrame;
        self.headerView.frame = headerViewFrame;
        self.dataPicker.frame = datePickerFrame;
    }];
}

- (void)setupStyleAlert {
    CGFloat rowHeight = self.dataPicker.rowHeight;
    CGFloat datePickerHeight = rowHeight * 5;
    CGFloat headerViewHeight = self.headerHeight;
    CGFloat contentViewMarginLeft = 30;
    CGFloat contentViewWidth = self.view.bounds.size.width - contentViewMarginLeft * 2;
    CGFloat contentViewHeight = datePickerHeight  + headerViewHeight;
    self.contentView.frame = CGRectMake(contentViewMarginLeft,
                                        self.view.center.y - contentViewHeight / 2,
                                        contentViewWidth,
                                        contentViewHeight);
    self.headerView.frame = CGRectMake(0, 0, contentViewWidth, headerViewHeight);
    
    CGRect datePickerFrame = self.contentView.bounds;
    datePickerFrame.origin.y = CGRectGetMaxY(self.headerView.frame);
    datePickerFrame.size.height = datePickerHeight;
    self.contentView.layer.cornerRadius = 10;
    self.dataPicker.layer.cornerRadius = 10;
    self.dataPicker.frame = datePickerFrame;
    self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.05
                     animations:^{
                         if (self.isShadeBackgroud) {
                             self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                         }
                         self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }];
}

- (void)setupStyle3 {
    CGFloat rowHeight = self.dataPicker.rowHeight;
    CGFloat datePickerHeight = rowHeight * 5;
    CGFloat headerViewHeight = self.headerHeight;
    CGFloat contentViewMarginLeft = 30;
    CGFloat contentViewWidth = self.view.bounds.size.width - contentViewMarginLeft * 2;
    CGFloat contentViewHeight = datePickerHeight  + headerViewHeight;
    self.contentView.frame = CGRectMake(contentViewMarginLeft,
                                        self.view.center.y - contentViewHeight / 2,
                                        contentViewWidth,
                                        contentViewHeight);
    self.headerView.frame = CGRectMake(0,
                                       self.contentView.bounds.size.height - headerViewHeight,
                                       contentViewWidth,
                                       headerViewHeight);
    CGRect datePickerFrame = self.contentView.bounds;
    datePickerFrame.size.height = datePickerHeight;
    self.dataPicker.frame = datePickerFrame;
    self.contentView.layer.cornerRadius = 10;
    self.dataPicker.layer.cornerRadius = 10;
    self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.05
                     animations:^{
                         if (self.isShadeBackgroud) {
                             self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                         }
                         self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }];
}

#pragma Setter

- (void)setIsShadeBackgroud:(BOOL)isShadeBackgroud {
    _isShadeBackgroud = isShadeBackgroud;
    if (isShadeBackgroud) {
        self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }else {
        self.dismissView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setCancelButtonFont:(UIFont *)cancelButtonFont {
    _cancelButtonFont = cancelButtonFont;
    self.headerView.cancelButtonFont = cancelButtonFont;
}

- (void)setCancelButtonText:(NSString *)cancelButtonText {
    _cancelButtonText = cancelButtonText;
    self.headerView.cancelButtonText = cancelButtonText;
}

- (void)setCancelButtonTextColor:(UIColor *)cancelButtonTextColor {
    _cancelButtonTextColor = cancelButtonTextColor;
    self.headerView.cancelButtonTextColor = cancelButtonTextColor;
}

- (void)setConfirmButtonFont:(UIFont *)confirmButtonFont {
    _confirmButtonFont = confirmButtonFont;
    self.headerView.confirmButtonFont = confirmButtonFont;
}

- (void)setConfirmButtonText:(NSString *)confirmButtonText {
    _confirmButtonText = confirmButtonText;
    self.headerView.confirmButtonText = confirmButtonText;
}

- (void)setConfirmButtonTextColor:(UIColor *)confirmButtonTextColor {
    _confirmButtonTextColor = confirmButtonTextColor;
    self.headerView.confirmButtonTextColor = confirmButtonTextColor;
}

#pragma Getter

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        _contentView =view;
    }
    return _contentView;
}

- (IRDataPicker *)dataPicker {
    if (!_dataPicker) {
        IRDataPicker *datePicker = [[IRDataPicker alloc]init];
        datePicker.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:datePicker];
        _dataPicker = datePicker;
    }
    return _dataPicker;
}

- (IRDataPickerManagerHeaderView *)headerView {
    if (!_headerView) {
        IRDataPickerManagerHeaderView *view = [[IRDataPickerManagerHeaderView alloc]init];
        [self.contentView addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

- (UIColor *)headerViewBackgroundColor {
    if (!_headerViewBackgroundColor) {
        _headerViewBackgroundColor = [UIColor ir_colorWithHexString:@"#F1EDF6"];
    }
    return _headerViewBackgroundColor;
}

- (CGFloat)headerHeight {
    if (!_headerHeight) {
        _headerHeight = 50;
    }
    return _headerHeight;
}

- (UIView *)dismissView {
    if (!_dismissView) {
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        _dismissView = view;
    }
    return _dismissView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = self.headerView.titleLabel;
    }
    return _titleLabel;
}

@end

