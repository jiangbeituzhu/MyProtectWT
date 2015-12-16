//
//  SearchViewController.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "SearchViewController.h"
#import "SDWebImageDecoder.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "Header.h"
#import "ProductCollectionViewCell.h"
#import "SubjectCell.h"
#import "Net.h"
#import "ProductModel.h"
#import "ProductDetailViewController.h"
#import "DetailViewController.h"

static NSString *proCellID = @"PRODUCT";
static NSString *subCellID = @"SUBJECT";

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *subjectArray;

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIButton *productButton;
@property (nonatomic,strong) UIButton *topicButton;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.subjectArray = [[NSMutableArray alloc]init];
    
    [self createUI];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:proCellID];
    
    self.productUrl = [NSString stringWithFormat:SEARCH_PRODUCT_URL,self.searchStr];
    
    [self startRequest:self.productUrl andTag:1];
    [self startRequest:self.productUrl andTag:2];
    
}
- (void)createUI{
    //搜索框
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,WIDTH - 50, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.text = self.searchStr;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.navigationItem.titleView = _searchBar;
    
    //展示数据的框架UI
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, HEIGHT - 100 - 49)];
    _scrollView.tag = 30;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_scrollView];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 100 - 49) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
   [_scrollView addSubview:_collectionView];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH,0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_tableView];
    
    //按钮和红线的创建
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 30)];
    [self.view addSubview:backView];
    
    CGFloat btnW = 80;
    CGFloat btnH = 30;
    
    _productButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _productButton.frame = CGRectMake(50, 0, btnW, btnH);
    _productButton.tag = 10;
    [_productButton setTitle:@"单品" forState:UIControlStateNormal];
    //_productButton.titleLabel.font = [UIFont systemFontOfSize:15.0];可设置button上字体大小
    [_productButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_productButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_productButton];
    
    _topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _topicButton.frame = CGRectMake(180 + 50, 0, btnW, btnH);
    _topicButton.tag = 20;
    [_topicButton setTitle:@"专题" forState:UIControlStateNormal];
    [_topicButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [_topicButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_topicButton];
    
    //50间距
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(50, 95,btnW, 2)];
    _lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineView];
    

    
}
#pragma mark 数据请求
- (void)startRequest:(NSString *)url andTag:(NSInteger)tag{
[Net getHttpURL:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] completation:^(id object) {
    //
    NSDictionary *dict = object[@"data"];
    if (tag == 1) {
        NSArray *proArray = dict[@"product"];
        for (NSDictionary *subDic in proArray) {
            ProductModel *model = [[ProductModel alloc]init];
            [model setValuesForKeysWithDictionary:subDic];
            [_dataArray addObject:model];
        }
        
        [_collectionView reloadData];
       
    }else if(tag == 2){
        NSArray *subArray = dict[@"topic"];
        for (NSDictionary *subDict in subArray) {
            ProductModel *model = [[ProductModel alloc]init];
            [model setValuesForKeysWithDictionary:subDict];
            [_subjectArray addObject:model];
        }
        [_tableView reloadData];
    }
    
} failure:^(NSError *error) {
    //
    NSLog(@"请求失败");
}];

    self.scrollView.contentSize = CGSizeMake(WIDTH * 2, self.dataArray.count * 200);
}

#pragma mark searchBar相关
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    
}

#pragma mark 单品、专题按钮点击事件
//改变展示数据的位置
- (void)onClick:(UIButton *)button{
    
    switch (button.tag) {
         case 10:
            _scrollView.contentOffset = CGPointMake(0, 0);
            [self setButtonColor];
            break;
         case 20:
            _scrollView.contentOffset = CGPointMake(WIDTH, 0);
            [self setChangeButtonColor];
            
        default:
            break;
    }
    
}

#pragma mark scrollView相关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag == 30) {
        CGFloat x = scrollView.contentOffset.x/WIDTH * 180;
        _lineView.frame = CGRectMake(50 + x, 95, 80, 2);
    }
    if (scrollView.contentOffset.x / WIDTH == 0) {
        [self setButtonColor];
    }else{
        [self setChangeButtonColor];
    }
}

//按钮、红线位置改变，字体颜色变化方法实现
- (void)setButtonColor{
    [_productButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_topicButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
- (void)setChangeButtonColor{
    [_topicButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_productButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
#pragma mark collectionView相关
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:proCellID forIndexPath:indexPath];
    
    //展示数据
    ProductModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",model.price];
    [cell.proImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    return cell;
}

//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(160, 160);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *proDetail = [[ProductDetailViewController alloc]init];
    proDetail.productID = [_dataArray[indexPath.row] id];
    proDetail.proTypeID = [_dataArray[indexPath.row] type_id];
    proDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:proDetail animated:YES];

}
#pragma mark tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _subjectArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:subCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SubjectCell" owner:nil options:nil]lastObject];
    }
    
    //tableView数据
    ProductModel *model = self.subjectArray[indexPath.row];
    cell.subTitleLabel.text = model.title;
    [cell.subImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.iconID = [_subjectArray[indexPath.row] id];
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
