//
//  PhotoLibCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/17.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoLibModel;

@interface PhotoLibCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_back;
@property (weak, nonatomic) IBOutlet UILabel *lbl_titleName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_address;
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lbl_nickName;
@property (weak, nonatomic) IBOutlet UIButton *btn_downLoad;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
- (IBAction)btnDownLoad:(UIButton *)sender;
- (IBAction)btnZan:(UIButton *)sender;

@property (nonatomic,strong) PhotoLibModel *model;

@end
