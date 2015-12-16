//
//  ProductDetailViewController.h
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController

//搜索页中，单品传来的ID、typeID
@property (nonatomic,strong) NSString *productID;
@property (nonatomic,strong) NSString *proTypeID;

@end
