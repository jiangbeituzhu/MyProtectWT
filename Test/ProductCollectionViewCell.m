//
//  ProductCollectionViewCell.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _proImageView.layer.cornerRadius = 10;
    _proImageView.layer.masksToBounds = YES;
    
    _priceLabel.layer.cornerRadius = 5;
    _priceLabel.layer.masksToBounds = 5;
}

@end
