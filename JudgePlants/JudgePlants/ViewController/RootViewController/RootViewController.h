//
//  RootViewController.h
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic,strong) UILabel *lbl_navTitle;

@property (nonatomic,strong) UIButton *btn_navRight;

@property (nonatomic,strong) UIButton *btn_navLeft;

@property (nonatomic,copy) NSString *netWorkStatus;

@property (nonatomic,copy) NSString *httpLoadFailure;

@end
