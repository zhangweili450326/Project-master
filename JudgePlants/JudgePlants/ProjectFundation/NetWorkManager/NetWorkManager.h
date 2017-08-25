//
//  NetWorkManager.h
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkManager : NSObject

+ (NetWorkManager *)sharedNetWorkManager;

-(void)GETWithURL:(NSString *)strURL
       parameters:(id)parameters
          success:(void (^)(NSDictionary *dit))success
          failure:(void (^)( NSString *error))failure;

- (void)POSTWithURL:(NSString *)strURL
         parameters:(id)parameters
            success:(void (^)(NSDictionary *dit))success
            failure:(void (^)( NSString *error))failure;


-(void)POSTFileWithURL:(NSString *)strURL
             ArrayPath:(NSArray *)dataSource
            parameters:(id)parameters
               success:(void (^)(NSDictionary *dit))success
               failure:(void (^)( NSString *error))failure;


@end
