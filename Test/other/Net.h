//
//  Net.h
//  Test
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络相关功能

//定义成功回调block和失败回调block
typedef void (^ SuccessBlock)(id object);//成功回传数据
typedef void (^ FailureBlock)(NSError *error);//失败回传错误信息
@interface Net : NSObject

//Get方式网络请求
+ (void)getHttpURL:(NSString *)url completation:(SuccessBlock)success failure:(FailureBlock)failure;

//Post方式网络请求
+ (void)postHttpURL:(NSString *)url parameter:(NSDictionary *)parameter completation:(SuccessBlock)success failure:(FailureBlock)failure;

//设置状态栏风火轮
+ (void)setNetworkActivityIndicator:(BOOL)flag;
@end
