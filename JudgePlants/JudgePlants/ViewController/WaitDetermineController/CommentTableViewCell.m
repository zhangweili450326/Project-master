//
//  CommentTableViewCell.m
//  JudgePlants
//
//  Created by itm on 2017/7/14.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "PlTextModel.h"
@implementation CommentTableViewCell

-(void)setModel:(PlTextModel *)model{
    _model=model;
    _img_icon.image=[UIImage imageNamed:_model.img_head];
    _lbl_name.text=_model.nickName;
    _lbl_time.text=_model.time;
    _lbl_content.attributedText=[[NSAttributedString alloc]initWithString:_model.content];
    [UILabel changeLineSpaceForLabel:_lbl_content WithSpace:5];
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
