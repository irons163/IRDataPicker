//
//  IRDataPickerManagerHeaderView.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IREnumeration.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^handlerBlock)();

@interface IRDataPickerManagerHeaderView : UIView

@property (nonatomic, assign) IRDataPickerManagerStyle style;

@property (nonatomic, copy)  handlerBlock cancelButtonHandlerBlock;
@property (nonatomic, copy)  handlerBlock confirmButtonHandlerBlock;

@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, copy) NSString *language;

@property (nonatomic, copy) NSString *cancelButtonText;
@property (nonatomic, copy) UIFont *cancelButtonFont;
@property (nonatomic, copy) UIColor *cancelButtonTextColor;

@property (nonatomic, copy) NSString *confirmButtonText;
@property (nonatomic, copy) UIFont *confirmButtonFont;
@property (nonatomic, copy) UIColor *confirmButtonTextColor;
@end


NS_ASSUME_NONNULL_END
