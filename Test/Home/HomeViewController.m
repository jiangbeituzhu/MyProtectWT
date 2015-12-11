//
//  HomeViewController.m
//  FashionLife
//
//  Created by yzz on 15/10/26.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "HomeViewController.h"
#import "topicCell.h"
#import "Header.h"
#import "Net.h"
#import "GoodDetailViewController.h"
#import "TopicScrollListViewController.h"
#import "DetailViewController.h"
//#import "MineViewController.h"
//#import "PhotosViewController.h"


@interface HomeViewController ()<UIScrollViewDelegate>

@end

@implementation HomeViewController
{
    UIScrollView   *_homeScrollView;
    UIScrollView   *_goodScrollView;
    UIPageControl  *_pageControl;
    NSMutableArray *_tempArrayScorll;
    NSMutableArray *_tempArrayGood;
    NSTimer        *_timer;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self createBarButtonLeftTitle:@"分类" LeftImage:nil RightTitle:@"关注" RightImage:nil];
    
     self.page = 0;
    
    [self.tableView.header beginRefreshing];
    
}
#pragma mark - 刷新、加载
- (void)downRefresh{
    
    [_timer invalidate];
    
    _tempArrayScorll = [[NSMutableArray alloc]init];
    
    _tempArrayGood = [[NSMutableArray alloc]init];
    
    self.page = 0;
    
    [self startRequest:HOME_SCROll_URL andTag:2];
    
    [self startRequest:[NSString stringWithFormat:HOME_GOOD_URL,0] andTag:3];
    
    [self startRequest:[NSString stringWithFormat:HOME_GOOD_URL,self.page] andTag:1];
}

- (void)upRefresh{
    NSString *url = [NSString stringWithFormat:HOME_GOOD_URL,++self.page];
    [self startRequest:url andTag:1];
}
#pragma mark - 数据请求
- (void)startRequest:(NSString *)url andTag:(NSInteger)tag{
    [Net getHttpURL:url completation:^(id object) {
        if (tag == 1) {
            //cell列表上数据
            if (self.page == 0) {
                [self.dataArray removeAllObjects];
            }
            
            [super loadData:object];
            [self.tableView reloadData];
            
            
        }else if (tag == 2){
            //row = 0 scroll数据
            [self loadDataForScroll:object];
            
        }else if (tag == 3){
           //row = 0 good数据
            [self loadDataForGood:object];
        }
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}


#pragma mark - 数据解析 - 精选好物
- (void)loadDataForGood:(id)responseObject{
    NSDictionary *dict = responseObject[@"data"];
    NSArray *array = dict[@"entry_list"];
    
    for (NSDictionary *subDict in array) {
        Model *model = [[Model alloc]init];
        [model setValuesForKeysWithDictionary:subDict];
        [_tempArrayGood addObject:model];
    }
    
    for (int i = 0; i < _tempArrayGood.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * (80 + 10),5, 80, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_tempArrayGood[i] pic1]]];
        
        imageView.tag = 2000 + i;
        imageView.userInteractionEnabled = YES;
        [_goodScrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGoodWebView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];
        
    }
    
    _goodScrollView.contentSize = CGSizeMake((80 + 10) * array.count - 10, 100);
    
}
//添加手势回调进入本期话题
- (void)tapGoodWebView:(UITapGestureRecognizer *)tap{
    
   // NSLog(@"%lu",tap.view.tag);
    GoodDetailViewController *good = [[GoodDetailViewController alloc]init];
    good.goodUrl = [_tempArrayGood[tap.view.tag - 2000] share_url];
    good.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:good animated:YES];
    
}

