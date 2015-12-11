//
//  Net.m
//  Computer
//
//  Created by yzz on 15/10/21.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "Net.h"

#import "AFHTTPRequestOperationManager.h"

@implementation Net

//GET
+ (void)getHttpURL:(NSString *)url completation:(SuccessBlock)success failure:(FailureBlock)failure{
    
    //下载开始，启动风火轮
    [self setNetworkActivityIndicator:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self setNetworkActivityIndicator:NO];
        //回调block，同时传值
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //下载失败,关闭风火轮
        [self setNetworkActivityIndicator:NO];
        failure(error);
    }];

}
//POST
+ (void)postHttpURL:(NSString *)url parameter:(NSDictionary *)parameter completation:(SuccessBlock)success failure:(FailureBlock)failure{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}
//风火轮
+ (void)setNetworkActivityIndicator:(BOOL)flag{

    //程序的生命周期
    UIApplication *app = [UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:flag];
}
@end
