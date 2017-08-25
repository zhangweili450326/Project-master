//
//  ContentHeadView.m
//  JudgePlants
//
//  Created by itm on 2017/7/14.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "ContentHeadView.h"
#import "PuBuModel.h"
@interface ContentHeadView ()

@property (nonatomic,strong) UIImageView *imgBack;

@property (nonatomic,strong) UIImageView *imgHead;

@property (nonatomic,strong) UILabel *lbl_name;

@property (nonatomic,strong) UILabel *lbl_time;

@end

@implementation ContentHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self creaUI];
    }
    return self;
}

-(void)creaUI{
    
    self.imgBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, K_SCWIDTH*340)];
    self.imgBack.contentMode=UIViewContentModeScaleAspectFill;
    self.imgBack.clipsToBounds=YES;
    [self addSubview:self.imgBack];
   
    self.imgHead=[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-K_SCWIDTH*25, K_SCWIDTH*340-K_SCWIDTH*25, K_SCWIDTH*50, K_SCWIDTH*50)];
    self.imgHead.layer.cornerRadius=K_SCWIDTH*25;
    self.imgHead.layer.borderWidth=2.0;
    self.imgHead.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgHead.layer.masksToBounds=YES;
    [self addSubview:self.imgHead];
    
    self.lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(0, K_SCWIDTH*375, Screen_Width/2-10, K_SCWIDTH*15)];
    self.lbl_name.font=[UIFont systemFontOfSize:15];
    self.lbl_name.textAlignment=NSTextAlignmentRight;
    self.lbl_name.textColor=UIColorFromRGB(colorTextBlackColor);
    [self addSubview:self.lbl_name];
    
    UIView *view_up=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/2-1, K_SCWIDTH*375, 1, K_SCWIDTH*15)];
    view_up.backgroundColor=UIColorFromRGB(colorBackLineColor);
    [self  addSubview:view_up];
    
    _lbl_time=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2+10, K_SCWIDTH*375, Screen_Width/2-10, K_SCWIDTH*15)];
    _lbl_time.textColor=UIColorFromRGB(colorTextLightColor);
    _lbl_time.font=[UIFont systemFontOfSize:13];
    [self addSubview:_lbl_time];
    
    UILabel *lbl_question=[[UILabel alloc]initWithFrame:CGRectMake(0, K_SCWIDTH*405, Screen_Width, K_SCWIDTH*15)];
    lbl_question.text=@"各位老铁请问这是什么植物?";
    lbl_question.textAlignment=NSTextAlignmentCenter;
    lbl_question.textColor=UIColorFromRGB(0x666666);
    lbl_question.font=[UIFont systemFontOfSize:14];
    [self addSubview:lbl_question];
    
    UIView *view_botton=[[UIView alloc]initWithFrame:CGRectMake(10,K_SCWIDTH*435-1, Screen_Width-20, 1)];
    view_botton.backgroundColor=UIColorFromRGB(colorBackLineColor);
    [self addSubview:view_botton];
}


-(void)setModel:(PuBuModel *)model{
    _model=model;
    self.imgBack.image=[UIImage imageNamed:_model.imgPic];
    self.imgHead.image=[UIImage imageNamed:_model.imgIcon];
    self.lbl_name.text=_model.name;
    self.lbl_time.text=@"1小时前";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
