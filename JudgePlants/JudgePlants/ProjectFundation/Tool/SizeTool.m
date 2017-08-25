//
//  SizeTool.m
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import "SizeTool.h"

@implementation SizeTool
+(CGSize)sizeTofitWithTitle:(NSString *)content fontAmount:(float)font height:(float)height{
  
        CGRect rect = [content boundingRectWithSize:CGSizeMake(Screen_Width,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
        return rect.size;
    
}

+(CGSize)sizeTofitWithTitle:(NSString *)content fontAmount:(float)font width:(float)width{
    
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
        return rect.size;
    
}

@end
