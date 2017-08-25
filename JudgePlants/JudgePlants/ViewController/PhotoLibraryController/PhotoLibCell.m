//
//  PhotoLibCell.m
//  JudgePlants
//
//  Created by itm on 2017/7/17.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoLibCell.h"
#import "PhotoLibModel.h"
@implementation PhotoLibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(PhotoLibModel *)model{
    _model=model;
    
    _img_back.image=[UIImage imageNamed:_model.imgBack];
    _img_head.image=[UIImage imageNamed:_model.imgHead];
    _lbl_titleName.text=_model.lblTitle;
    _lbl_address.text=_model.lblAddress;
    _lbl_nickName.text=_model.lblName;
    [_btn_zan setTitle: [NSString stringWithFormat:@" %@",_model.zan] forState:UIControlStateNormal];
    [_btn_downLoad setTitle:[NSString stringWithFormat:@" %@",_model.downLoad] forState:UIControlStateNormal];
}

- (IBAction)btnDownLoad:(UIButton *)sender {
}

- (IBAction)btnZan:(UIButton *)sender {
    
    sender.selected=!sender.selected;
}
@end
