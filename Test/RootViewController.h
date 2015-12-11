//
//  RootViewController.h
//  Test
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "ViewController.h"
#import "Function.h"
#import "Header.h"
#import "Net.h"

#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "topicCell.h"
#import "Model.h"

//定义复用的id
static NSString *topic = @"TOPIC";

@interface RootViewController : ViewController<UITableViewDataSource,UITableViewDelegate>

//让子类继承
@property (nonatomic,strong)UITableView *tableView;
//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;
//页数
@property (nonatomic, assign) int            page;
//网址
@property (nonatomic,strong)NSString *urlStr;


//cellUI的数据由外部方法更新
- (void)customCell:(UITableViewCell *)myCell andIndexPath:(NSIndexPath *)index;

//<数据解析的方法>
- (void)loadData:(id)responseObject;


- (instancetype)initWithTitle:(NSString *)title tabTitle:(NSString *)tabTitle tabImage:(UIImage *)image;


//navigationItem左右按钮回调方法
- (void)createBarButtonLeftTitle:(NSString *)leftTitle LeftImage:(NSString *)leftImage RightTitle:(NSString *)rightTitle RightImage:(NSString *)rightImage;

- (void)leftBarButtonClick:(UIBarButtonItem *)left;

- (void)rightBarButtonClick:(UIBarButtonItem *)right;

//TableView相关方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
@end
