//
//  MeHeadView.h
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol protocolMeDelegate <NSObject>

-(void)sendJoinController;

-(void)sendCollectionController;

@end
@interface MeHeadView : UIView

@property (nonatomic,weak) id<protocolMeDelegate>delegate;

-(void)setModel:(NSArray *)arr;

@end
