//
//  KeyBoardTool.h
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KeyBoardTool : NSObject

+(void)hideKeyboard:(UITextField *)textfield;

+ (void)hideKeyboardView:(UITextView *)textfield;

+ (void)hideKeyboardSearchBar:(UISearchBar *)search;

@end
