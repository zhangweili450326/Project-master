//
//  DownButtom.m
//  itaomiao
//
//  Created by itm on 2017/3/21.
//  Copyright © 2017年 习武. All rights reserved.
//

#import "DownButtom.h"

@implementation DownButtom

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
   
    }
    return self;
}

/**
 *  防止文字太长 导致图片的位置不在中间
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleEdgeInsets =UIEdgeInsetsMake(self.imageView.bounds.size.height, -self.imageView.bounds.size.width, 0, 0);
    self.imageEdgeInsets =UIEdgeInsetsMake(-self.titleLabel.bounds.size.height, 0.5*self.titleLabel.bounds.size.width, 0.5*self.titleLabel.bounds.size.height, 0);
    
    if(self.titleLabel.text && self.imageView.image)
    {
        CGFloat marginH = (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height)/3;
        
        //图片
        CGPoint imageCenter = self.imageView.center;
        imageCenter.x = self.frame.size.width/2;
        imageCenter.y = self.imageView.frame.size.height/2 + marginH;
        self.imageView.center = imageCenter;
        //文字
        CGRect newFrame = self.titleLabel.frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = self.frame.size.height - newFrame.size.height - marginH;
        newFrame.size.width = self.frame.size.width;
        self.titleLabel.frame = newFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
