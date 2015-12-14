//
//  FindModel.h
//  Test
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *datestr;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *likes;

@property (nonatomic,strong) NSString *picUrl;
@property (nonatomic,strong) NSString *share_url;
@property (nonatomic,strong) NSMutableArray *tags;
@property (nonatomic,strong) NSString *icon;

@end
