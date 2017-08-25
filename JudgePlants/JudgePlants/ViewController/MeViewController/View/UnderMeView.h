//
//  UnderMeView.h
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeContentModel;

@protocol protocolChangeCollectionViewHeighDelegate <NSObject>

-(void)changeCollectionViewHeigh:(CGFloat)heigh;

@end

@interface UnderMeView : UIView

@property (nonatomic,strong) MeContentModel *model;

@property (nonatomic,weak) id<protocolChangeCollectionViewHeighDelegate>delegate;

@end
