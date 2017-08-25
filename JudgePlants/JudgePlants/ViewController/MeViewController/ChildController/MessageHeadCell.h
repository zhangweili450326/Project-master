//
//  MessageHeadCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image_mes;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;

@end
