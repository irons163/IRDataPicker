//
//  ViewController.m
//  demo
//
//  Created by Phil on 2019/7/19.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "ViewController.h"
#import "CustomPickerFactory.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *infoTextfield;
@property (weak, nonatomic) IBOutlet UIButton *pickerButton;
- (IBAction)pickerButtonClick:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)pickerButtonClick:(id)sender {
    NSArray *customStrings = @[@"A", @"B", @"C", @"D", @"E"];
    IRDataPickerManager *datePickManager = [CustomPickerFactory createIRDataPickManager];
    datePickManager.datePicker.datePickerMode = IRDataPickerModeCustom;
    datePickManager.datePicker.customList = customStrings;
    NSUInteger index = [customStrings indexOfObject:self.infoTextfield.text];
    if(index == NSNotFound)
        index = 0;
    [datePickManager.datePicker setRow:index animated:NO];
    datePickManager.datePicker.selectedCustom = ^(NSString *customString) {
        self.infoTextfield.text = customString;
    };
    [self presentViewController:datePickManager animated:false completion:nil];
}
@end
