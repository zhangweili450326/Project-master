//
//  PhotoLibDetailController.m
//  JudgePlants
//
//  Created by itm on 2017/7/17.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoLibDetailController.h"
#import "PhotoLibModel.h"
#import "PhotoDetailView.h"
#import "LoveHeartView.h"
#import "PhotoAlertView.h"
@interface PhotoLibDetailController ()

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic, assign) CGFloat zoomScale;
@end

@implementation PhotoLibDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=UIColorFromRGB(0x3c3d3e);
    
    self.lbl_navTitle.text=[NSString stringWithFormat:@"%@ 的作品",_model.lblName];
    [self initBootmView];
    [self initImageView];
    [self changeImageViewFrame];
}

-(void)initImageView{
    self.img=[[UIImageView alloc]initWithFrame:self.view.bounds];
    self.img.userInteractionEnabled=YES;
    [self.view addSubview:self.img];
    self.zoomScale=1;

   
}

-(void)changeImageViewFrame{
    UIImage *image=[UIImage imageNamed:_model.imgBack];
    if (image) {
        
        CGFloat scale_H = Screen_Height / image.size.height;
        CGFloat scale_W = Screen_Width / image.size.width;
        CGSize size;
        if (scale_H > scale_W) {
            size = CGSizeMake(Screen_Width, scale_W * image.size.height);
        }
        else  if (scale_H < scale_W) {
            size = CGSizeMake(scale_H * image.size.width, Screen_Height);
        }else{
            size=CGSizeMake(Screen_Width, Screen_Height);
        }
        
        self.img.frame = CGRectMake(0, 0, size.width, size.height);
        self.img.center = self.view.center;
        self.img.image = image;
    }

    
}

-(void)initBootmView{
    PhotoDetailView *bootmView=[[PhotoDetailView alloc]init];
    bootmView.frame=CGRectMake(0,Screen_Height-75,Screen_Width , 75);
    bootmView.model=_model;
    [self.view addSubview:bootmView];
    bootmView.blockClickZan = ^(UIButton *sender) {
        
        LoveHeartView *heart = [[LoveHeartView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.view addSubview:heart];
        CGPoint fountainSource = CGPointMake(sender.x+5, self.view.bounds.size.height - 50);
        heart.center = fountainSource;
        [heart animateInView:self.view];
    };
    
    bootmView.blockClickDownLoad = ^(UIButton *sender) {
        
//        [self.img sd_setImageWithURL:nil placeholderImage:nil options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//            
//            
//            
//        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            
//            
//            
//        }];
        
        [[PhotoAlertView shareInstance]showAlertViewWithMessage:@"保存成功" andSuccess:YES];
    };
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
