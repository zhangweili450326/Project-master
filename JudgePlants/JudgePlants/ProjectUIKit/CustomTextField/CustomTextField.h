//
//  CustomTextField.h
//  JudgePlants
//
//  Created by itm on 2017/7/12.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property(nonatomic,assign)NSInteger maxLength;

@property(nonatomic,assign)BOOL allApprove;

-(instancetype)initWithLength:(NSInteger)length;

@end
