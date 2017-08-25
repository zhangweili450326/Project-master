//
//  MeJoinTableCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeJoinTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UIImageView *image_back;

@property (weak, nonatomic) IBOutlet UIButton *btn_message;
@property (weak, nonatomic) IBOutlet UIButton *btn_love;
- (IBAction)btnMessage:(UIButton *)sender;
- (IBAction)btnDidLove:(UIButton *)sender;
@end
