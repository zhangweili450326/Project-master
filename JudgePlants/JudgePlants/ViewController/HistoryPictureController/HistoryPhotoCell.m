//
//  HistoryPhotoCell.m
//  JudgePlants
//
//  Created by itm on 2017/5/25.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "HistoryPhotoCell.h"
#import "HistoryPhotoModel.h"
@implementation HistoryPhotoCell

+(instancetype)getCellWithTableView:(UITableView *)tableView
{
    NSString *ider=NSStringFromClass([HistoryPhotoCell class]);
    
    HistoryPhotoCell *cell=[tableView dequeueReusableCellWithIdentifier:ider];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([HistoryPhotoCell class]) owner:nil options:nil] firstObject];
        
    }
    
    return cell;
    
}

-(void)setModel:(HistoryPhotoModel *)model{
    _model=model;
    NSData *data = [_model.image_local dataUsingEncoding:NSUTF8StringEncoding];
    // 解密Data
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedData:data options:0];

    UIImage *image=[UIImage imageWithData:decodeData];
    _img.image=image;
    CGFloat precison =[_model.reliability floatValue]*100;
    NSString *ider=@"%";
    _lbl_re.text=[NSString stringWithFormat:@"可信度%.1f%@",precison,ider];
    _lbl_name.text=_model.name;
    _lbl_address.text=_model.address;
    _lbl_createTime.text=_model.createTime;
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
