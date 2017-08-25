//
//  SNY_SearchTagLayout.m
//  Fenxiao
//
//  Created by sny on 15/6/8.
//  Copyright (c) 2015年 sny. All rights reserved.
//

#import "SNY_SearchTagLayout.h"

@interface SNY_SearchTagLayout ()
{
    float _contentHeight;
}
@end

@implementation SNY_SearchTagLayout

-(void)prepareLayout
{
    [super prepareLayout];
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, _contentHeight);
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{    
    float height=0;
    
    NSMutableArray* attributes =[[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger sections=[self.collectionView numberOfSections];
    for (int section=0; section<sections; section++)
    {
        //获取头部的布局属性
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndex:section];
        
        UICollectionViewLayoutAttributes * headAtt=[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (headAtt)
        {
            CGRect frame = headAtt.frame;
            frame.origin.y = height;
            headAtt.frame = frame;
            [attributes addObject:headAtt];
            height+=headAtt.frame.size.height;
        }
        //获取每个item的布局属性
        NSMutableArray * itemAttributes=[[NSMutableArray alloc] init];
        NSInteger rows=[self.collectionView numberOfItemsInSection:section];
        //边距
        UIEdgeInsets edge=UIEdgeInsetsZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
        {
           edge=[self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }
        //行间距
        float lineSpace=0;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)])
        {
            lineSpace=[self.delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:section];
        }
        
        for (int row=0; row<rows; row++)
        {
            //我们想设置的最大间距，可根据需要改
            NSInteger maximumSpacing = 10;
            NSIndexPath * itemIndexPath = [NSIndexPath indexPathForItem:row inSection:section];
            if (row==0)
            {
                height += edge.top;
                UICollectionViewLayoutAttributes * itemAtt=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
                CGRect frame = itemAtt.frame;
                frame.origin.y = height;
                frame.origin.x =edge.left;
                itemAtt.frame = frame;
                [itemAttributes addObject:itemAtt];
            }
            else
            {
                // 当前attributes
                UICollectionViewLayoutAttributes * currentAttributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
                //上一个attributes 需要从数组里面取  里面是已经修改过的
                UICollectionViewLayoutAttributes * preAttributes = [itemAttributes lastObject];
                //前一个cell的最右边
                NSInteger origin = CGRectGetMaxX(preAttributes.frame);
                //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
                //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
                if(origin + maximumSpacing + currentAttributes.frame.size.width + edge.right < self.collectionViewContentSize.width)
                {
                    CGRect frame = currentAttributes.frame;
                    frame.origin.x = origin + maximumSpacing;
                    frame.origin.y = preAttributes.frame.origin.y;
                    currentAttributes.frame = frame;
                    [itemAttributes addObject:currentAttributes];
                }
                else
                {
                    
                    CGRect frame = currentAttributes.frame;
                    height+=(frame.size.height+lineSpace);
                    frame.origin.x = edge.left;
                    frame.origin.y = height;
                    currentAttributes.frame = frame;
                    [itemAttributes addObject:currentAttributes];
                }
                
            }
        }
        [attributes addObjectsFromArray:itemAttributes];
        //获取尾部的布局属性
        
        UICollectionViewLayoutAttributes * preAttributes = [itemAttributes lastObject];
        height+=(preAttributes.frame.size.height+edge.bottom);
        
        UICollectionViewLayoutAttributes * footerAtt=[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        if (footerAtt)
        {
            CGRect frame = footerAtt.frame;
            frame.origin.x = 0;
            frame.origin.y = height;
            footerAtt.frame = frame;
            [attributes addObject:footerAtt];
            height+=footerAtt.size.height;
        }
    }
    _contentHeight=height;
    return attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * currentLayoutAttributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size=[self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    currentLayoutAttributes.frame=CGRectMake(0, 0, size.width, size.height);
    return currentLayoutAttributes;
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (elementKind==UICollectionElementKindSectionHeader)
    {
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)])
        {
            UICollectionViewLayoutAttributes * currentLayoutAttributes=[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
            CGSize size=[self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
            currentLayoutAttributes.frame=CGRectMake(0, 0, size.width, size.height);
            return currentLayoutAttributes;
        }
    }
    else if(elementKind==UICollectionElementKindSectionFooter)
    {
        
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)])
        {
            UICollectionViewLayoutAttributes * currentLayoutAttributes=[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
            CGSize size=[self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
            currentLayoutAttributes.frame=CGRectMake(0, 0, size.width, size.height);
            return currentLayoutAttributes;
        }
    }
    return nil;
}
//当边界更改时是否更新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds))
    {
        return YES;
    }
    return NO;
}
-(CGFloat)getSectionHeight:(NSInteger)section forMaxWidth:(CGFloat)width
{
    CGFloat height=0;
    //边距
    UIEdgeInsets edge=UIEdgeInsetsZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
    {
        edge=[self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    //行间距
    float lineSpace=0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)])
    {
        lineSpace=[self.delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:section];
    }
    //每一个item的间距
    float itemSpace=0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:itemSpacingForSectionAtIndex:)])
    {
        itemSpace=[self.delegate collectionView:self.collectionView layout:self itemSpacingForSectionAtIndex:section];
    }
    NSMutableArray * itemAttributes=[[NSMutableArray alloc] init];
    NSInteger rows=0;
    if ([self.delegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)])
    {
        rows=[self.delegate collectionView:self.collectionView numberOfItemsInSection:section];
    }
    for (int row=0; row<rows; row++)
    {
        NSIndexPath * itemIndexPath = [NSIndexPath indexPathForItem:row inSection:section];
        if (row==0)
        {
            height += edge.top;
            UICollectionViewLayoutAttributes * itemAtt=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
            CGRect frame = itemAtt.frame;
            frame.origin.y = height;
            frame.origin.x =edge.left;
            itemAtt.frame = frame;
            [itemAttributes addObject:itemAtt];
        }
        else
        {
            // 当前attributes
            UICollectionViewLayoutAttributes * currentAttributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
            //上一个attributes 需要从数组里面取  里面是已经修改过的
            UICollectionViewLayoutAttributes * preAttributes = [itemAttributes lastObject];
            //前一个cell的最右边
            NSInteger origin = CGRectGetMaxX(preAttributes.frame);
            //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
            //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
            if(origin + itemSpace + currentAttributes.frame.size.width + edge.right < width)
            {
                CGRect frame = currentAttributes.frame;
                frame.origin.x = origin + itemSpace;
                frame.origin.y = preAttributes.frame.origin.y;
                currentAttributes.frame = frame;
                [itemAttributes addObject:currentAttributes];
            }
            else
            {
                CGRect frame = currentAttributes.frame;
                height+=(frame.size.height+lineSpace);
                frame.origin.x = edge.left;
                frame.origin.y = height;
                currentAttributes.frame = frame;
                [itemAttributes addObject:currentAttributes];
            }
            
        }
    }
    UICollectionViewLayoutAttributes * preAttributes = [itemAttributes lastObject];
    height+=(preAttributes.frame.size.height+edge.bottom);
    
    NSLog(@"高度%f",height);
    return height;
}

@end
