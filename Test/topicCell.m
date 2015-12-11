//
//  topicCell.m
//  Test
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "topicCell.h"

@implementation topicCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setTopicView];

}

- (void)setTopicView{
    self.topicLoveView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.topicLoveView.layer.borderWidth = 1.0;
    self.topicLoveView.layer.cornerRadius = 8;
    self.topicLoveView.layer.masksToBounds = YES;
    
    self.topicImageView.layer.cornerRadius = 5.0;
    self.topicImageView.layer.masksToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
