//
//  PuBuCell.h
//  HoldStars
//
//  Created by 张君宝 on 15/11/20.
//  Copyright © 2015年 海睿星巢文化. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HeadBlock)(NSString *);

@class PuBuModel;

@interface PuBuCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *img_big;

@property (nonatomic,strong)UIImageView *img_head;

@property (nonatomic, strong)UILabel *lblName;

@property (nonatomic,strong)UIButton *btnPl;

@property(nonatomic,strong)PuBuModel *model;

@property (nonatomic,copy) HeadBlock headBlock;
@end
