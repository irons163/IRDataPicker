//
//  IRDataPickerView.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRDataPickerView.h"
#import "UIColor+IRHex.h"

@interface IRDataPickerView()
@property (nonatomic, weak) UILabel *label;
@end

@implementation IRDataPickerView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = [self.content sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    self.label.frame = (CGRect){{self.contentView.bounds.size.width / 2 - size.width / 2,
        self.contentView.bounds.size.height / 2 - size.height / 2}, size};
}

#pragma Setter
- (void)setCurrentDate:(BOOL)currentDate {
    _currentDate = currentDate;
    if (currentDate) {
        self.label.textColor = [UIColor ir_colorWithHexString:@"#FAD9A2"];
    }else {
        self.label.textColor = [UIColor ir_colorWithHexString:@"#838383"];
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.label.text = content;
}

#pragma Getter
- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:label];
        _label = label;
    }
    return _label;
}

@end

