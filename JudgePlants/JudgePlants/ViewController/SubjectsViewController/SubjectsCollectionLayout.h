//
//  SubjectsCollectionLayout.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectsCollectionLayout : UICollectionViewFlowLayout

// 行数
@property (nonatomic, assign) NSInteger columnNum;
// 水平间距
@property (nonatomic, assign) CGFloat verticalSpacing;


@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) CGFloat rowMargin;

@end
