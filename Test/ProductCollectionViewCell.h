//
//  ProductCollectionViewCell.h
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *proImageView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
