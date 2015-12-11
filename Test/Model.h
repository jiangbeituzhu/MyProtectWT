//
//  Model.h
//  FashionLife
//
//  Created by yzz on 15/10/27.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


@property (nonatomic,strong) NSString *id;
//主题
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;

//首页  图片
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *type;
//精选好物 图片
@property (nonatomic,strong) NSString *pic1;
@property (nonatomic,strong) NSString *tags;
@property (nonatomic,strong) NSString *share_url;

@property (nonatomic,strong) NSString *likes;
//topic 图片
@property (nonatomic,strong) NSString *pic;








@end
