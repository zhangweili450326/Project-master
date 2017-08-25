//
//  HistoryPhotoCell.h
//  JudgePlants
//
//  Created by itm on 2017/5/25.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryPhotoModel;
@interface HistoryPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbl_re;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_address;
@property (weak, nonatomic) IBOutlet UILabel *lbl_createTime;
+(instancetype)getCellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) HistoryPhotoModel *model;
@end
