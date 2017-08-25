//
//  CommentTableViewCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/14.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlTextModel;

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;

@property (nonatomic,strong) PlTextModel *model;

@end
