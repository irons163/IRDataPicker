//
//  IRPickerColumnCell.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRPickerColumnCell : UITableViewCell
@property (nonatomic, weak) UILabel *label;

- (void)transformWith:(CGFloat)angle scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
