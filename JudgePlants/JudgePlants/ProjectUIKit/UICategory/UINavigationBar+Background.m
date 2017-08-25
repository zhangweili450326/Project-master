//
//  UINavigationBar+Background.m
//  JudgePlants
//
//  Created by itm on 2017/6/29.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "UINavigationBar+Background.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Background)
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cnSetBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.overlay];
        [self sendSubviewToBack:self.overlay];
       
    }
    
    self.overlay.backgroundColor = backgroundColor;
}

- (void)cnReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}


@end
