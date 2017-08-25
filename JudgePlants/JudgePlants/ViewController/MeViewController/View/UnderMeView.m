//
//  UnderMeView.m
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "UnderMeView.h"
#import "SNY_SearchTagLayout.h"
#import "SearchCollectionViewCell.h"
#import "MeContentModel.h"
#import "SizeTool.h"
#import "ZanCollectionViewCell.h"
@interface UnderMeView ()<SNY_SearchTagLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collView;
    SNY_SearchTagLayout * layout;
    NSMutableArray *arr_data;
    CGFloat colleHeigh;
}
@end

@implementation UnderMeView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

    }
    return self;
}
-(instancetype)init{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)createUI{
    layout=[[SNY_SearchTagLayout alloc]init];
    layout.delegate=self;
    collView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    colleHeigh=self.bounds.size.height;
    collView.collectionViewLayout=layout;
    collView.delegate=self;
    collView.dataSource=self;
    collView.backgroundColor=[UIColor whiteColor];
    collView.allowsMultipleSelection = YES;
    
    [self addSubview:collView];
}

-(void)setModel:(MeContentModel *)model{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _model=model;
    arr_data=[[NSMutableArray alloc]init];
    NSArray *arr=[_model.str_arr componentsSeparatedByString:@","];
   [arr_data addObjectsFromArray:arr];
   [self createUI];

    [collView performBatchUpdates:^{
       colleHeigh= collView.collectionViewLayout.collectionViewContentSize.height;
    } completion:^(BOOL finished) {
        
    }];
    
    collView.frame=CGRectMake(0, 0, self.bounds.size.width,colleHeigh);
    if (_delegate) {
        [_delegate changeCollectionViewHeigh:colleHeigh];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([StringTool checkStringIsContainNumber:arr_data[indexPath.row]] ) {
        
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int remainSecond =[[arr_data[indexPath.row] stringByTrimmingCharactersInSet:nonDigits] intValue];
        
        NSString *stringWithoutQuotation = [arr_data[indexPath.row] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",@(remainSecond)] withString:@""];
        
        UINib *nib=[UINib nibWithNibName:@"ZanCollectionViewCell" bundle:nil];
        [collView registerNib:nib forCellWithReuseIdentifier:@"zanCell"];
        
        ZanCollectionViewCell *cell=[collView dequeueReusableCellWithReuseIdentifier:@"zanCell" forIndexPath:indexPath];
        cell.backgroundColor=UIColorFromRGB(0xf5f5f5);
        cell.layer.cornerRadius=3.0;
        cell.lbl_title.text=stringWithoutQuotation;
        [cell.btn_zan setTitle:[NSString stringWithFormat:@" %@",@(remainSecond)] forState:UIControlStateNormal];
        return cell;
        
    }else
    {
        UINib *nib=[UINib nibWithNibName:@"SearchCollectionViewCell" bundle:nil];
        [collView registerNib:nib forCellWithReuseIdentifier:@"lblCell"];
        SearchCollectionViewCell *cell=[collView dequeueReusableCellWithReuseIdentifier:@"lblCell" forIndexPath:indexPath];
        cell.backgroundColor=UIColorFromRGB(0xf5f5f5);
        cell.layer.cornerRadius=3.0;
        cell.lbl_name.text=arr_data[indexPath.row];
        
        return cell;
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_data.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str;
    str=arr_data[indexPath.row];
    
    if ([StringTool checkStringIsContainNumber:arr_data[indexPath.row]] ) {
        return CGSizeMake([SizeTool sizeTofitWithTitle:str fontAmount:12 width:self.bounds.size.width].width+30, 20);
    }
    return CGSizeMake([SizeTool sizeTofitWithTitle:str fontAmount:12 width:self.bounds.size.width].width+20, 20);
    
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout *)collectionViewLayout itemSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(SNY_SearchTagLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
