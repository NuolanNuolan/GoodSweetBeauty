//
//  UserCenterViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/16.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "UserCenterViewController.h"
#import "DetailTableViewController.h"
#import "KIZNavBarGradientBehavior.h"
#import "KIZParallaxHeaderBehavior.h"
#import "KIZMultipleProxyBehavior.h"
#import "BBSPostTableViewCell.h"
#import "UserCenterDeatilViewController.h"

//头视图总高度
#define HEADHEIGHT 235
//三个按钮视图高度
#define DEATILHEIGHT 65
//按钮框高度
#define BTNVIEWHEIGHT 44




@interface UserCenterViewController ()<HHHorizontalPagingViewDelegate>

@property (nonatomic, strong) HHHorizontalPagingView *pagingView;

//头像
@property(nonatomic,strong)UIImageView *image_head;
//username
@property(nonatomic,strong)UILabel *lab_username;
//装v和level的view
@property(nonatomic,strong)UIView *view_v_level;
//v
@property(nonatomic,strong)UIImageView *image_v;
//level
@property(nonatomic,strong)UIImageView *image_level;
//按钮view+缝隙view
@property(nonatomic,strong)UIView *view_btn_gap;
//三个lab
@property(nonatomic,strong)UILabel *lab_detail;

@end

@implementation UserCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated{

    
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreteUI];


    // Do any additional setup after loading the view.
}
-(void)CreteUI{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.pagingView reload];
    
    
}
#pragma mark -  HHHorizontalPagingViewDelegate
// 下方左右滑UIScrollView设置
- (NSInteger)numberOfSectionsInPagingView:(HHHorizontalPagingView *)pagingView {
    return 2;
}

- (UIScrollView *)pagingView:(HHHorizontalPagingView *)pagingView viewAtIndex:(NSInteger)index{
    UserCenterDeatilViewController *vc = [[UserCenterDeatilViewController alloc] init];
    [self addChildViewController:vc];
    vc.index = index;
    return (UIScrollView *)vc.view;
}

//headerView 设置
- (CGFloat)headerHeightInPagingView:(HHHorizontalPagingView *)pagingView {
    return HEADHEIGHT;
}

- (UIView *)headerViewInPagingView:(HHHorizontalPagingView *)pagingView {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = GETMAINCOLOR;
    self.image_head = [UIImageView new];
    self.image_head.layer.masksToBounds =YES;
    self.image_head.layer.cornerRadius =40.0F;
    self.image_head.backgroundColor = [UIColor grayColor];
    
    self.lab_username = [UILabel new];
    [self.lab_username setTextColor:[UIColor whiteColor]];
    [self.lab_username setFont:[UIFont boldSystemFontOfSize:16]];
    [self.lab_username setText:@"换个字试试"];
    [self.lab_username sizeToFit];
    
    self.view_v_level = [UIView new];
    self.view_v_level.backgroundColor = RGB(247, 247, 247);
    self.view_v_level.layer.masksToBounds =YES;
    self.view_v_level.layer.cornerRadius =8;
    
    self.image_v = [UIImageView new];
    self.image_v.image = [UIImage imageNamed:@"iconVBlue"];
    
    self.image_level = [UIImageView new];
    self.image_level.image = [UIImage imageNamed:@"iconLv2"];
    
    self.view_btn_gap = [UIView new];
    self.view_btn_gap.backgroundColor = [UIColor yellowColor];
    
    NSArray *arr = [NSArray arrayWithObjects:@"关注",@"粉丝",@"帖子", nil];
    for (int i =0; i<arr.count; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGMAKE(SCREEN_WIDTH/3*i, 0, SCREEN_WIDTH/3, 65)];
        view.backgroundColor = [UIColor whiteColor];
        
        self.lab_detail = [UILabel new];
        [self.lab_detail setTextColor:RGB(51, 51, 51)];
        [self.lab_detail setFont:[UIFont systemFontOfSize:18]];
        [self.lab_detail sizeToFit];
        [self.lab_detail setText:@"11"];
        
        UILabel *lab = [UILabel new];
        [lab setTextColor:RGB(102, 102, 102)];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab sizeToFit];
        [lab setText:arr[i]];
        
        
        
        [view addSubview:self.lab_detail];
        [view addSubview:lab];
        [self.view_btn_gap addSubview:view];

        
        self.lab_detail.whc_TopSpace(15).whc_CenterX(0).whc_Height(13);
        lab.whc_TopSpaceToView(10,self.lab_detail).whc_CenterX(0);
    }
    UIView *view_gap = [[UIView alloc]initWithFrame:CGMAKE(0, 65, SCREEN_WIDTH, 10)];
    view_gap.backgroundColor = RGB(247, 247, 247);
    [self.view_btn_gap addSubview:view_gap];
    
    
    
    [self.view_v_level addSubview:self.image_v];
    [self.view_v_level addSubview:self.image_level];
    [headerView addSubview:self.image_head];
    [headerView addSubview:self.lab_username];
    [headerView addSubview:self.view_v_level];
    [headerView addSubview:self.view_btn_gap];
    
    self.image_head.whc_Size(80,80).whc_CenterX(0).whc_TopSpace(5);
    self.lab_username.whc_TopSpaceToView(15,self.image_head).whc_CenterX(0).whc_Height(16);
    self.image_v.whc_Size(11,9).whc_TopSpace(3.5).whc_LeftSpace(7);
    self.image_level.whc_Size(12,11).whc_TopSpace(2.5).whc_RightSpace(7.5);
    self.view_v_level.whc_Size(42,16).whc_LeftSpaceToView(5,self.lab_username).whc_TopSpaceEqualView(self.lab_username);
    
    self.view_btn_gap.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(45,self.lab_username).whc_Height(65);
    
    return headerView;
}

//segmentButtons
- (CGFloat)segmentHeightInPagingView:(HHHorizontalPagingView *)pagingView {
    
    return BTNVIEWHEIGHT;
}

- (NSArray<UIButton*> *)segmentButtonsInPagingView:(HHHorizontalPagingView *)pagingView {
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    //内部的子标签
    NSArray *titles = @[@"商务名片", @"口碑评价"];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [button setTitleColor:GETMAINCOLOR forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [buttonArray addObject:button];
    }
    return [buttonArray copy];
}

// 点击segment
- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelected:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    MYLOG(@"%s",__func__);

}

- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelectedSameItem:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    MYLOG(@"%s",__func__);
    
}

// 视图切换完成时调用
- (void)pagingView:(HHHorizontalPagingView*)pagingView didSwitchIndex:(NSInteger)aIndex to:(NSInteger)toIndex{
    MYLOG(@"%s \n %tu  to  %tu",__func__,aIndex,toIndex);
}

- (void)pagingView:(HHHorizontalPagingView *)pagingView scrollTopOffset:(CGFloat)offset {
    
    
}

#pragma mark - 懒加载
- (HHHorizontalPagingView *)pagingView {
    if (!_pagingView) {
        
        _pagingView = [[HHHorizontalPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) delegate:self];
        _pagingView.segmentTopSpace = 0;
        _pagingView.segmentView.backgroundColor = [UIColor whiteColor];
        _pagingView.maxCacheCout = 1;
        _pagingView.isGesturesSimulate = YES;
        [self.view addSubview:_pagingView];
    }
    return _pagingView;
}


@end
