//
//  DetailViewController.m
//  FashionLife
//
//  Created by yzz on 15/10/29.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "DetailViewController.h"
#import "Header.h"
#import "Net.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

{
    //接收上一页传值解析出的数据
    NSDictionary *_dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"专题详情";
    
    [self startRequest:[NSString stringWithFormat:TOPIC_INFO_URL,[self.iconID intValue]]];
    
    }

#pragma mark 数据请求
- (void)startRequest:(NSString *)url {
  
    [Net getHttpURL:url completation:^(id object) {
    
       _dict = object[@"data"];

        //展示数据
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20)];
        webView.scrollView.bounces = NO;
        webView.scrollView.showsVerticalScrollIndicator = NO;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_dict[@"share_url"]]]];
        [self.view addSubview:webView];
    } failure:^(NSError *error) {
        //
        NSLog(@"请求失败");
        
    }];

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
