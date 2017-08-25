//
//  MeHeadView.m
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeHeadView.h"

@interface MeHeadView ()
@property (nonatomic,strong) UIImageView *img_back;
@property (nonatomic,strong) UIImageView *img_head;
@property (nonatomic,strong) UIButton *btn_login;
@property (nonatomic,strong) UILabel *lbl_name;
@property (nonatomic,strong) UILabel *lbl_distinguish;//鉴别
@property (nonatomic,strong) UILabel *lbl_join;//参与
@property (nonatomic,strong) UILabel *lbl_collection;//收藏

@end

@implementation MeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self createHeadView];
    }
    return self;
}

-(void)createHeadView{
    _img_back=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, K_SCWIDTH*270)];
    _img_back.userInteractionEnabled=YES;
    _img_back.image=[UIImage imageNamed:@"me_imageBack"];
    [self addSubview:_img_back];
    
    _img_head=[[UIImageView alloc]initWithFrame:CGRectMake(20, K_SCWIDTH*240, K_SCWIDTH*60, K_SCWIDTH*60)];
    _img_head.layer.cornerRadius=K_SCWIDTH*60/2;
    _img_head.layer.borderWidth=2;
    _img_head.layer.borderColor=[UIColor whiteColor].CGColor;
    _img_head.layer.masksToBounds=YES;
    [self addSubview:_img_head];
    _img_head.image=[UIImage imageNamed:@"me_default_head"];
    
    _btn_login=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-100, _img_back.height-55, 100, 40)];
    [_btn_login setBackgroundColor:UIColorFromRGB(colorGreen)];
    _btn_login.titleLabel.font=[UIFont systemFontOfSize:15];
    [_btn_login setTitle:@" 去登录" forState:UIControlStateNormal];
    [_btn_login setImage:[UIImage imageNamed:@"me_login_head"] forState:UIControlStateNormal];
    [_btn_login addTarget:self action:@selector(btnLogin) forControlEvents:UIControlEventTouchUpInside];
    [_img_back addSubview:_btn_login];
    
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:_btn_login.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc]init];
    maskLayer.frame=_btn_login.bounds;
    maskLayer.path=maskPath.CGPath;
    _btn_login.layer.mask=maskLayer;
    
    _lbl_name=[[UILabel alloc]init];
    [self addSubview:_lbl_name];
    _lbl_name.text=@"植物大战僵尸";
    [_lbl_name sizeToFit];
    _lbl_name.center=CGPointMake(_img_head.centerX, _img_head.centerY+K_SCWIDTH*30+10);
    
    _lbl_collection=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-65, K_SCWIDTH*270+15, 65, 40)];
    _lbl_collection.textColor=UIColorFromRGB(colorGreen);
    _lbl_collection.textAlignment=NSTextAlignmentCenter;
    _lbl_collection.font=[UIFont systemFontOfSize:12];
    _lbl_collection.numberOfLines=2;
    _lbl_collection.userInteractionEnabled=YES;
    [self addSubview:_lbl_collection];
    
    [_lbl_collection addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollection)]];
    
    _lbl_join=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-130, K_SCWIDTH*270+15, 65, 40)];
    _lbl_join.textColor=UIColorFromRGB(colorGreen);
    _lbl_join.textAlignment=NSTextAlignmentCenter;
    _lbl_join.font=[UIFont systemFontOfSize:12];
    _lbl_join.numberOfLines=2;
    _lbl_join.userInteractionEnabled=YES;
    [self addSubview:_lbl_join];
    
     [_lbl_join addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapJoin)]];
    
    _lbl_distinguish=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-195, K_SCWIDTH*270+15, 65, 40)];
    _lbl_distinguish.textColor=UIColorFromRGB(colorTextLightColor);
    _lbl_distinguish.textAlignment=NSTextAlignmentCenter;
    _lbl_distinguish.font=[UIFont systemFontOfSize:12];
    _lbl_distinguish.numberOfLines=2;
    [self addSubview:_lbl_distinguish];
    
    UIView *view_left=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width-130, K_SCWIDTH*270+20, 1, 30)];
    view_left.backgroundColor=UIColorFromRGB(colorBackLineColor);
    [self addSubview:view_left];
    
    UIView *view_right=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width-65, K_SCWIDTH*270+20, 1, 30)];
    view_right.backgroundColor=UIColorFromRGB(colorBackLineColor);
    [self addSubview:view_right];
}

-(void)tapCollection{
    if (_delegate) {
        [_delegate sendCollectionController];
    }
}

-(void)tapJoin{
    if (_delegate) {
        [_delegate sendJoinController];
    }
}

-(void)setModel:(NSArray *)arr{
     NSMutableAttributedString *isStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n鉴别",arr[0]]];
 
    [isStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0,isStr1.length-2)];
    [isStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0,isStr1.length-2)];
    _lbl_distinguish.attributedText=isStr1;
    
    NSMutableAttributedString *isStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n参加",arr[1]]];
//    [isStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0,isStr2.length-2)];
    [isStr2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0,isStr2.length-2)];
    _lbl_join.attributedText=isStr2;
    
    
    NSMutableAttributedString *isStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n收藏",arr[2]]];
//    [isStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0,isStr3.length-2)];
    [isStr3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0,isStr3.length-2)];
    _lbl_collection.attributedText=isStr3;
    
    if (_lbl_name.size.width>K_SCWIDTH*60) {
        _lbl_name.frame=CGRectMake(20, _img_head.centerY+K_SCWIDTH*30+10, 200, 18);
    }
    
}

-(void)btnLogin{
    [[LoginView sharedInstance] pleaseGotoLogin];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
