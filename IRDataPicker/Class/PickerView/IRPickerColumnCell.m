//
//  IRPickerColumnCell.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRPickerColumnCell.h"

@implementation IRPickerColumnCell

#define kContentFont 17

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)transformWith:(CGFloat)angle scale:(CGFloat)scale {
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    transform = CATransform3DScale(transform, scale, scale, scale);
    self.layer.transform = transform;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

#pragma Getter
- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        label.font = [UIFont systemFontOfSize:kContentFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}
@end

