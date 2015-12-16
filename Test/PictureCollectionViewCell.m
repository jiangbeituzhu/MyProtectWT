//
//  PictureCollectionViewCell.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.contentView addSubview:view];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50 , 50)];
    _imageView.layer.cornerRadius = 25;
    _imageView.layer.masksToBounds = YES;
    [view addSubview:_imageView];
    
    _topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 30)];
    _topicLabel.textAlignment = NSTextAlignmentLeft;
    _topicLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:_topicLabel];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10 + 30, 100, 30)];
    _nameLabel.textColor = [UIColor lightGrayColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:_nameLabel];
    

}
@end
