//
//  PhotoDetailView.m
//  JudgePlants
//
//  Created by itm on 2017/7/17.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoDetailView.h"
#import "PhotoLibModel.h"

@implementation PhotoDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btn_downLoad:(UIButton *)sender {
    if (_blockClickDownLoad) {
        _blockClickDownLoad(sender);
    }
}

- (IBAction)btnZan:(UIButton *)sender {
    if (_blockClickZan) {
        self.blockClickZan(sender);
    }
}

-(void)setModel:(PhotoLibModel *)model{
    _model=model;
    _lbl_titleName.text=_model.lblTitle;
    [_btn_address setTitle:[NSString stringWithFormat:@" %@",_model.lblAddress] forState:UIControlStateNormal];
    [_btn_zan setTitle:[NSString stringWithFormat:@" %@",_model.zan] forState:UIControlStateNormal];
    [_btn_downLoad setTitle:[NSString stringWithFormat:@" %@",_model.downLoad] forState:UIControlStateNormal];
}

-(id)init
{
    
    self=[[[NSBundle mainBundle]loadNibNamed:@"PhotoDetailView" owner:nil options:nil] firstObject];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithWhite:0 alpha:1];
    }
    return self;
}


@end
