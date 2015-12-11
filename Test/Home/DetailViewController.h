//
//  DetailViewController.h
//  FashionLife
//
//  Created by yzz on 15/10/29.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"

@interface DetailViewController : UIViewController


//用于传值，接收上一页cell上的标题、图片、id
@property (nonatomic,strong) NSString *iconID;

@end
