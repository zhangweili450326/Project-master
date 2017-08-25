//
//  MeTableCell.m
//  JudgePlants
//
//  Created by itm on 2017/7/11.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeTableCell.h"
#import "UnderMeView.h"
#import "MeContentModel.h"
@interface MeTableCell ()<protocolChangeCollectionViewHeighDelegate>

@property (nonatomic,strong) UILabel *lbl_createTime;
@property (nonatomic,strong) UIView *view_line;
@property (nonatomic,strong) UIImageView *img_cor;
@property (nonatomic,strong) UIView *view_back;
@property (nonatomic,strong) UIImageView *img_photo;
@property (nonatomic,strong) UILabel *lbl_title;
@property (nonatomic,strong) UIButton *btn_delete;
@property (nonatomic,strong) UIImageView *img_san;
@property (nonatomic,strong) UnderMeView *underView;
@end

@implementation MeTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
       self.contentView.backgroundColor=UIColorFromRGB(colorGroupViewColor);
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _lbl_createTime=[[UILabel alloc]init];
    _lbl_createTime.backgroundColor=UIColorFromRGB(colorGreen);
    _lbl_createTime.font=[UIFont systemFontOfSize:12];
    _lbl_createTime.layer.cornerRadius=3.0;
    _lbl_createTime.layer.masksToBounds=YES;
    _lbl_createTime.textAlignment=NSTextAlignmentCenter;
    _lbl_createTime.textColor=[UIColor whiteColor];
    _lbl_createTime.numberOfLines=2;
    [self.contentView addSubview:_lbl_createTime];
    
    _view_line=[[UIView alloc]init];
    _view_line.backgroundColor=UIColorFromRGB(colorBackLineColor);
    [self.contentView addSubview:_view_line];
    _img_cor=[[UIImageView alloc]init];
    _img_cor.image=[UIImage imageNamed:@"me_table_circle"];
    [self.contentView addSubview:_img_cor];
    
    
    _img_san=[[UIImageView alloc]init];
    _img_san.image=[UIImage imageNamed:@"me_triangle"];
    [self.contentView addSubview:_img_san];
    
    _view_back=[[UIView alloc]init];
    _view_back.backgroundColor=[UIColor whiteColor];
    _view_back.layer.cornerRadius=3.0;
    _view_back.userInteractionEnabled=YES;
    [self.contentView addSubview:_view_back];
    
    _img_photo=[[UIImageView alloc]init];
    _img_photo.image=[UIImage imageNamed:@"me_imageBack"];
    [_view_back addSubview:_img_photo];
    
    _lbl_title=[[UILabel alloc]init];
    [_view_back addSubview:_lbl_title];
    
    _btn_delete=[[UIButton alloc]init];
    [_btn_delete setBackgroundImage:[UIImage imageNamed:@"me_delete"] forState:UIControlStateNormal];
    [_btn_delete addTarget:self action:@selector(btnDelete) forControlEvents:UIControlEventTouchUpInside];
    [_view_back addSubview:_btn_delete];
    
    _underView=[[UnderMeView alloc]init];
    _underView.delegate=self;
    [_view_back addSubview:_underView];
    
//    [self setViewAtuoLayout];
}

//- (void)setViewAtuoLayout{
//    
//    [self.lbl_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@15);
//        make.width.equalTo(@51);
//        make.height.equalTo(@44);
//        
//    }];
//    
//    [self.view_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.lbl_createTime.mas_right).with.offset(10);
//        make.top.and.bottom.equalTo(@0);
//        make.width.equalTo(@1);
//    }];
//    
//    [self.img_cor mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view_line.mas_centerX);
//        make.centerY.equalTo(@20);
//        make.width.and.height.equalTo(@10);
//    }];
//    
//    [self.img_san mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.img_san.mas_right).with.offset(4);
//        make.centerY.equalTo(self.img_cor.mas_centerY);
//        make.height.equalTo(@9);
//        make.width.equalTo(@7);
//    }];
//    
//    [self.view_back mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.img_san.mas_right);
//        make.top.equalTo(@14);
//        make.right.equalTo(@(-10));
//        make.height.equalTo(@500);
//    }];
//    
//    [self.img_photo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.top.equalTo(@10);
//        make.width.equalTo(@200);
//        make.height.equalTo(self.img_photo.mas_width);
//    }];
//    
//    [self.lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(self.img_photo.mas_bottom).with.offset(10);
//        make.right.equalTo(self.btn_delete.mas_left);
//        make.height.equalTo(@15);
//    }];
//    
//    [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.img_photo.mas_bottom).with.offset(10);
//        make.right.equalTo(@(-10));
//        make.height.equalTo(@25);
//        make.width.equalTo(@22);
//    }];
//    
//    [self.underView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.top.equalTo(@10);
//        make.right.equalTo(@(-10));
//        make.height.equalTo(@100);
//    }];
//    
//}


-(void)btnDelete{
    
}


-(void)setModel:(MeContentModel *)model{
    _model=model;
   
    _lbl_title.text=_model.title;
    _img_photo.image=[UIImage imageNamed:model.img];
    
    
    NSMutableAttributedString *isStr1 = [[NSMutableAttributedString alloc] initWithString:_model.time];
    [isStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0,1)];
   _lbl_createTime.attributedText=isStr1;
    
    _lbl_createTime.frame=CGRectMake(10, 15, 51, 44);
    _view_line.frame=CGRectMake(CGRectGetMaxX(_lbl_createTime.frame)+10,0, 1, CGRectGetMaxX(self.contentView.frame));
    [_img_cor sizeToFit];
    _img_cor.center=CGPointMake(_view_line.x, 30);
    [_img_san sizeToFit];
    _img_san.center=CGPointMake(_view_line.x+10, 30);
    _view_back.frame=CGRectMake(CGRectGetMaxX(_img_san.frame), 14, Screen_Width-CGRectGetMaxX(_img_san.frame)-10, 400);
    _img_photo.frame=CGRectMake(10, 10, _view_back.width-20, _view_back.width-20);
    _lbl_title.frame=CGRectMake(10,CGRectGetMaxY(_img_photo.frame)+10 ,_view_back.width-35, 20);
    _btn_delete.frame=CGRectMake(_view_back.width-28, _lbl_title.y, 18, 20);
    
    _underView.frame=CGRectMake(10, _lbl_title.y+25, _view_back.width-20, 50);
    _underView.model=model;
    
}
-(void)changeCollectionViewHeigh:(CGFloat)heigh{
     _underView.frame=CGRectMake(10,_lbl_title.y+30, _view_back.width-20, heigh);
    _view_back.size=CGSizeMake(Screen_Width-CGRectGetMaxX(_img_san.frame)-10,_lbl_title.y+30+heigh+10);
    _cellHeigh=_view_back.height+14;
    _view_line.size=CGSizeMake(1, _cellHeigh);
    [self.contentView bringSubviewToFront:_img_cor];
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
