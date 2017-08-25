//
//  NSObject+Check.m
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import "NSObject+Check.h"

@implementation NSObject (Check)


- (BOOL)isNull
{
    return [self isMemberOfClass:[NSNull class]];
}

-(BOOL)checkIsNull{
    NSString *data = nil;
    if ([self isKindOfClass:[NSString class]]) {
        data = (NSString *)self;
    }else{
        data = [NSString stringWithFormat:@"%@",self];
    }
    if (data!=nil&&![data isNull]&&![@"" isEqualToString:data]&&![@"<null>" isEqualToString:data]&&![@"(null)" isEqualToString:data]&&![@"null" isEqualToString:data]) {
        return NO;
    }
    return YES;
}

-(BOOL)checkIsPlantNull{
    NSString *data = nil;
    if ([self isKindOfClass:[NSString class]]) {
        data = (NSString *)self;
    }else{
        data = [NSString stringWithFormat:@"%@",self];
    }
    if (data!=nil&&![data isNull]&&![@"" isEqualToString:data]&&![@"<null>" isEqualToString:data]&&![@"(null)" isEqualToString:data]&&![@"0" isEqualToString:data]&&![@"null" isEqualToString:data]) {
        return NO;
    }
    return YES;
}


@end
