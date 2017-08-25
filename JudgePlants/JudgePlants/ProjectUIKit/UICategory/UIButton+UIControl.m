//
//  UIButton+UIControl.m
//  runtime1
//
//  Created by zwl on 17/3/31.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "UIButton+UIControl.h"
#import <objc/runtime.h>
@interface UIControl ()
@property (nonatomic,assign) NSTimeInterval acceptEventTime;
@end

@implementation UIButton (UIControl)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

-(void)setRightImage{
    // 还可增设间距
    CGFloat spacing = 3;
    // 图片右移
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
    // 文字左移
    CGSize titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
    /* 小结: imageEdgeInsets 为'上左下右', 正值远离中心, 负值向中心聚拢. 具体以单词'inset'来记忆 */
}

- (NSTimeInterval )accepEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAccepEventInterval:(NSTimeInterval)accepEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(accepEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )acceptEventTime{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)cjr_acceptEventTime{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cjr_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (void)load{
    //获取着两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(cjr_sendAction:to:forEvent:));
    SEL mySEL = @selector(cjr_sendAction:to:forEvent:);
    
    //添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    //如果方法已经存在了
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
        
    }
    
    //----------------以上主要是实现两个方法的互换,load是gcd的只shareinstance，果断保证执行一次
    
}

- (void)cjr_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.acceptEventTime < self.accepEventInterval) {
        return;
    }
   
    if (self.accepEventInterval > 0) {
        self.acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self cjr_sendAction:action to:target forEvent:event];
}
@end
