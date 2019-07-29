//
//  IRDataPickerView.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRDataPickerView : UITableViewCell
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign, getter = isCurrentDate) BOOL currentDate;
@end

NS_ASSUME_NONNULL_END
