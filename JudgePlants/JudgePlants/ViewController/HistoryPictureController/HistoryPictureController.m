//
//  HistoryPictureController.m
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "HistoryPictureController.h"
#import "HistoryPhotoCell.h"
#import "HistoryPhotoModel.h"
@interface HistoryPictureController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
}
@property (nonatomic,strong) NSMutableArray *arr_data;
@end

@implementation HistoryPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"历史记录";
    [self initTableView];
    [self loadData];
}
-(void)loadData{
    _arr_data=[[NSMutableArray alloc]init];
    _arr_data=[[PhotoDB shareInstance] selectManageToolAllObject];
}

-(void)initTableView{
    tv=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tv.delegate=self;
    tv.dataSource=self;
    tv.tableFooterView=[[UIView alloc]init];
    tv.rowHeight=120;
    [self.view addSubview:tv];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr_data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryPhotoCell *cell=[HistoryPhotoCell getCellWithTableView:tableView];
    cell.model=_arr_data[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            HistoryPhotoModel *model=_arr_data[indexPath.row];
            [_arr_data removeObjectAtIndex:[indexPath row]];
            [[PhotoDB shareInstance] deletePhotoToolById:model.Id];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];

        }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tableViewCell下划线左对齐
-(void)viewDidLayoutSubviews
{
    if([tv respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tv setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if([tv respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tv setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
