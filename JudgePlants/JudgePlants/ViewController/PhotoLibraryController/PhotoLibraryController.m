//
//  PhotoLibraryController.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoLibraryController.h"
#import "PhotoLibCell.h"
#import "PhotoLibModel.h"
#import "PhotoLibDetailController.h"

@interface PhotoLibraryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tv;

@property (nonatomic,strong) NSMutableArray *arr_data;
@end

@implementation PhotoLibraryController

-(NSMutableArray *)arr_data{
    if (_arr_data==nil) {
        _arr_data=[[NSMutableArray alloc]init];
    }
    return _arr_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"照片库";
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem=nil;
    [self initTableView];
    [self initModel];
    [self initRefresh];
}

-(void)initRefresh{
    
    __unsafe_unretained UITableView *tableView = self.tv;
    // 下拉刷新

    
    tableView.mj_header= [JPHeadAnimationRefresh headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    
    
    // 上拉刷新
    tableView.mj_footer = [JPFooterRefresh footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self initModel];
            [tableView.mj_footer endRefreshing];
        });
    }];

    
}

-(void)initModel{
    
    for (int i=0; i<10; i++) {
        PhotoLibModel *model=[[PhotoLibModel alloc]init];
        if (i==9) {
            model.imgHead=@"010";
            model.imgBack=@"010";
        }else{
            model.imgBack=[NSString stringWithFormat:@"00%@",@(i+1)];
            model.imgHead=[NSString stringWithFormat:@"00%@",@(i+1)];
        };
        model.lblName=[NSString stringWithFormat:@"扎心了老铁%@",@(i+1)];
        model.lblAddress=@"深圳市南山区";
        if (i==0) {
            model.lblTitle=@"香樟";
          
        }else if (i%2==0){
            model.lblTitle=@"桃花树";
           
        }else{
            model.lblTitle=@"黄皮果树";
      
        }
        
        model.zan=[NSString stringWithFormat:@"%@",@(i+998)];
        model.downLoad=[NSString stringWithFormat:@"%@",@(i+98)];
        
          [self.arr_data addObject:model];
       
    }
    [_tv reloadData];
}

-(void)initTableView{
    
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tv.backgroundColor=UIColorFromRGB(colorGroupViewColor);
    _tv.dataSource=self;
    _tv.delegate=self;
    [self.view addSubview:_tv];
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tv.estimatedRowHeight = 320;//很重要保障滑动流畅性
    _tv.rowHeight=UITableViewAutomaticDimension;
    [_tv registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoLibCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PhotoLibCell class])];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arr_data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoLibCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PhotoLibCell class])];
    cell.model=_arr_data[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.3];
    PhotoLibDetailController *controller=[[PhotoLibDetailController alloc]init];
    controller.model=_arr_data[indexPath.section];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
