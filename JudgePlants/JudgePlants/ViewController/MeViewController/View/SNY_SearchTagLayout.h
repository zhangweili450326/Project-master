//
//  SNY_SearchTagLayout.h
//  Fenxiao
//
//  Created by sny on 15/6/8.
//  Copyright (c) 2015年 sny. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SNY_SearchTagLayoutDelegate;
@interface SNY_SearchTagLayout : UICollectionViewLayout

@property(nonatomic,unsafe_unretained)id<SNY_SearchTagLayoutDelegate,UICollectionViewDataSource>delegate;

-(CGFloat)getSectionHeight:(NSInteger)section forMaxWidth:(CGFloat)width;

@end

@protocol SNY_SearchTagLayoutDelegate <UICollectionViewDelegate>

@optional
/**
 返回每个item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 section的边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
/**
 item的行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section;
/**
 item的横向间隔
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout itemSpacingForSectionAtIndex:(NSInteger)section;
/**
 section head size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
/**
 section foot size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end