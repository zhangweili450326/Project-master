//
//  LimitLayout.m
//  JudgePlants
//
//  Created by itm on 2017/5/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "LimitLayout.h"

@implementation LimitLayout

-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake((Screen_Width - (self.columnNum - 1) * self.columnMargin) / self.columnNum, (Screen_Width - 2 * self.rowMargin) / self.columnNum );
    
    self.minimumLineSpacing = self.columnMargin;
    self.minimumInteritemSpacing = self.rowMargin;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.columnMargin = 0.5;
        self.rowMargin = 0.5;
        self.columnNum = 4;
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
