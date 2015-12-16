//
//  CateListViewController.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "CateListViewController.h"
#import "DetailViewController.h"


@interface CateListViewController ()

@end

@implementation CateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.cateTitle;
    
    self.page = 0;
    
    [self.tableView.header beginRefreshing];
    
    
}
#pragma mark 刷新、加载
//下拉刷新
- (void)downRefresh{
    //设置网址
    NSString *url = [NSString stringWithFormat:TOPIC_CATE_URL,self.page,[self.cateID intValue]];
    //请求数据
    [self startRequest:url andTag:1];
}
// 上拉加载
- (void)upRefresh{
    
    NSString *url = [NSString stringWithFormat:TOPIC_CATE_URL,self.page++,[self.cateID intValue]];
    [self startRequest:url andTag:2];
}


#pragma mark 数据请求
- (void)startRequest:(NSString *)url andTag:(NSInteger)tag{
  [Net getHttpURL:url completation:^(id object) {
    //解析数据
      if (tag == 1) {
          [self.dataArray removeAllObjects];
          [super loadData:object];
          self.page = 1;
      }else if(tag == 2){
          [super loadData:object];
      }
      //刷新数据
      [self.tableView reloadData];
      [self.tableView.header endRefreshing];
      [self.tableView.footer endRefreshing];
      
} failure:^(NSError *error) {
      NSLog(@"请求失败");
     [self.tableView.header endRefreshing];
     [self.tableView.footer endRefreshing];
}];

}
#pragma mark tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    topicCell *cell = [tableView dequeueReusableCellWithIdentifier:topic];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"topicCell" owner:nil options:nil]lastObject];
    }
    [self customCell:cell andIndexPath:indexPath];
    return cell;
 
}

- (void)customCell:(UITableViewCell *)myCell andIndexPath:(NSIndexPath *)index{
    
    [super customCell:myCell andIndexPath:index];
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.iconID = [self.dataArray[indexPath.row] id];
    detail.hidesBottomBarWhenPushed = YES;
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
