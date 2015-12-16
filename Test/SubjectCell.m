//
//  SubjectCell.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "SubjectCell.h"

@implementation SubjectCell

- (void)awakeFromNib {
    // Initialization code
    _subImageView.layer.cornerRadius = 10;
    _subImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
