//
//  MyHeaderView.m
//  FashionLife
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "MyHeaderView.h"
#import "Header.h"

@implementation MyHeaderView


- (instancetype)initWithFrame:(CGRect)frame{

    if ( self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//加载xib文件
- (id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        self.frame = CGRectMake(0, 0, WIDTH, 180);
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)loginClick:(id)sender {
}

- (IBAction)myOrderClick:(id)sender {
}

- (IBAction)myShoppingClick:(id)sender {
}
@end
