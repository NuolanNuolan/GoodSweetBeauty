//
//  YNTestBaseViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNTestBaseViewController.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshAutoFooter.h"
#import "YNPageScrollViewController.h"
#import "YNTestOneViewController.h"
#import "YNTestTwoViewController.h"
#import "BBSPostTableViewCell.h"
#import "CenterOneViewController.h"
#import "CenterTwoViewController.h"
#import "CenterMainViewController.h"
#import "PostingDeatilViewController.h"
//是否带刷新
#define HasHeaderRefresh 1
//是否有loading和无数据view
#define HasLoadingAndNotDataView 0

@interface YNTestBaseViewController ()<YNPageScrollViewControllerDataSource>

//三个表格的page  数据
@property(nonatomic,assign) NSInteger page_back;
@property(nonatomic,assign) NSInteger page_new;
@property(nonatomic,assign) NSInteger page_goods;

@property(nonatomic,strong) NSMutableArray *Arr_back;
@property(nonatomic,strong) NSMutableArray *Arr_new;
@property(nonatomic,strong) NSMutableArray *Arr_goods;

@property(nonatomic,strong)YouAnBBSModel *Bbsmodel;

//用户主页的头部
@property(nonatomic,strong)UIView *view_userhead;
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


@implementation YNTestBaseViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    [self createload];
    
}
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
}
-(void)createload{

    
    @weakify(self);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
//            self.tableView.mj_footer.hidden = NO;
            switch (self.ynPageScrollViewController.pageIndex) {
                case 0:
                    self.page_back =1;
                    break;
                case 1:
                    self.page_new =1;
                    break;
                case 2:
                    self.page_goods =1;
                    break;
            }
            [self LoadData:self.ynPageScrollViewController.pageIndex withpage:1 withtableview:self.tableView];
            
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            NSInteger page = 0;
            switch (self.ynPageScrollViewController.pageIndex) {
                case 0:
                    page = ++self.page_back;
                    break;
                case 1:
                    page = ++self.page_new;
                    break;
                case 2:
                    page = ++self.page_goods;
                    break;
            }
            [self LoadData:self.ynPageScrollViewController.pageIndex withpage:page withtableview:self.tableView];
        }];

    
    
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
        
