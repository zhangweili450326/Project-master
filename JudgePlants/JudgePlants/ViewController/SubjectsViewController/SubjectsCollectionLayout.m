//
//  SubjectsCollectionLayout.m
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SubjectsCollectionLayout.h"

@implementation SubjectsCollectionLayout

-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake((Screen_Width- (self.columnNum - 1) * self.columnMargin) / self.columnNum, (Screen_Width - 2 * self.rowMargin) / self.columnNum );
    
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
