//
//  DateTool.m
//  JudgePlants
//
//  Created by itm on 2017/5/25.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool

+(NSString *)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
@end
