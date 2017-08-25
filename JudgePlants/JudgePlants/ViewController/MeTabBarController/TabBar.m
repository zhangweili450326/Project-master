//
//  TabBar.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"

@interface TabBar()


@property (nonatomic, weak) TabBarButton *selectedButton;

@end

@implementation TabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        TabBarButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;

        if (index==2) {
            button.frame = CGRectMake((w-h)/2, 0, buttonH, buttonH);
         
        }else
        {
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
        
        // 3.绑定tag
        button.tag = index;
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(TabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    TabBarButton *button = [[TabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        
        [self buttonClick:button];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    self.selectedButton.selected = NO;
    self.selectedButton = self.tabBarButtons[selectIndex];
    self.selectedButton.selected = YES;
}


@end
