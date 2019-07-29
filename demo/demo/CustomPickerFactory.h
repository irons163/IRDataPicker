//
//  CustomPickerFactory.h
//  demo
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IRDataPicker/IRDataPicker.h>

//@import IRDataPicker;

NS_ASSUME_NONNULL_BEGIN

@interface CustomPickerFactory : NSObject

+ (IRDataPickerManager *)createIRDataPickManager;
@end

NS_ASSUME_NONNULL_END
