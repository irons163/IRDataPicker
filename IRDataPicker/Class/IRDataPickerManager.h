//
//  IRDataPickerManager.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IRDataPicker.h"
#import "IREnumeration.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPickerManager : UIViewController

@property (nonatomic, weak) IRDataPicker *dataPicker;
@property (nonatomic, assign) IRDataPickerManagerStyle style;
@property (nonatomic, assign) BOOL isShadeBackgroud;

@property (nonatomic, copy) NSString *cancelButtonText;
@property (nonatomic, copy) UIFont *cancelButtonFont;
@property (nonatomic, copy) UIColor *cancelButtonTextColor;

/**
 set confirmButton title ,default is Sure
 */
@property (nonatomic, copy) NSString *confirmButtonText;

@property (nonatomic, copy) UIFont *confirmButtonFont;
/**
 set confirButton titleColor ,default is
 */
@property (nonatomic, copy) UIColor *confirmButtonTextColor;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *headerViewBackgroundColor;
@property (nonatomic, assign) CGFloat headerHeight;

/**
 
 */
@property (nonatomic, assign) BOOL isShowUnit;
@property (nonatomic, copy)  void(^cancelButtonMonitor)();


@end


NS_ASSUME_NONNULL_END
