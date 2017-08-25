//
//  PuBuCell.m
//  HoldStars
//
//  Created by 张君宝 on 15/11/20.
//  Copyright © 2015年 海睿星巢文化. All rights reserved.
//

#import "PuBuCell.h"
#import "PuBuModel.h"
#import "SizeTool.h"
#import "PuGrayLabel.h"
#define CELLWIDTH (Screen_Width - 15) / 2
#define PLHeigh  25
@interface PuBuCell ()

@property (nonatomic,assign) CGFloat cellHeigh;

@property (nonatomic,strong) UIView *view_label;

@property (nonatomic,strong) UIView *view_pl;

@end

@implementation PuBuCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _img_big = [[UIImageView alloc]init];
        [self.contentView addSubview:_img_big];
        
        _img_head=[[UIImageView alloc]init];
        
        [self.contentView addSubview:_img_head];
        
        _view_label=[[UIView alloc]init];
        [self.contentView addSubview:_view_label];
        
        _view_pl=[[UIView alloc]init];
        [self.contentView addSubview:_view_pl];
        

        _lblName=[[UILabel alloc]init];
        _lblName.textColor=UIColorFromRGB(colorTextLightColor);
        _lblName.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_lblName];
        
        _btnPl=[[UIButton alloc]init];
        [_btnPl setImage:[UIImage imageNamed:@"wait_pl"] forState:UIControlStateNormal];
        [_btnPl setTitleColor:UIColorFromRGB(colorTextLightColor) forState:UIControlStateNormal];
        _btnPl.titleLabel.font=[UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_btnPl];
        
        
    }
    return self;
}

-(void)setModel:(PuBuModel *)model
{
    _model = model;
    
    _img_big.image=[UIImage imageNamed:_model.imgPic];
    _img_head.image=[UIImage imageNamed:_model.imgIcon];
    _lblName.text=_model.name;
    [_btnPl setTitle:[NSString stringWithFormat:@" %@",_model.num] forState:UIControlStateNormal];
    
    if ([_model.label length]>0) {
        _view_label.frame=CGRectMake(5, CELLWIDTH, CELLWIDTH-10, 30);
        [self loadLabels:_model.label];
    }else{
        _view_label.size=CGSizeZero;
        for (UIView *view in _view_label.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if ([_model.label_pl length]>0) {
        NSArray *arr_pl=[_model.label_pl componentsSeparatedByString:@","];
        if (arr_pl.count>=3) {
            _view_pl.frame=CGRectMake(0, _cellHeigh-40-PLHeigh*3, CELLWIDTH, PLHeigh*3);
        }else{
            _view_pl.frame=CGRectMake(0, _cellHeigh-40-arr_pl.count*PLHeigh, CELLWIDTH, arr_pl.count*PLHeigh);
        }
        [self loadPl:arr_pl];
    }else{
        _view_pl.size=CGSizeZero;
        for (UIView *view in _view_pl.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if ([_model.num integerValue]>=100) {
         _btnPl.frame=CGRectMake(CELLWIDTH-50,_img_head.y, 50, 30);
    }
}

-(void)loadPl:(NSArray *)arr{
    
    for (UIView *view in _view_pl.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i=0; i<arr.count; i++) {
        NSArray *arr_blue=[arr[i] componentsSeparatedByString:@":"];
        NSString *str1=arr_blue[0];
        NSString *str2=arr_blue[1];
        
        NSMutableAttributedString *strBlue = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",str1,str2]];
        [strBlue addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x5793cb) range:NSMakeRange(0,[str1 length]+1)];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 0+i*PLHeigh, CELLWIDTH-10, PLHeigh)];
        lbl.textColor=UIColorFromRGB(colorTextBlackColor);
        lbl.font=[UIFont systemFontOfSize:13];
        lbl.attributedText=strBlue;
        [_view_pl addSubview:lbl];
    }
}

-(void)loadLabels:(NSString *)title{
    

     for (UIView *view in _view_label.subviews) {
        [view removeFromSuperview];
     }
        NSArray *plantsDetails = [title componentsSeparatedByString:@","];
        CGFloat x = 0;
        for (NSInteger i =0 ;i<plantsDetails.count;i++) {
            NSString *s = plantsDetails[i];
            CGSize sizeTemp = [SizeTool sizeTofitWithTitle:s fontAmount:13 height:20];
            CGSize size = CGSizeMake(sizeTemp.width+16,sizeTemp.height);
            if (i==0) {
                x=x+size.width;
            }else{
                x = x+size.width+5;
            }
            if (x>=(CELLWIDTH-10)) {
                break;
            }else{
                PuGrayLabel *label = [[PuGrayLabel alloc] initWithText:s x:(x-size.width) y:5 size:size];
                [_view_label addSubview:label];
            }
        }
 
}


//layoutAttributes = Itme
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    
    _cellHeigh = layoutAttributes.frame.size.height;
    
    _img_big.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.width);
    
    _img_head.frame=CGRectMake(5, _cellHeigh-33, 26, 26);
    _img_head.layer.cornerRadius=13;
    _img_head.layer.masksToBounds=YES;
    
    _lblName.frame=CGRectMake(40, _img_head.y,CELLWIDTH-70,_img_head.height);
    _btnPl.frame=CGRectMake(CELLWIDTH-40,_img_head.y, 40, 30);
    
}


-(void)tapClick
{
    self.headBlock(nil);
}

@end
