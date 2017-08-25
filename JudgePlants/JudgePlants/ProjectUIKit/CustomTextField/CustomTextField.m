//
//  CustomTextField.m
//  JudgePlants
//
//  Created by itm on 2017/7/12.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "CustomTextField.h"

#import <QuartzCore/QuartzCore.h>
#import "KeyBoardTool.h"
#define defaultLength 100

@implementation CustomTextField

-(instancetype)initWithLength:(NSInteger)length{
    self = [super init];
    if (self) {
        _maxLength = length;
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10,self.frame.size.height)];
        self.leftView.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [KeyBoardTool hideKeyboard:self];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _maxLength = defaultLength;
//        self.layer.borderWidth = 0.5;
//        self.layer.cornerRadius = 5;
//        self.layer.borderColor = UIColorFromRGB(color_blue).CGColor;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,self.frame.size.height)];
        self.leftView.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [KeyBoardTool hideKeyboard:self];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = defaultLength;
        //        self.layer.borderWidth = 0.5;
        //        self.layer.cornerRadius = 5;
        //        self.layer.borderColor = UIColorFromRGB(color_blue).CGColor;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,self.frame.size.height)];
        self.leftView.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [KeyBoardTool hideKeyboard:self];
    }
    return self;
}


- (void)textFieldDidChange:(UITextField *)textField{
    if (!_allApprove) {
        if (self.keyboardType == UIKeyboardTypeNumberPad || self.keyboardType == UIKeyboardTypeDecimalPad) {
            if (textField.text.length>=2) {
                if ([@"0" isEqualToString:[textField.text substringToIndex:1]]&&![@"0." isEqualToString:[textField.text substringToIndex:2]]) {
                    NSString *rangText = [textField.text substringWithRange:NSMakeRange(1,1)];
                    if ([rangText checkNumber]) {
                        textField.text = rangText;
                    }else{
                        textField.text = @"0";
                    }
                }
            }
        }
    }
    if (textField.text.length > _maxLength) {
        
        textField.text = [textField.text substringToIndex:_maxLength];
        
    }
}


-(BOOL)becomeFirstResponder{
    [super becomeFirstResponder];
    self.layer.borderColor = [UIColor blueColor].CGColor;
    [self setNeedsDisplay];
    return YES;
}


-(BOOL)resignFirstResponder{
    [super resignFirstResponder];
    self.layer.borderColor = [UIColor blueColor].CGColor;
    [self setNeedsDisplay];
    
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
