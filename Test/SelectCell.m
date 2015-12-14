//
//  SelectCell.m
//  FashionLife
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (void)awakeFromNib {
    // Initialization code
    
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

#pragma mark 按钮点击事件
- (IBAction)shareButtonClick:(id)sender {
    
    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"5507875dfd98c5fef20001dd"
//                                      shareText:@"话题很精彩"
//                                     shareImage:nil
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
//                                       delegate:self];
 
    NSLog(@"share");
}

- (IBAction)commendButtonClick:(id)sender {
    
    
    NSLog(@"pinglun");
    
}

- (IBAction)collectButtonClick:(id)sender {
    
    NSLog(@"收藏");
}
@end
