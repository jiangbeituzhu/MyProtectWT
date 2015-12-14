//
//  SelectCell.h
//  FashionLife
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"


@interface SelectCell : UITableViewCell<UMSocialUIDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UILabel *descLable;

@property (strong, nonatomic) IBOutlet UIImageView *typeImageView;
@property (strong, nonatomic) IBOutlet UILabel *typeLable;

@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UIButton *collectionButton;


- (IBAction)shareButtonClick:(id)sender;

- (IBAction)commendButtonClick:(id)sender;

- (IBAction)collectButtonClick:(id)sender;

@end
