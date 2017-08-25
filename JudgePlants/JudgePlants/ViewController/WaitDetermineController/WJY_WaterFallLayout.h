//
//  WJY_WaterFallLayout.h
//  HoldStars
//
//  Created by 张君宝 on 15/11/20.
//  Copyright © 2015年 海睿星巢文化. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol WaterLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface WJY_WaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign) id<WaterLayoutDelegate> delegate;
// 行数
@property (nonatomic, assign) NSInteger lineCount;
// 水平间距
@property (nonatomic, assign) CGFloat verticalSpacing;
// 垂直间距
@property (nonatomic, assign) CGFloat horizontalSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end
