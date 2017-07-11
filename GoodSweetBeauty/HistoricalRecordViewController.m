//
//  HistoricalRecordViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HistoricalRecordViewController.h"
#import "YouAnConisRecordModel.h"
#import "HistoryCoinsTableViewCell.h"
#import "TimeHeaderFooterView.h"

@interface HistoricalRecordViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *Arr_time;
@property(nonatomic,strong)NSMutableArray *Arr_show_data;
@property(nonatomic,strong)NSMutableArray *Arr_data;
@property(nonatomic,strong)YouAnConisRecordModel *model;
@end

@implementation HistoricalRecordViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
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
    self.Arr_time = [NSMutableArray arrayWithCapacity:0];
    
}
-(void)CreateUI{

    self.title = @"我的有安币";
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableview.delegate =self;
    self.tableview.dataSource =self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableview.rowHeight = 63.0f;
    self.tableview.sectionHeaderHeight = 28.0f;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    [self.tableview registerNib:[UINib nibWithNibName:@"HistoryCoinsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[TimeHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([TimeHeaderFooterView class])];
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
    [HttpEngine CoinsRecord:self.page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            if (self.page ==1) [self.Arr_data removeAllObjects];
            if ([(NSArray *)responseObject count]>0) {
                if ([(NSArray *)responseObject count]<10)[self.tableview.mj_footer endRefreshingWithNoMoreData];
                for (NSDictionary *dic in responseObject) {
                    
                    self.model = [YouAnConisRecordModel whc_ModelWithJson:dic];
                    [self.Arr_data addObject:self.model];
                }
                [self DealWithData];
            }else{
            
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableview reloadData];
        }else{
        
            
        }
        
    }];
}
//处理数据
-(void)DealWithData{

    NSString *str_date = @"";
    [self.Arr_show_data removeAllObjects];
    [self.Arr_time removeAllObjects];
    for (YouAnConisRecordModel *model in self.Arr_data) {
        
        model.date =[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"];
        
        if (![[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"] isEqualToString:str_date]) {
            
            str_date = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"]];
            [self.Arr_time addObject:str_date];
            
        }
    }
    for (NSString *str_da in self.Arr_time) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date CONTAINS[cd] %@",str_da];
        NSArray *searchFoods = [self.Arr_data filteredArrayUsingPredicate:predicate];
        //添加进大数组
        [self.Arr_show_data addObject:searchFoods];
    }
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.Arr_show_data objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.Arr_time.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TimeHeaderFooterView *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([TimeHeaderFooterView class])];
    [cell Settitle:self.Arr_time[section]];
    return cell;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HistoryCoinsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetModel:self.Arr_show_data[indexPath.section][indexPath.row]];
    return cell;
}

-(NSMutableArray *)Arr_time{

    if (!_Arr_time) {
        _Arr_time = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_time;
}
-(NSMutableArray *)Arr_show_data{
    
    if (!_Arr_show_data) {
        _Arr_show_data = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_show_data;
}
@end
