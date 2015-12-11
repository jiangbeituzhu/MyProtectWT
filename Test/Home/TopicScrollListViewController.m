//
//  TopicScrollListViewController.m
//  FashionLife
//
//  Created by yzz on 15/10/29.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "TopicScrollListViewController.h"
#import "Header.h"
#import "topicCell.h"
#import "Function.h"
#import "DetailViewController.h"

@interface TopicScrollListViewController ()

@end

@implementation TopicScrollListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.topicScrollTitle;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pay_arrowleft"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
     self.urlStr = HOME_GOOD_URL;
    
    [self.tableView.header beginRefreshing];
    
}
- (void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.iconID = [self.dataArray[indexPath.row] id];
    [self.navigationController pushViewController:detail animated:YES];

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
