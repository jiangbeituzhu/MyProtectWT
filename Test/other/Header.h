//
//  Header.h
//  Test
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#ifndef FashionLife_Header_h
#define FashionLife_Header_h

//定义屏幕的宽高
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ROW_HEIGHT 100


//控制器数组、图片数组、标题数组
#define VC_ARRAY @[@"HomeViewController", @"FindViewController", @"PhotosViewController", @"MineViewController"]

#define NAVIGATION_TITLE @[@"时尚生活",@"发现",@" ",@"个人中心"]

#define TABBAR_TITLE @[@"首页",@"发现",@"搜索 ",@"个人中心"]
//tabar的非选中图片
//#define TABBAR_IMAGE @[@"tabbar_home",@"icon_hot",@"tabbar_brand",@"icon_my"]

#define TABBAR_IMAGE @[@"tabbar_home",@"tabbar_discover",@"tabbar_brand",@"icon_my"]


#define MY_CELL_TITLE @[@"设置",@"帮助中心",@"分享应用给好友",@"意见反馈"]
#define MY_CELL_IMAGE @[@"",@"",@"",@""]

//定义是否为第一次启动的宏   1  代表不是  无值  代表第一次
#define FIRST_START @"first_start"

//网络数据接口

//专题 topic_list
#define HOME_SCROll_URL @"http://open4.bantangapp.com/topic/list?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&oauth_token=&screensize=1080&page=0&pagesize=20&ids=1275%2C1049%2C1045%2C564%2C380"

//精选好物
#define HOME_GOOD_URL @"http://open4.bantangapp.com/recommend/index?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&oauth_token=&screensize=1080&page=%d&pagesize=20&category="
//专题详情
#define TOPIC_INFO_URL @"http://open4.bantangapp.com/topic/info?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&id=%d&statistics_uv=1"
//精选发现
#define FIND_GOOD_URL  @"http://open4.bantangapp.com/community/post/editorRec?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&page=0&pagesize=10"
//用户推荐
#define FIND_LISTPOST_URL @"http://open4.bantangapp.com/community/subject/listPost?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.3&os_versions=4.4.4&screensize=1080&v=7&page=0&pagesize=10&subject_id=68&type_id=0"
//专题分类
#define TOPIC_CATE_URL @"http://open4.bantangapp.com/topic/list?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&oauth_token=&screensize=1080&page=%d&pagesize=20&category=%d&update_time="
//搜索专题列表
#define CATE_LIST_URL @"http://open4.bantangapp.com/category/list?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7"
//搜索单品
#define SEARCH_PRODUCT_URL @"http://open4.bantangapp.com/base/search/initData?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.3&os_versions=4.4.4&screensize=1080&v=7&keyword=%@"
//单品列表
#define PRODUCT_LIST_URL @"http://open4.bantangapp.com/product/list?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.2.2&os_versions=4.4.4&screensize=1080&v=7&page=0&pagesize=20&category=2"
//单品详情
#define PRODUCT_DETAIL_URL @"http://open4.bantangapp.com/comm/comments/list?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866963023048566&track_device_info=MI+4LTE&channel_name=xiaomi&app_installtime=1445424918695&app_versions=4.3&os_versions=4.4.4&screensize=1080&v=7&type_id=%d&object_id=%d&page=0&pagesize=10"


#endif
