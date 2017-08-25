//
//  KeyBoardTool.m
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import "KeyBoardTool.h"
 #import <objc/runtime.h>
@implementation KeyBoardTool

#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboard:(UITextField *)textfield {
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    objc_setAssociatedObject(btn, "textfield", textfield, OBJC_ASSOCIATION_ASSIGN);//OBJC_ASSOCIATION_ASSIGN 防止强引用 循环引用导致无法释放
    [btn addTarget:self action:@selector(dismissKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [textfield setInputAccessoryView:topView];
}

+ (void)dismissKeyBoard:(UIButton *)button{
    [objc_getAssociatedObject(button, "textfield") resignFirstResponder];
}

#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboardView:(UITextView *)textfield {
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    objc_setAssociatedObject(btn, "textfieldView", textfield, OBJC_ASSOCIATION_ASSIGN);//OBJC_ASSOCIATION_RETAIN_NONATOMIC不能用这个 用这个会导致循环引用 引用计数+1
    [btn addTarget:self action:@selector(dismissKeyBoardView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [textfield setInputAccessoryView:topView];
}

+ (void)dismissKeyBoardView:(UIButton *)button{
    [objc_getAssociatedObject(button, "textfieldView") resignFirstResponder];
}

#pragma mark - 增加隐藏键盘按钮
+ (void)hideKeyboardSearchBar:(UISearchBar *)search {
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    objc_setAssociatedObject(btn, "UISearchBarkey", search, OBJC_ASSOCIATION_ASSIGN);//OBJC_ASSOCIATION_RETAIN_NONATOMIC不能用这个 用这个会导致循环引用 引用计数+1
    [btn addTarget:self action:@selector(dismissKeyBoardSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [search setInputAccessoryView:topView];
}

+ (void)dismissKeyBoardSearchBar:(UIButton *)button{
    [objc_getAssociatedObject(button, "UISearchBarkey") resignFirstResponder];
}


@end
