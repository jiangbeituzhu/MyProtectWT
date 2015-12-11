//
//  RootViewController.m
//  Test
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat red = 235;
    CGFloat green = 67;
    CGFloat blue = 73;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self createTableView];
    
    [self createUpdateView];
}

#pragma mark NavigationItem相关
- (void)createBarButtonLeftTitle:(NSString *)leftTitle LeftImage:(NSString *)leftImage RightTitle:(NSString *)rightTitle RightImage:(NSString *)rightImage{
    
    if (leftTitle != nil || leftImage != nil) {
        //创建左按钮
        self.navigationItem.leftBarButtonItem = [Function barButtonTitle:leftTitle Image:leftImage Target:self Sel:@selector(leftBarButtonClick:)];
        
    }
    if (rightTitle != nil || rightImage != nil){
        //创建右按钮
        self.navigationItem.rightBarButtonItem = [Function barButtonTitle:rightTitle Image:rightImage Target:self Sel:@selector(rightBarButtonClick:)];
        
    }
    
}
//左右按钮点击事件
- (void)leftBarButtonClick:(UIBarButtonItem *)left{
    
    
    
}
- (void)rightBarButtonClick:(UIBarButtonItem *)right{
    
    
}

#pragma mark - 刷新、加载
- (void)createUpdateView{
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    //上拉加载
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    _page = 1;
    
}

//刷新、加载方法实现
//下拉刷新
- (void)downRefresh{
    //<19>设置相关网址
    NSString *url = [NSString stringWithFormat:self.urlStr,1];
    //<20>请求数据
    [self startRequest:url andTag:1];
}
// 上拉加载
- (void)upRefresh{
    //<19>设置相关网址
    NSString *url = [NSString stringWithFormat:self.urlStr,_page ++];
    //<20>请求数据
    [self startRequest:url andTag:2];
}

#pragma mark - Net访问服务器
- (void)startRequest:(NSString *)url andTag:(NSInteger)tag{
    [Net getHttpURL:url completation:^(id object) {
        //解析数据
        if (tag == 1) {
            //下拉刷新
            //<a>清除之前所有的数据
            [_dataArray removeAllObjects];
            //<b>解析新的数据
            //方法
            [self loadData:object];
            //<c>更新页数
            _page = 1;
        }else if (tag == 2){
            //上拉加载
            //<a>解析数据
            [self loadData:object];
        }
        
        //<d>刷新UI
        [_tableView reloadData];
        //<e>结束刷新
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
        //<20.5>取消加载刷新
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    }];
    
}
#pragma mark - 数据解析
- (void)loadData:(id)responseObject{
    //<a>判断id的类型
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        //<b>找到数组
        NSDictionary *dict = responseObject[@"data"];
        NSArray *array = dict[@"topic"];
        for (NSDictionary *subDic in array) {
            //<c>解析小字典
            Model *model = [[Model alloc] init];
            //映射
            [model setValuesForKeysWithDictionary:subDic];
            
            //<d>添加到数据源里面
            [_dataArray addObject:model];
        }
        
    }
}

#pragma mark UITableView相关
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 , WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.tableView];
    
}

//实现tableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
#pragma mark - cell的设置

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    topicCell *cell = [tableView dequeueReusableCellWithIdentifier:topic];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"topicCell" owner:nil options:nil]lastObject];
    }
    
    [self customCell:cell andIndexPath:indexPath];
    return cell;
}

- (void)customCell:(UITableViewCell *)myCell andIndexPath:(NSIndexPath *)index{
    
    topicCell *cell = (topicCell *)myCell;
    Model *model = [self.dataArray objectAtIndex:index.row];
    
    //cell数据展示
    cell.topicTitleLable.text = model.title;
    [cell.topicImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.topicLoveLable.text = model.likes;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
