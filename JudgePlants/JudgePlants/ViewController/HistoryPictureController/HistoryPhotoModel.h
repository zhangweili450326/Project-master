//
//  HistoryPhotoModel.h
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryPhotoModel : NSObject

@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *imgId;

@property (nonatomic,copy) NSString *name; //名字

@property (nonatomic,copy) NSString *name_English;//外文名

@property (nonatomic,copy) NSString *createTime; //创建日期

@property (nonatomic,copy) NSString *address; //地址

@property (nonatomic,copy) NSString *detail; //详细信息

@property (nonatomic,copy) NSString *reliability;//可信度

@property (nonatomic,copy) NSString *image_local; //本地图片

@property (nonatomic,copy) NSString *image_url; //网络下载最大相似度图片

@end
