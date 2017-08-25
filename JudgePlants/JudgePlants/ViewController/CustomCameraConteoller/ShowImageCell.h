//
//  ShowImageCell.h
//  JudgePlants
//
//  Created by itm on 2017/5/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *img_name;
@property (nonatomic, strong) UILabel *lbl_name;
@property (nonatomic, strong) UILabel *lbl_precision;

-(void)setCellModel:(NSArray *)arrayData andImage:(UIImage *)img;
@end
