//
//  LbaleTitleCell.m
//  JudgePlants
//
//  Created by itm on 2017/7/14.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "LbaleTitleCell.h"
#import "SNY_SearchTagLayout.h"
#import "SearchCollectionViewCell.h"
#import "MeContentModel.h"
#import "SizeTool.h"
#import "ZanCollectionViewCell.h"
#import "PuBuModel.h"
#import "TextCollectionCell.h"
#define textPlaName @"输入名称"
@interface LbaleTitleCell ()<SNY_SearchTagLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collView;
    SNY_SearchTagLayout * layout;
    CGFloat colleHeigh;
    NSMutableArray *arr_data;
}
@end

@implementation LbaleTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    layout=[[SNY_SearchTagLayout alloc]init];
    layout.delegate=self;
    collView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.height) collectionViewLayout:layout];
    colleHeigh=self.bounds.size.height;
    collView.collectionViewLayout=layout;
    collView.delegate=self;
    collView.dataSource=self;
    collView.backgroundColor=[UIColor whiteColor];
    collView.allowsMultipleSelection = YES;
    collView.scrollEnabled=NO;
    collView.scrollsToTop=NO;
    [self addSubview:collView];
}

-(void)setModel:(PuBuModel *)model{
    _model=model;
    arr_data=[[NSMutableArray alloc]init];
    if ([_model.label containsString:@","]) {
        NSArray *arr=[_model.label componentsSeparatedByString:@","];
        [arr_data addObjectsFromArray:arr];
    }
    [arr_data addObject:textPlaName];
    [collView performBatchUpdates:^{
        colleHeigh= collView.collectionViewLayout.collectionViewContentSize.height;
    } completion:^(BOOL finished) {
        
    }];
  
    collView.frame=CGRectMake(0, 0, Screen_Width,colleHeigh);
    if (_delegate) {
        [_delegate changeSectionCellHeigh:colleHeigh];
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
        
    }
    else if ([arr_data[indexPath.row] isEqualToString:textPlaName]){
        
        UINib *nib=[UINib nibWithNibName:@"TextCollectionCell" bundle:nil];
        [collView registerNib:nib forCellWithReuseIdentifier:@"textCell"];
        TextCollectionCell *cell=[collView dequeueReusableCellWithReuseIdentifier:@"textCell" forIndexPath:indexPath];
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
        return CGSizeMake([SizeTool sizeTofitWithTitle:str fontAmount:12 width:self.bounds.size.width].width+35, 30);
    }
    return CGSizeMake([SizeTool sizeTofitWithTitle:str fontAmount:12 width:self.bounds.size.width].width+25, 30);
    
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
    return UIEdgeInsetsMake(10,10,10,10);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
