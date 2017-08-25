//
//  ShowImageCell.m
//  JudgePlants
//
//  Created by itm on 2017/5/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "ShowImageCell.h"

@implementation ShowImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.layer.doubleSided = NO;
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.img_name = [[UIImageView alloc] init];
    self.img_name.backgroundColor = [UIColor clearColor];
    self.img_name.layer.borderWidth=1.5;
    self.img_name.layer.borderColor=[UIColor whiteColor].CGColor;
   
    
    
    self.lbl_name = [[UILabel alloc] init];
    self.lbl_name.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    self.lbl_name.textColor=[UIColor whiteColor];
    self.lbl_name.numberOfLines=0;
    
    self.lbl_precision=[[UILabel alloc]init];
    self.lbl_precision.font=[UIFont systemFontOfSize:13];
    self.lbl_precision.textColor=[UIColor whiteColor];
   
    
    [self.contentView addSubview:self.img_name];
    [self.contentView addSubview:self.lbl_name];
    [self.contentView addSubview:self.lbl_precision];
    
    CGFloat Sheight=self.contentView.bounds.size.height;
    
    [_img_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(Sheight-40, Sheight-40));
    }];
    
    [_lbl_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.equalTo(_img_name.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [_lbl_precision mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(20);
        
    }];
    
}

-(void)setCellModel:(NSArray *)arrayData andImage:(UIImage *)img{
    _img_name.image=img;
    CGFloat precison =[arrayData[1] floatValue]*100;
    NSString *ider=@"%";
    if (arrayData.count>1) {
        _lbl_precision.text=[NSString stringWithFormat:@"可信度%.1f%@",precison,ider];
    }
    if (arrayData.count>2) {
        _lbl_name.text=[NSString stringWithFormat:@"%@",arrayData[2]];
    }
}

@end