#pragma mark - 数据解析- 主题scroll
- (void)loadDataForScroll:(id)responseObject{
    NSDictionary *dict = responseObject[@"data"];
    NSArray *array = dict[@"banner"];
    for (NSDictionary *subDict in array) {
        Model *model = [[Model alloc]init];
        [model setValuesForKeysWithDictionary:subDict];
        [_tempArrayScorll addObject:model];
    }
    
    //scrollView上数据
    UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, WIDTH, 150)];
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:[[_tempArrayScorll lastObject] photo]]];
    [_homeScrollView addSubview:lastImageView];
    
    for (int i = 0; i < _tempArrayScorll.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, 150)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[_tempArrayScorll objectAtIndex:i] photo]]];
         imageView.userInteractionEnabled = YES;
        imageView.tag = 1000 + i;
        [_homeScrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollWebView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];

    }
    
    UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_tempArrayScorll.count + 1) * WIDTH , 0, WIDTH, 150)];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:[[_tempArrayScorll firstObject] photo]]];
    [_homeScrollView addSubview:firstImageView];
    
    _homeScrollView.contentSize = CGSizeMake(WIDTH * (_tempArrayScorll.count + 2), 150);
    _pageControl.numberOfPages = [_tempArrayScorll count];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeControl) userInfo:nil repeats:YES];
  
}
- (void)tapScrollWebView:(UITapGestureRecognizer *)tap{
    TopicScrollListViewController *topic = [[TopicScrollListViewController alloc]init];
    topic.topicScrollTitle = [_tempArrayScorll[tap.view.tag - 1000] title];
    topic.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topic animated:YES];

}
#pragma mark - ScrollView的UI创建
- (void)createScrollView:(UITableViewCell *)cell{
    // _homeScrollView创建
    _homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    _homeScrollView.delegate = self;
    _homeScrollView.showsHorizontalScrollIndicator = NO;
    _homeScrollView.showsVerticalScrollIndicator = NO;
    _homeScrollView.bounces = NO;
    _homeScrollView.pagingEnabled = YES;
    _homeScrollView.contentOffset = CGPointMake(WIDTH, 0);
    [cell.contentView addSubview:_homeScrollView];
    
    //_goodScrollView创建
    _goodScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150 + 10 , WIDTH, 100 )];
    _goodScrollView.pagingEnabled = YES;
    _goodScrollView.bounces = NO;
    _goodScrollView.showsHorizontalScrollIndicator = NO;
    _goodScrollView.showsVerticalScrollIndicator = NO;
    _goodScrollView.contentOffset = CGPointMake(80, 0);
    [cell.contentView addSubview:_goodScrollView];
    
    //_pageControl创建
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 120, 100, 30)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:_pageControl];
    
    
}

//实现scrollView上图片循环滚动
- (void)timeControl{
    int i = _homeScrollView.contentOffset.x / WIDTH;
    if (i == 0 || i == _tempArrayScorll.count) {
    
        if (i == 0) {
            
            i = (int)_tempArrayScorll.count;
            
        }else{
            i = 0;
            _pageControl.currentPage = 0;
        }
        _homeScrollView.contentOffset = CGPointMake(i * WIDTH, 0);
    }else{
        _pageControl.currentPage ++;
    }
    
        [UIView animateWithDuration:0.5 animations:^{
        _homeScrollView.contentOffset = CGPointMake( _homeScrollView.contentOffset.x+WIDTH, 0);
    }];
    
}

- (void)pageControlClick:(UIPageControl *)pageControl{
    NSInteger i = pageControl.currentPage;
    [UIView animateWithDuration:0.5 animations:^{
        _homeScrollView.contentOffset = CGPointMake((i + 1) * WIDTH, 0);
    }];
}

#pragma mark - 左右按钮点击事件
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

#pragma mark - tableView相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataArray.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       //设置每个Section中每个row的数据
    
    if (indexPath.row == 0) {
        
        UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headercell"];
        if (headerCell == nil) {
            headerCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headercell"];
            [self createScrollView:headerCell];
            headerCell.backgroundColor = [UIColor blackColor];
        }
        
        return headerCell;
        
    }
    
    
    topicCell *cell = [tableView dequeueReusableCellWithIdentifier:topic];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"topicCell" owner:nil options:nil]lastObject];
    }
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row - 1];
    //cell数据展示
    cell.topicTitleLable.text = model.title;
    [cell.topicImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.topicLoveLable.text = model.likes;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   

}

//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailViewController *detail = [[DetailViewController alloc]init];
     detail.hidesBottomBarWhenPushed = YES;
     detail.iconID = [self.dataArray[indexPath.row - 1] id];
    
    [self.navigationController pushViewController:detail animated:YES];
    

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 150 + 100 + 10;
    }
    return 130;
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
