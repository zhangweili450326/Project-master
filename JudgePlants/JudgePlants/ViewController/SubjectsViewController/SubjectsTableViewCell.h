//
//  SubjectsTableViewCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_nickName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UIImageView *img_pic;
@end
