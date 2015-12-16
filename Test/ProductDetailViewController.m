//
//  ProductDetailViewController.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Header.h"
#import "Net.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
{

    NSDictionary *_dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //发起请求
    [self startRequest:[NSString stringWithFormat:PRODUCT_DETAIL_URL,[self.proTypeID intValue],[self.productID intValue]]];
    
}
- (void)startRequest:(NSString *)url {
[Net getHttpURL:url completation:^(id object) {
    //请求成功
        _dict = object[@"data"][@"product"];
        [self createWebView];
    
} failure:^(NSError *error) {
    
    //
    NSLog(@"请求失败");
}];
}
//webView创建
- (void)createWebView{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20)];
    web.scrollView.bounces = NO;
    web.scrollView.showsVerticalScrollIndicator = NO;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_dict[@"share_url"]]]];
    [self.view addSubview:web];
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
