//
//  LbaleTitleCell.h
//  JudgePlants
//
//  Created by itm on 2017/7/14.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  PuBuModel ;

@protocol protocolChangeCellHeighDelegate <NSObject>

-(void)changeSectionCellHeigh:(CGFloat)heigh;

@end

@interface LbaleTitleCell : UITableViewCell

@property (nonatomic,strong) PuBuModel *model;

@property (nonatomic,weak) id<protocolChangeCellHeighDelegate>delegate;

@end
