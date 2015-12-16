//
//  SearchViewController.h
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

//接收上一页searchBar上的值
@property (nonatomic,strong) NSString *searchStr;
//请求搜索的网址
@property (nonatomic,strong) NSString *productUrl;

@end