//        tableview.mj_footer.hidden = YES;
    }
    switch (self.ynPageScrollViewController.pageIndex) {
        case 0:{
            
            if (page==1) {
                
                [self.Arr_back removeAllObjects];
            }
            for (NSDictionary *dic in arr) {
                
                self.Bbsmodel = [YouAnBBSModel whc_ModelWithJson:dic];
                [self.Arr_back addObject:self.Bbsmodel];
            }
        }
            break;
        case 1:{
            if (page==1) {
                
                [self.Arr_new removeAllObjects];
            }
            for (NSDictionary *dic in responseObject) {
                
                self.Bbsmodel = [YouAnBBSModel whc_ModelWithJson:dic];
                [self.Arr_new addObject:self.Bbsmodel];
            }
        }
            break;
        case 2:{
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


#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    switch (self.ynPageScrollViewController.pageIndex) {
        case 0:
            return self.Arr_back.count;
            break;
        case 1:
            return self.Arr_new.count;
            break;
        case 2:
            return self.Arr_goods.count;
            break;
    }
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [BBSPostTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBSPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (self.ynPageScrollViewController.pageIndex) {
        case 0:{
            if (self.Arr_back.count>0) {
                
               [cell SetSection:indexPath.section withmodel:self.Arr_back[indexPath.section]];
            }
        }
            break;
        case 1:{
            
            if (self.Arr_new.count>0) {
                
                [cell SetSection:indexPath.section withmodel:self.Arr_new[indexPath.section]];
            }
        }
            break;
        case 2:{
            if (self.Arr_goods.count>0) {
               
                [cell SetSection:indexPath.section withmodel:self.Arr_goods[indexPath.section]];
            }
            
        }
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
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostingDeatilViewController *view = [PostingDeatilViewController new];
    switch (self.ynPageScrollViewController.pageIndex) {
        case 0:{
        
            _Bbsmodel = self.Arr_back[indexPath.section];
            view.posting_id = _Bbsmodel.id;
            
        }
            break;
        case 1:{
            _Bbsmodel = self.Arr_new[indexPath.section];
            view.posting_id = _Bbsmodel.id;
            
        }
            break;
        case 2:{
            
            _Bbsmodel = self.Arr_goods[indexPath.section];
            view.posting_id = _Bbsmodel.id;
        }
            break;
    }
    view.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];
     
}

#pragma mark - lazy

- (UITableView *)tableView{

    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[BBSPostTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    }
    return _tableView;

};


- (NSMutableArray *)Arr_new{
    
    if (!_Arr_new) {
        _Arr_new = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_new;
};
- (NSMutableArray *)Arr_back{
    
    if (!_Arr_back) {
        _Arr_back = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_back;
};
- (NSMutableArray *)Arr_goods{
    
    if (!_Arr_goods) {
        _Arr_goods = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_goods;
};



//用户详情
-(void)PushUserDetail:(NSString *)tag{
    
    [self ConfigurationUserDeail:self.ynPageScrollViewController.pageIndex tag:[tag integerValue]];
    
    UIViewController *view = [self CreateContrllr];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}
-(void)ConfigurationUserDeail:(NSInteger )pageindex tag:(NSInteger )tag{

    switch (pageindex) {
        case 0:{
            
            
            
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
    }
}

//配置用户详情页相关
-(UIViewController*)CreateContrllr{

    CenterOneViewController *one = [CenterOneViewController new];
    CenterTwoViewController *two = [CenterTwoViewController new];
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    configration.normalItemColor = RGB(51, 51, 51);
    configration.selectedItemColor = GETMAINCOLOR;
    configration.lineColor = GETMAINCOLOR;
    configration.scrollMenu =NO;
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    
    CenterMainViewController *vc = [CenterMainViewController pageScrollViewControllerWithControllers:@[one,two] titles:@[@"商务名片",@"口碑评价"] Configration:configration];
    vc.dataSource = self;
    //头部headerView
    vc.headerView = self.view_userhead;
    
    return vc;
}
-(UIView *)view_userhead{

    if (!_view_userhead) {
        
        _view_userhead = [[UIView alloc] initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 235)];
        _view_userhead.backgroundColor = GETMAINCOLOR;
        self.image_head = [[UIImageView alloc]initWithRoundingRectImageView];;
//        self.image_head.layer.masksToBounds =YES;
//        self.image_head.layer.cornerRadius =40.0F;
        self.image_head.backgroundColor = [UIColor grayColor];
        
        self.lab_username = [UILabel new];
        [self.lab_username setTextColor:[UIColor whiteColor]];
        [self.lab_username setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_username setText:@"换个字试试"];
        [self.lab_username sizeToFit];
        
        //添加一个view 装name 和图标
        UIView *view_lab_v_level = [UIView new];
//        view_lab_v_level.backgroundColor = [UIColor whiteColor];
        view_lab_v_level.backgroundColor = [UIColor yellowColor];
        
        self.view_v_level = [UIView new];
        self.view_v_level.backgroundColor = RGB(247, 247, 247);
        self.view_v_level.layer.masksToBounds =YES;
        self.view_v_level.layer.cornerRadius =8;
        
        self.image_v = [UIImageView new];
        self.image_v.image = [UIImage imageNamed:@"iconVBlue"];
        
        self.image_level = [UIImageView new];
        self.image_level.image = [UIImage imageNamed:@"iconLv2"];
        
        self.view_btn_gap = [UIView new];
        self.view_btn_gap.backgroundColor = [UIColor clearColor];
        
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
        [view_lab_v_level addSubview:self.lab_username];
        [view_lab_v_level addSubview:self.view_v_level];
        [_view_userhead addSubview:self.image_head];
        [_view_userhead addSubview:view_lab_v_level];
        [_view_userhead addSubview:self.view_btn_gap];
        
        self.image_head.whc_Size(80,80).whc_CenterX(0).whc_TopSpace(5);
        
        view_lab_v_level.whc_TopSpaceToView(15,self.image_head).whc_CenterXToView(0,self.image_head).whc_WidthAuto().whc_HeightAuto();
        self.lab_username.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpaceToView(5,self.view_v_level);
        self.image_v.whc_Size(11,9).whc_LeftSpace(7).whc_CenterY(0).whc_RightSpaceToView(5,self.image_level);
        self.image_level.whc_Size(12,11).whc_RightSpace(7.5).whc_CenterY(0);
        self.view_v_level.whc_WidthAuto().whc_RightSpace(0).whc_Height(16).whc_CenterYToView(0,self.lab_username);
        
        self.view_btn_gap.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(60,view_lab_v_level).whc_Height(65);
    }
    return _view_userhead;
}
#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= (CenterBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
}
- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= (CenterBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

@end
