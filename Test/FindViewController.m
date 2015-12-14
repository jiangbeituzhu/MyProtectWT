//
//  FindViewController.m
//  Test
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "FindViewController.h"
#import "Header.h"
#import "SelectCell.h"
#import "FindModel.h"
//#import "MineViewController.h"
//#import "PhotosViewController.h"

static NSString *selectId = @"SELECT";

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBarButtonLeftTitle:@"分类" LeftImage:nil RightTitle:@"个人" RightImage:nil];
    
    [self.tableView.header beginRefreshing];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.urlStr = FIND_GOOD_URL;
    
    [self startRequest:self.urlStr];
}

#pragma mark 按钮点击事件
- (void)leftBarButtonClick:(UIBarButtonItem *)left{
//    PhotosViewController *search = [[PhotosViewController alloc]init];
//    self.tabBarController.selectedIndex = 2;
//    [self.navigationController pushViewController:search animated:YES];
    
}
- (void)rightBarButtonClick:(UIBarButtonItem *)right{
    
//    MineViewController *mine = [[MineViewController alloc]init];
//    self.tabBarController.selectedIndex = 3;
//    [self.navigationController pushViewController:mine animated:YES];
}


#pragma mark 数据请求
- (void)startRequest:(NSString *)url {
    [Net getHttpURL:url completation:^(id object) {
        //请求成功
        [self loadData:object];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        //请求失败
        NSLog(@"请求失败");
        
    }];
    
}

- (void)loadData:(id)responseObject{
    
    NSDictionary *dict = responseObject[@"data"];
    NSArray *listArray = dict[@"list"];
    for (NSDictionary *subDict in listArray) {
        
        FindModel *model = [[FindModel alloc]init];
        model.name = subDict[@"author"][@"nickname"];
        model.content = subDict[@"content"];
        model.datestr = subDict[@"datestr"];
        model.likes = subDict[@"dynamic"][@"likes"];
        model.tags = subDict[@"tags"];
        model.share_url = subDict[@"share_url"];
        model.picUrl = [subDict[@"pics"]firstObject][@"url"];
        model.icon = subDict[@"author"][@"avatar"];
        
        [self.dataArray addObject:model];
        
    }
    
}

#pragma mark tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:selectId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:nil options:nil]lastObject];
    }
    
    //展示数据
    FindModel *model = self.dataArray[indexPath.row];
    
    cell.titleLable.text = model.name;
    cell.descLable.text = model.content;
    cell.timeLable.text = model.datestr;
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    NSMutableString *typeStr = [[NSMutableString alloc]init];
    for (int i = 0; i < model.tags.count; i++) {
        [typeStr appendFormat:@"%@  ",model.tags[i][@"name"]];
    }
    cell.typeLable.text = typeStr;
    
    //取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
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
