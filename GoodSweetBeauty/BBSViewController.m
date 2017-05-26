//
//  BBSViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSPostTableViewCell.h"
#import "DetailTableViewController.h"
#import "UserCenterViewController.h"
#import "YouAnBBSModel.h"



//头视图总高度
#define HEADHEIGHT 207
//banner高度
#define BANNERHEIGHT 163
//按钮框高度
#define BTNVIEWHEIGHT 44

@interface BBSViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
//主滚动
@property(nonatomic, strong)UIScrollView *tableScrollView;
//三个表格 预留一个Controller
@property (nonatomic, strong)DetailTableViewController *firstTableView;
@property (nonatomic, strong)DetailTableViewController *secondTableView;
@property (nonatomic, strong)DetailTableViewController *thirdTableView;
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
//banner
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

//判断第一次刷新标识
@property (nonatomic, assign) NSInteger OneRefresh_count;
@property (nonatomic, assign) NSInteger OneRefresh_lastrefresh;

//三个表格的page  数据
@property(nonatomic,assign) NSInteger page_back;
@property(nonatomic,assign) NSInteger page_new;
@property(nonatomic,assign) NSInteger page_goods;

@property(nonatomic,strong) NSMutableArray *Arr_back;
@property(nonatomic,strong) NSMutableArray *Arr_new;
@property(nonatomic,strong) NSMutableArray *Arr_goods;

@property(nonatomic,strong)YouAnBBSModel *Bbsmodel;






@end

