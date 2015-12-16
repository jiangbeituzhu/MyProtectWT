//
//  PhotosViewController.m
//  FashionLife
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import "PhotosViewController.h"
#import "PictureCollectionViewCell.h"
#import "CateModel.h"
#import "CateListViewController.h"
#import "SearchViewController.h"

static NSString *pictureCell = @"PICTURE";

@interface PhotosViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *deleButton;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) NSMutableArray *resultArray;


@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.resultArray = [[NSMutableArray alloc]init];
    
    _backView.hidden = YES;
    
    //创建collectionViewCell
    [self createUI];
    //注册
    [_collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:pictureCell];
    
    self.urlStr = CATE_LIST_URL;
    
    [self startRequest:self.urlStr];
    
}

//创建collectionView
- (void)createUI{
    
    //搜索
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 50, 44)];
    _searchBar.placeholder = @"搜索感兴趣的专题或单品";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    self.navigationItem.titleView = _searchBar;
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
 
    
    UILabel *reLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    reLabel.text = @"搜索历史";
    reLabel.font = [UIFont systemFontOfSize:16.0];
    reLabel.textColor = [UIColor grayColor];
    reLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:reLabel];
    
    
    _deleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleButton.frame = CGRectMake(WIDTH - 100, 0, 100, 30);
    [_deleButton setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    [_deleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _deleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _deleButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_deleButton addTarget:self action:@selector(deleteRecords) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_deleButton];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, WIDTH, HEIGHT - 100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_backView addSubview:self.tableView];

    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
}
//清除历史
- (void)deleteRecords{
    
    [_resultArray removeAllObjects];
    [self.tableView reloadData];

}
#pragma mark searchBar相关方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.tableView reloadData];
    _collectionView.hidden = YES;
    self.backView.hidden = NO;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_resultArray addObject:searchBar.text];
    NSLog(@"%@",_resultArray);
    [self.tableView reloadData];
    
    
    SearchViewController *search = [[SearchViewController alloc]init];
    search.searchStr = _searchBar.text;
    [self.navigationController pushViewController:search animated:NO];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        _backView.hidden = YES;
        _collectionView.hidden = NO;
    }];
    
}
#pragma mark 数据请求
- (void)startRequest:(NSString *)url{
    
[Net getHttpURL:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] completation:^(id object) {
    
    NSArray *cateArray = object[@"data"];
    for (NSDictionary *subDict in cateArray) {
        CateModel *model = [[CateModel alloc]init];
        [model setValuesForKeysWithDictionary:subDict];
        [self.dataArray addObject:model];
    }
    //刷新UI
    [_collectionView reloadData];
} failure:^(NSError *error) {
    //
    NSLog(@"请求失败");
}];

}


#pragma mark collectionView相关方法
//单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pictureCell forIndexPath:indexPath];
    
    CateModel *model = self.dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    cell.topicLabel.text = model.name;
    cell.nameLabel.text = model.en_name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CateListViewController *catelist = [[CateListViewController alloc]init];
    //传值
    catelist.cateID = [self.dataArray[indexPath.row] id];
    catelist.cateTitle = [self.dataArray[indexPath.row] name];
    
    catelist.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:catelist animated:YES];
    
}

//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 80);

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark tableView相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *recordID = @"record";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordID];
    }
    cell.textLabel.text = _resultArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.imageView.image = [UIImage imageNamed:@"attach_3.png"];
    return cell;
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
