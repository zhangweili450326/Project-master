//
//  StringTool.m
//  JudgePlants
//
//  Created by itm on 2017/5/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "StringTool.h"

@implementation StringTool

+(BOOL)checkStringIsNull:(NSString *)text{
    if ([text isEqual:[NSNull null]] || text==nil) {
        return YES;
    }else{
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (text.length==0) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)checkObjectIsNull:(NSObject *)text{
    if ([text isEqual:[NSNull null]] || text==nil) {
        return YES;
    }else{
        NSString *result = [NSString stringWithFormat:@"%@",text];
        if (![@"" isEqualToString:result]&&![@"<null>" isEqualToString:result]&&![@"(null)" isEqualToString:result]&&![@"null" isEqualToString:result]) {
            return NO;
        }else{
            return YES;
        }
    }
}

+(BOOL)checkStringIsContainNumber:(NSString *)text{
    if ([text containsString:@"0"]) {
        return YES;
    }else if ([text containsString:@"1"]){
        return YES;
    }else if ([text containsString:@"2"]){
        return YES;
    }else if ([text containsString:@"3"]){
        return YES;
    }else if ([text containsString:@"4"]){
        return YES;
    }else if ([text containsString:@"5"]){
        return YES;
    }else if ([text containsString:@"6"]){
        return YES;
    }else if ([text containsString:@"7"]){
        return YES;
    }else if ([text containsString:@"8"]){
        return YES;
    }else if ([text containsString:@"9"]){
        return YES;
    }else{
        return NO;
    }
}
@end