@implementation BBSViewController
-(void)viewWillAppear:(BOOL)animated{

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self InitData];
    //先创建最大的滚动视图
    [self creatTableScrollView];
    //头部
    [self createHeaderView];
    
    [self CreateUI];

    
    
}
//初始化数据
-(void)InitData{

    self.OneRefresh_count = 0;
    self.page_new = 1;
    self.page_back = 1;
    self.page_goods = 1;
    self.Arr_new = [NSMutableArray arrayWithCapacity:0];
    self.Arr_back = [NSMutableArray arrayWithCapacity:0];
    self.Arr_goods = [NSMutableArray arrayWithCapacity:0];
    
    
}
//加载数据 传入三种状态
-(void)LoadData:(NSInteger )type withpage:(NSInteger )page withtableview:(UITableView *)tableview{

    @weakify(self);
    [HttpEngine BBSGetPost:type withpage:page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
        if (success) {
            
            [self ProcessTheData:tableview withdata:responseObject withpage:page];
            
        }else{
        
            
        }
        
    }];
}
//数据处理
-(void)ProcessTheData:(UITableView * )tableview withdata:(id )responseObject withpage:(NSInteger )page{
    NSArray *arr = responseObject;
    if (arr.count<10) {
        
        [tableview.mj_footer endRefreshingWithNoMoreData];
    }
    switch (tableview.tag) {
        case 100:{
            
            if (page==1) {
                
                [self.Arr_back removeAllObjects];
            }
            for (NSDictionary *dic in arr) {
                
                self.Bbsmodel = [YouAnBBSModel whc_ModelWithJson:dic];
                [self.Arr_back addObject:self.Bbsmodel];
            }
        }
            break;
        case 101:{
            if (page==1) {
                
                [self.Arr_new removeAllObjects];
            }
            for (NSDictionary *dic in responseObject) {
                
                self.Bbsmodel = [YouAnBBSModel whc_ModelWithJson:dic];
                [self.Arr_new addObject:self.Bbsmodel];
            }
            
        }
            break;
        case 102:{
            if (page==1) {
                
                [self.Arr_goods removeAllObjects];
            }
            for (NSDictionary *dic in responseObject) {
                
                self.Bbsmodel = [YouAnBBSModel whc_ModelWithJson:dic];
                [self.Arr_goods addObject:self.Bbsmodel];
            }
            
        }
            break;
    }
    [tableview reloadData];
}
-(void)CreateUI{
    
    self.navigationItem.title = @"有安";
    self.view.backgroundColor = RGB(247, 247, 247);
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconTitlebarSearch"] style:UIBarButtonItemStyleDone target:self action:@selector(PushSearch)];
    self.navigationItem.rightBarButtonItem = btn_right;
    //创建发帖按钮
    UIButton *btn_post = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_post setBackgroundImage:[UIImage imageNamed:@"iconFixedEdit"] forState:UIControlStateNormal];
    btn_post.adjustsImageWhenHighlighted = NO;
    [btn_post addTarget:self action:@selector(Btn_Posting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_post];
    btn_post.whc_RightSpace(15).whc_BottomSpace(75).whc_Size(50,50);
    
}
#pragma mark - 创建底部scrollerView
- (void)creatTableScrollView{

    //创建底部的滚动视图
    UIScrollView *tableScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    tableScrollView.pagingEnabled = YES;
    tableScrollView.delegate = self;
    tableScrollView.backgroundColor = [UIColor clearColor];
    
    self.firstTableView = [[DetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.firstTableView.tableView.frame = CGRectMake(0  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    self.firstTableView.tableView.tag = 100;
    self.firstTableView.tableView.delegate = self;
    self.firstTableView.tableView.dataSource =self;
    self.firstTableView.tableView.backgroundColor =[UIColor clearColor];
    [self createTableHeadView:self.firstTableView.tableView];
    [tableScrollView addSubview:self.firstTableView.tableView];
    @weakify(self);
    self.firstTableView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.firstTableView.tableView.tag-100 withpage:1 withtableview:self.firstTableView.tableView];

    }];
    self.firstTableView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.firstTableView.tableView.tag-100 withpage:self.page_back++ withtableview:self.firstTableView.tableView];
    }];

    
    
    self.secondTableView = [[DetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.secondTableView.tableView.frame = CGRectMake(1  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    self.secondTableView.tableView.tag = 101;
    self.secondTableView.tableView.delegate = self;
    self.secondTableView.tableView.dataSource = self;
    self.secondTableView.tableView.backgroundColor = [UIColor clearColor];
    [self createTableHeadView:self.secondTableView.tableView];
    [tableScrollView addSubview:self.secondTableView.tableView];
    self.secondTableView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.secondTableView.tableView.tag-100 withpage:1 withtableview:self.secondTableView.tableView];
        
    }];
    self.secondTableView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.secondTableView.tableView.tag-100 withpage:self.page_new++ withtableview:self.secondTableView.tableView];
    }];
    
    //---
    self.thirdTableView = [[DetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.thirdTableView.tableView.frame = CGRectMake(2  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    self.thirdTableView.tableView.tag = 102;
    self.thirdTableView.tableView.delegate = self;
    self.thirdTableView.tableView.dataSource =self;
    self.thirdTableView.tableView.backgroundColor = [UIColor clearColor];
    [self createTableHeadView:self.thirdTableView.tableView];
    [tableScrollView addSubview:self.thirdTableView.tableView];
    self.thirdTableView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.thirdTableView.tableView.tag-100 withpage:1 withtableview:self.thirdTableView.tableView];
        
    }];
    self.thirdTableView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:self.thirdTableView.tableView.tag-100 withpage:self.page_goods++ withtableview:self.thirdTableView.tableView];
    }];
    self.tableScrollView = tableScrollView;
    [self.view addSubview:self.tableScrollView];
}
//添加头视图
-(void)createTableHeadView:(UITableView *)tableView{
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADHEIGHT)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeaderView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[BBSPostTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
//    @weakify(self);
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        
//        [self LoadData:tableView.tag-100 withpage:1 withtableview:tableView];
//        
//        
//        
//    }];
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        @strongify(self);
//        NSInteger page = 0;
//        switch (tableView.tag) {
//            case 100:
//               page = ++self.page_back;
//                break;
//            case 101:
//               page = ++self.page_new;
//                break;
//            case 102:
//               page = ++self.page_goods;
//                break;
//        }
//        
//        [self LoadData:tableView.tag-100 withpage:page withtableview:tableView];
//        
//        
//    }];
}
//创建三个按钮+banner
-(void)createHeaderView{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADHEIGHT)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.headerCenterY = self.headerView.center.y;
    self.headerView.userInteractionEnabled =YES;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleSwipe:)];
    [self.headerView addGestureRecognizer:recognizer];
    
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
    self.indicatorView.userInteractionEnabled=YES;
    self.indicatorView.backgroundColor = GETMAINCOLOR;
    
    //内部的子标签
    NSArray *titles = @[@"最新回复", @"最新帖子" ,@"精品帖子"];
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
            //第一次要刷新
            UITableView *tableview = [self.view viewWithTag:100+i];
            [tableview.mj_header beginRefreshing];
            
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
-(void)handleSwipe:(UIPanGestureRecognizer *)swipe{

    MYLOG(@"啦啦啦啦啦啦啦啦领取%ld",(long)swipe.state);
    
    if (swipe.state == 2) {
        
        [self commitTranslation:[swipe translationInView:self.headerView]];
        
    }else if(swipe.state == 3){
        
        if (self.firstTableView.tableView.mj_offsetY<0) {
            
            [self.firstTableView.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    } 
}
- (void)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs (translation.x);
    CGFloat absY = fabs(translation.y);
    // 设置滑动有效距离
    if (MAX(absX, absY) >= 200)
        return;
    if (absY > absX) {
     
        if (translation.y<0) {
            //向上滑动
            MYLOG(@"上   %f",translation.y);
//            [self.firstTableView.tableView setContentOffset:CGPointMake(0,- translation.y-self.OFFset) animated:NO];
//            self.OFFset = -translation.y;
        }else{
            
            //向下滑动
            MYLOG(@"下  %f",translation.y);
            if (translation.y>=200) return;
//            [self.firstTableView.tableView setContentOffset:CGPointMake(0, -translation.y/2) animated:NO];
            self.firstTableView.tableView.contentOffset = CGPointMake(0, -translation.y/2);
            
        }
    }
    
    
}
-(void)createbanner{

    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    NSArray *titles = @[@"我是预览文字",
                        @"我是预览文字",
                        @"我是预览文字",
                        @"我是预览文字"
                        ];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 163) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    self.cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:16];
    self.cycleScrollView.titleLabelHeight = 50;
    self.cycleScrollView.userInteractionEnabled=YES;
    self.cycleScrollView.pageControlBottomOffset = 10;
    self.cycleScrollView.pageControlRightOffset = 2;
    self.cycleScrollView.delegate =self;
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.cycleScrollView.titlesGroup = titles;
    [self.headerView addSubview:self.cycleScrollView];
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    MYLOG(@"%ld",(long)index);
}
- (void)titleClick:(UIButton *)button
{
    
    //第一次要刷新
    UITableView *tableview = [self.view viewWithTag:100+button.tag];
    if (self.OneRefresh_count<2&&button.tag!=0&&self.OneRefresh_lastrefresh!=button.tag) {
        
        
        [tableview.mj_header beginRefreshing];
        self.OneRefresh_count++;
        self.OneRefresh_lastrefresh = button.tag;
    }
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
    
    [tableview reloadData];
    
}
#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    MYLOG(@"%f",offsetY);
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
    MYLOG(@"-------%s    ",__func__);
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self titleClick:self.titlesView.subviews[index]];
        
        return;
    }
    
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    MYLOG(@"-------%s",__func__);
    
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
        [self.thirdTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        
    }else if(tag == 101){
        
        [self.firstTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [self.thirdTableView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        
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
    
    switch (tableView.tag) {
        case 100:
            return self.Arr_back.count;
            break;
        case 101:
             return self.Arr_new.count;
            break;
        case 102:
             return self.Arr_goods.count;
            break;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [BBSPostTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    
//    return [UITableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView identifier:NSStringFromClass([BBSPostTableViewCell class]) layoutBlock:^(UITableViewCell *cell) {
//       
//        switch (tableView.tag) {
//            case 100:
//                [(BBSPostTableViewCell*)cell SetSection:indexPath.section withmodel:self.Arr_back[indexPath.section]];
//                break;
//            case 101:
//                [(BBSPostTableViewCell*)cell SetSection:indexPath.section withmodel:self.Arr_new[indexPath.section]];
//                break;
//            case 102:
//                [(BBSPostTableViewCell*)cell SetSection:indexPath.section withmodel:self.Arr_goods[indexPath.section]];
//                break;
//        }
//
//        
//    }];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BBSPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    if (!cell) {
        cell = [[BBSPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (tableView.tag) {
        case 100:
            [cell SetSection:indexPath.section withmodel:self.Arr_back[indexPath.section]];
            break;
        case 101:
            [cell SetSection:indexPath.section withmodel:self.Arr_new[indexPath.section]];
            break;
        case 102:
            [cell SetSection:indexPath.section withmodel:self.Arr_goods[indexPath.section]];
            break;
    }
    cell.delegateSignal = [RACSubject subject];
    @weakify(self);
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        [self PushUserDetail:x];
    }];
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MYLOG(@"点击了第%ld个表格第%ld行",tableView.tag-100,(long)indexPath.section);
}




//用户详情
-(void)PushUserDetail:(NSString *)tag{

    UserCenterViewController *view = [UserCenterViewController new];
    view.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];
 
}
//发帖
-(void)Btn_Posting{

    MYLOG(@"发帖");
    
    
    
}
-(void)PushSearch{

    MYLOG(@"搜索");
    LoginViewController *view = [LoginViewController new];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
@end
