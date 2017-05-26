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
//是否带刷新
#define HasHeaderRefresh 1
//是否有loading和无数据view
#define HasLoadingAndNotDataView 0

@interface YNTestBaseViewController ()

//三个表格的page  数据
@property(nonatomic,assign) NSInteger page_back;
@property(nonatomic,assign) NSInteger page_new;
@property(nonatomic,assign) NSInteger page_goods;

@property(nonatomic,strong) NSMutableArray *Arr_back;
@property(nonatomic,strong) NSMutableArray *Arr_new;
@property(nonatomic,strong) NSMutableArray *Arr_goods;

@property(nonatomic,strong)YouAnBBSModel *Bbsmodel;

@end


@implementation YNTestBaseViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self createload];
    [self.view addSubview:self.tableView];
    
    
}
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
}
-(void)createload{

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
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
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    if (!cell) {
        
        cell = [[BBSPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (self.ynPageScrollViewController.pageIndex) {
        case 0:
            [cell SetSection:indexPath.section withmodel:self.Arr_back[indexPath.section]];
            break;
        case 1:
            [cell SetSection:indexPath.section withmodel:self.Arr_new[indexPath.section]];
            break;
        case 2:
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
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYLOG(@"%ld",(long)self.ynPageScrollViewController.pageIndex);
    
//    LoginViewController *view = [LoginViewController new];
//    view.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:view animated:YES];
    
     
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
    
    UserCenterViewController *view = [UserCenterViewController new];
    view.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];
    
}
@end
