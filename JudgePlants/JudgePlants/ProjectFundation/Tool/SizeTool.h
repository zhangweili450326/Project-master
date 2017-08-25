//
//  SizeTool.h
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SizeTool : NSObject
+(CGSize)sizeTofitWithTitle:(NSString *)content fontAmount:(float)font height:(float)height;

+(CGSize)sizeTofitWithTitle:(NSString *)content fontAmount:(float)font width:(float)width;
@end
