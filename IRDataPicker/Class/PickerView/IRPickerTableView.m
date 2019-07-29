//
//  IRPickerTableView.m
//  IRDataPicker
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRPickerTableView.h"

@implementation IRPickerTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
