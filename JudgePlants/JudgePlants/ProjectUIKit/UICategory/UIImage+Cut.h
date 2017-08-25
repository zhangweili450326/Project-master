//
//  UIImage+Cut.h
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)
//等比例缩放
-(UIImage*)scaleToSizePerson;
-(UIImage*)getSubImage:(CGRect)rect;

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur ;
//纠正图片
+(UIImage* )rotateImage:(UIImage *)aImage;

+ (UIImage *)resizedImageWithName:(NSString *)name;
@end
