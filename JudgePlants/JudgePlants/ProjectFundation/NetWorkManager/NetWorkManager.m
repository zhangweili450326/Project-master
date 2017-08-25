//
//  NetWorkManager.m
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import "NetWorkManager.h"
#import "LoadingView.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
@interface NetWorkManager ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation NetWorkManager


+ (NetWorkManager *)sharedNetWorkManager
{
    static NetWorkManager *sharedNetWorkManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetWorkManagerInstance = [[self alloc] init];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
        manager.securityPolicy.allowInvalidCertificates=NO;//是否验证证书
        manager.securityPolicy.validatesDomainName=NO; //是否验证域名
        
        sharedNetWorkManagerInstance.manager=manager;
    });
    return sharedNetWorkManagerInstance;
}


-(void)GETWithURL:(NSString *)strURL parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure
{
    
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDlg.networkStatus currentReachabilityStatus] == NotReachable ){
         [AlerTool showError:@"没有网络。"];
        return;
    }
   
   _manager.requestSerializer.timeoutInterval = 20;

    [_manager GET:strURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary *dic=error.userInfo;
        if (dic!=nil||![dic isEqual:[NSNull null]]) {
            NSString *failureReson;
            if (dic[@"NSLocalizedDescription"]!=nil) {
                failureReson=dic[@"NSLocalizedDescription"];
               
                }else{
                failureReson =@"服务器异常";
            }
             failure(failureReson);
            [AlerTool showError:failureReson];
        }
        
    }];
}



- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure {
    
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDlg.networkStatus currentReachabilityStatus] == NotReachable ){
        [AlerTool showError:@"没有网络。"];
        return;
    }
    
     _manager.requestSerializer.timeoutInterval = 20;
    [_manager POST:strURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSDictionary *dic=error.userInfo;
        if (dic!=nil||![dic isEqual:[NSNull null]]) {
            NSString *failureReson;
            if (dic[@"NSLocalizedDescription"]!=nil) {
                failureReson=dic[@"NSLocalizedDescription"];
            }else{
                failureReson =@"服务器异常";
            }
            failure(failureReson);
            [AlerTool showError:failureReson];
        }

    }];
    
}


-(void)POSTFileWithURL:(NSString *)strURL ArrayPath:(NSArray *)dataSource parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure
{
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDlg.networkStatus currentReachabilityStatus] == NotReachable ){
        [AlerTool showError:@"没有网络。"];
        return;
    }
    
     _manager.requestSerializer.timeoutInterval = 20;
//    [AlerTool showMessage:nil];
    [_manager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        if (fileData==nil) {
            for (int i=0; i<dataSource.count; i++) {
                //获取当前图片
                UIImage *image=dataSource[i];
                NSData *data=UIImagePNGRepresentation(image);
                // 添加准备上传的图片
                [formData appendPartWithFileData:data name:@"file" fileName:@"file" mimeType:@"image/jpg"];

                DLog(@"多上传图片%@",formData);
            }
//        }
//        else
//        {
//            //获取当前图片
//            UIImage *image=dataSource[0];
//            NSData *data=UIImagePNGRepresentation(image);
//            // 添加准备上传的图片
//            [formData appendPartWithFileData:data name:@"thumb" fileName:[NSString stringWithFormat:@"%d.jpg",1] mimeType:@"image/jpg"];
//            
//            [formData appendPartWithFileData:fileData name:@"attach" fileName:[NSString stringWithFormat:@"shipin%d.mp4",1] mimeType:@"video/mp4"];
//            DLog(@"上传视频%@",formData);
//        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    success(dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic=error.userInfo;
        if (dic!=nil||![dic isEqual:[NSNull null]]) {
            NSString *failureReson;
            if (dic[@"NSLocalizedDescription"]!=nil) {
                failureReson=dic[@"NSLocalizedDescription"];
            }else{
                failureReson =@"服务器异常";
            }
            failure(failureReson);
            [AlerTool showError:failureReson];
        }

    }];
}

@end
