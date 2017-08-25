//
//  PhotoDetailView.h
//  JudgePlants
//
//  Created by itm on 2017/7/17.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoLibModel ;
@interface PhotoDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lbl_titleName;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
@property (weak, nonatomic) IBOutlet UIButton *btn_downLoad;
- (IBAction)btn_downLoad:(UIButton *)sender;
- (IBAction)btnZan:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_address;

@property (nonatomic,strong) PhotoLibModel *model;

@property (nonatomic,copy) void(^blockClickZan)(UIButton *sender);

@property (nonatomic,copy) void(^blockClickDownLoad)(UIButton *sender);

@end
