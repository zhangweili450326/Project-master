//
//  MeTableCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeContentModel;
@interface MeTableCell : UITableViewCell

@property (nonatomic,assign) CGFloat cellHeigh;

@property (nonatomic,strong) MeContentModel *model;

@end
