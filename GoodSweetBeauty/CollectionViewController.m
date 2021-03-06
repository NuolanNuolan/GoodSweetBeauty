//
//  CollectionViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CollectionViewController.h"
#import "YouAnCollectionModel.h"
#import "BBSPostTableViewCell.h"
#import "PostingDeatilViewController.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
//model
@property(nonatomic,strong)YouAnCollectionModel *model;
//数组
@property(nonatomic,strong)NSMutableArray *Arr_data;
//page
@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)YouAnBusinessCardModel *BusinessModel;

@end

@implementation CollectionViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitData];
    [self CreateUI];
    [self LoadDataWithpage:self.page];
}
-(void)InitData{

    self.page = 1;
    self.Arr_data = [NSMutableArray arrayWithCapacity:0];
    
}
-(void)CreateUI{

    self.title = @"我的收藏";
    //表格
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BBSPostTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSPostTableViewCell class])];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self.tableView.mj_footer resetNoMoreData];
        [self LoadDataWithpage:self.page];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self LoadDataWithpage:++self.page];
    }];
    

    
}
-(void)LoadDataWithpage:(NSInteger )page{

    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine MyCollectionWithpage:page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (success) {
            if (page==1) {
                
                [self.Arr_data removeAllObjects];
            }
            if ([(NSArray *)responseObject count]<10) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dic in responseObject) {
                
                self.model = [YouAnCollectionModel whc_ModelWithJson:dic];
                [self.Arr_data addObject:self.model];
            }
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.Arr_data.count;
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
    [cell SetRow:indexPath.section withmodel:self.Arr_data[indexPath.section]];
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
    
    _model = self.Arr_data[indexPath.section];
    PostingDeatilViewController *view = [PostingDeatilViewController new];
    view.posting_id = _model.id;
    view.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];
}
/**
 用户信息
 */
-(void)PushUserDetail:(NSString *)tag{

    _model = self.Arr_data[[tag integerValue]];
    
    [[BWCommon sharebwcommn]PushTo_UserDeatil:_model.author_id view:self];
//    @weakify(self);
//    [ZFCWaveActivityIndicatorView show:self.view];
//    [HttpEngine BusinessCard:_model.author_id complete:^(BOOL success, id responseObject) {
//        @strongify(self);
//        [ZFCWaveActivityIndicatorView hid:self.view];
//        if (success) {
//            
//            self.BusinessModel = [YouAnBusinessCardModel whc_ModelWithJson:responseObject];
//            UIViewController *view = [[BWCommon sharebwcommn]UserDeatil:self.BusinessModel];
//            view.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:view animated:YES];
//            
//        }else{
//            
//            if (responseObject[@"msg"]) {
//                
//                [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
//                
//            }else{
//                
//                [MBProgressHUD showError:@"信息拉取失败" toView:self.view];
//            }
//        }
//    }];

    
}

@end
