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

//头视图总高度
#define HEADHEIGHT 344
//top高度
#define BANNERHEIGHT 300
//三个按钮视图高度
#define DEATILHEIGHT 65
//按钮框高度
#define BTNVIEWHEIGHT 44

@interface UserCenterViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//主滚动
@property(nonatomic, strong)UIScrollView *tableScrollView;
//三个表格
@property (nonatomic, strong)DetailTableViewController *firstTableView;
@property (nonatomic, strong)DetailTableViewController *secondTableView;

//头部banner+title
@property (nonatomic, strong) UIView *headerView;
//头部视图高度相关
@property (nonatomic, assign) CGFloat headerCenterY;
//标签栏底部的指示器
@property (nonatomic, strong) UIView *indicatorView;
//当前选中的按钮
@property (nonatomic, strong) UIButton *selectedButton;
//顶部的所有标签
@property (nonatomic, strong) UIView *titlesView;
//头视图上的控件
@property (nonatomic, strong)UIImageView *image_head;
//用户名
@property (nonatomic, strong)UILabel *lab_username;
//装用户标示的view
@property (nonatomic, strong)UIView *view_v_level;
//三个按钮框
@property (nonatomic, strong)UIView *view_btn_there;




//@property(nonatomic,strong)UITableView *tableView;
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
    //先创建最大的滚动视图
    [self creatTableScrollView];
    //头部
    [self createHeaderView];

    // Do any additional setup after loading the view.
}
-(void)CreteUI{

    
    
    
}
#pragma mark - 创建底部scrollerView
- (void)creatTableScrollView{


    //创建底部的滚动视图
    UIScrollView *tableScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    tableScrollView.pagingEnabled = YES;
    tableScrollView.delegate = self;
    tableScrollView.backgroundColor = [UIColor clearColor];
    
    self.firstTableView = [[DetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.firstTableView.tableView.frame = CGRectMake(0  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    self.firstTableView.tableView.tag = 100;
    self.firstTableView.tableView.delegate = self;
    self.firstTableView.tableView.dataSource =self;
    self.firstTableView.tableView.backgroundColor =[UIColor clearColor];
    [self createTableHeadView:self.firstTableView.tableView];
    [tableScrollView addSubview:self.firstTableView.tableView];
    self.secondTableView = [[DetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.secondTableView.tableView.frame = CGRectMake(1  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    self.secondTableView.tableView.tag = 101;
    self.secondTableView.tableView.delegate = self;
    self.secondTableView.tableView.dataSource = self;
    self.secondTableView.tableView.backgroundColor = [UIColor clearColor];
    [self createTableHeadView:self.secondTableView.tableView];
    [tableScrollView addSubview:self.secondTableView.tableView];
    
    
    self.tableScrollView = tableScrollView;
    [self.view addSubview:self.tableScrollView];

}
//添加头视图
-(void)createTableHeadView:(UITableView *)tableView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -1000, SCREEN_WIDTH, 1000)];
    topView.backgroundColor = GETMAINCOLOR;
    [tableView addSubview:topView];
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADHEIGHT)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeaderView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
}
//创建三个按钮+banner
-(void)createHeaderView{

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADHEIGHT)];
    self.headerView.backgroundColor = GETMAINCOLOR;
    self.headerCenterY = self.headerView.center.y;
    [self.view addSubview:self.headerView];

    //添加banner
    [self createbanner];
    
    self.titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, BANNERHEIGHT, SCREEN_WIDTH, BTNVIEWHEIGHT)];
    self.titlesView.layer.masksToBounds = YES;
    self.titlesView.layer.borderColor = RGB(221, 221, 221).CGColor;
    self.titlesView.layer.borderWidth= 0.5f;
    self.titlesView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.titlesView];
    
    //红色指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = GETMAINCOLOR;
    
    //内部的子标签
    NSArray *titles = @[@"商务名片", @"口碑评价" ];
    CGFloat width = SCREEN_WIDTH / titles.count;
    CGFloat height = BTNVIEWHEIGHT-2;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        button.frame = CGRectMake(i * width, 0, width, height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [button setTitleColor:GETMAINCOLOR forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            CGFloat indicatorViewW = button.titleLabel.frame.size.width;
            CGFloat indicatorViewCenterX = button.center.x;
            
            self.indicatorView.frame = CGRectMake(indicatorViewCenterX - indicatorViewW / 2, BTNVIEWHEIGHT-2, indicatorViewW, 2);
            
        }
    }
    [self.titlesView addSubview:self.indicatorView];

}
-(void)createbanner{

    self.image_head = [UIImageView new];
    self.image_head.backgroundColor = RGB(25, 138, 240);
    self.image_head.layer.masksToBounds =YES;
    self.image_head.layer.cornerRadius = 40.0f;
    
    
    
}
- (void)titleClick:(UIButton *)button
{
    //第一次要刷新
    //    UITableView *tableview = [self.view viewWithTag:100+button.tag];
    //    [tableview.mj_header beginRefreshing];
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    // 动画
    [UIView animateWithDuration:0.15 animations:^{
        CGFloat indicatorViewW = button.titleLabel.frame.size.width;
        CGFloat indicatorViewCenterX = button.center.x;
        
        self.indicatorView.frame = CGRectMake(indicatorViewCenterX - indicatorViewW / 2, BTNVIEWHEIGHT-2, indicatorViewW, 2);
    }];
    
    // 滚动
    CGPoint offset = self.tableScrollView.contentOffset;
    offset.x = button.tag * self.tableScrollView.frame.size.width;
    [self.tableScrollView setContentOffset:offset animated:YES];
}
#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y > BANNERHEIGHT) {
        self.headerView.center = CGPointMake(_headerView.center.x,  self.headerCenterY - BANNERHEIGHT);
        return;
    }
    CGFloat h = self.headerCenterY - offsetY;
    self.headerView.center = CGPointMake(self.headerView.center.x, h);
    
    //解决结束刷新时候，其他tableView同步偏移
    if (scrollView.contentOffset.y == 0) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"-------%s    ",__func__);
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self titleClick:self.titlesView.subviews[index]];
        
        return;
    }
    
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"-------%s",__func__);
    
    if ([scrollView isEqual:_tableScrollView]) {
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

//设置tableView的偏移量
-(void)setTableViewContentOffsetWithTag:(NSInteger)tag contentOffset:(CGFloat)offset{
    
    CGFloat tableViewOffset = offset;
    if(offset > BANNERHEIGHT){
        
        tableViewOffset = BANNERHEIGHT;
    }
    
    if (tag == 100) {
        
        [self.secondTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        
        
    }else if(tag == 101){
        
        [self.firstTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        
        
    }else{
        
        [self.firstTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [self.secondTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        
    }
}

#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [BBSPostTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BBSPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    if (!cell) {
        cell = [[BBSPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetSection:indexPath.section];
    cell.delegateSignal = [RACSubject subject];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYLOG(@"点击了第%ld个表格第%ld行",tableView.tag-100,(long)indexPath.section);
}




@end
