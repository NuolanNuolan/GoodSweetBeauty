//
//  AtMeViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/19.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AtMeViewController.h"
#import "YouAnAtMeModel.h"
#import "AtMePostTableViewCell.h"
#import "PostingDeatilViewController.h"

@interface AtMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)YouAnAtMeModel *model;
@property(nonatomic,strong)NSMutableArray *Arr_data;
@end

@implementation AtMeViewController
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
    [self LoadData];
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
    self.Arr_data = [NSMutableArray arrayWithCapacity:0];
    
}
-(void)CreateUI{

    self.title = @"@我的";
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
//    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
//    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
    [self.tableview registerClass:[AtMePostTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AtMePostTableViewCell class])];
    [self.view addSubview:self.tableview];
    @weakify(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self.tableview.mj_footer resetNoMoreData];
        [self LoadData];
        
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        self.page++;
        [self LoadData];
        
    }];
    
}
-(void)LoadData{

    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine AtMePosts:self.page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
        if (success) {
            
            [self DataDeal:responseObject];
            
        }else{
        
            
            
        }
    }];
}
//数据处理
-(void)DataDeal:(id )responseObject{

    if (self.page == 1) {
        
        [self.Arr_data removeAllObjects];
    }
    if ([(NSArray *)responseObject count]<10) {
        
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
        
    }
    for (NSDictionary *dic in responseObject) {
        
        self.model = [YouAnAtMeModel whc_ModelWithJson:dic];
        
        [self.Arr_data addObject:self.model];
    }
    [self.tableview reloadData];
    
    
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
    
    return [AtMePostTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AtMePostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AtMePostTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetModel:self.Arr_data[indexPath.section]withrow:indexPath.section];
    cell.delegateSignal = [RACSubject subject];
    @weakify(self);
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        [self AtPerson:x];
    }];
    return cell;
    
    
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostingDeatilViewController *view = [PostingDeatilViewController new];
    self.model = self.Arr_data[indexPath.section];
    view.posting_id = self.model.tid;
    [self.navigationController pushViewController:view animated:YES];
    
}


//点击
-(void)AtPerson:(NSDictionary *)dic{

    if ([dic[@"type"]isEqualToString:@"AT"]) {
        
        _model = [self.Arr_data objectAtIndex:[dic[@"row"] integerValue]];
        for (Ats *atmodel in _model.ats) {
            
            if ([dic[@"name"] isEqualToString:atmodel.uname]) {
                
                MYLOG(@"@的ID是:%ld",(long)atmodel.uid)
            }
        }
    }else if ([dic[@"type"]isEqualToString:@"PUSH"]){
    
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:[dic[@"row"] integerValue]];
        [self.tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)];
        [self.tableview.delegate tableView:self.tableview didSelectRowAtIndexPath:path];
    }


    
}








@end
