//
//  GoodDetailViewController.m
//  FashionLife
//
//  Created by yzz on 15/10/28.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "Header.h"
#import "Function.h"
#import "UMSocial.h"

@interface GoodDetailViewController ()<UMSocialUIDelegate>

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"本期话题";
    
    [self setLeftAndRightBarButton];
    
    // 精选好物传值跳转
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodUrl]]];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    
}
#pragma mark - GoodDetail界面上控件和标题设置
- (void)setLeftAndRightBarButton{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pay_arrowleft"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Session_Multi_Forward"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
}

#pragma mark - 左右按钮点击事件
//返回上一层
- (void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
}
//分享
- (void)shareClick{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5507875dfd98c5fef20001dd"
                                      shareText:@"话题很精彩"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
                                       delegate:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
