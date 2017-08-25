//
//  SubjectionsCollectionCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectionsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_check;
- (IBAction)btnCheck:(UIButton *)sender;

@end
