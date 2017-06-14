//
//  FansViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "FansViewController.h"
#import "MyFansTableViewCell.h"
#import "YouAnFansFollowModel.h"


@interface FansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)YouAnFansFollowModel *model;

//分页数
@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSMutableArray *Arr_data;

@end

@implementation FansViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(instancetype)initWithtype:(NSString *)type{

    self = [super init];
    if (self) {
        
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitData];
    [self LoadData];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
    self.Arr_data = [NSMutableArray arrayWithCapacity:0];
}
-(void)LoadData{

    //判断是请求粉丝还是关注
    if ([self.type isEqualToString:@"粉丝"]) {
        @weakify(self);
        [HttpEngine UserFanspage:self.page complete:^(BOOL success, id responseObject) {
            @strongify(self);
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
            if (success) {
                if (self.page==1) {
                    
                    [self.Arr_data removeAllObjects];
                }
                NSArray *arr = responseObject;
                if (arr.count<10) {
                    
                    [self.tableview.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * dic in arr) {
                    self.model = [YouAnFansFollowModel whc_ModelWithJson:dic];
                    [self.Arr_data addObject:self.model];
                    
                }
                [self.tableview reloadData];
            }
            
        }];
        
    }else{
        @weakify(self);
        [HttpEngine Userfollowupspage:self.page complete:^(BOOL success, id responseObject) {
            @strongify(self);
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
            if (success) {
                if (self.page==1) {
                    
                    [self.Arr_data removeAllObjects];
                }
                NSArray *arr = responseObject;
                if (arr.count<10) {
                    
                    [self.tableview.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * dic in arr) {
                    self.model = [YouAnFansFollowModel whc_ModelWithJson:dic];
                    self.model.isfocus = YES;
                    [self.Arr_data addObject:self.model];
                    
                }
                [self.tableview reloadData];
            }
            
        }];
    }
    
    
}
-(void)CreateUI{
    if ([self.type isEqualToString:@"粉丝"])self.title = @"我的粉丝";
    else self.title = @"我的关注";
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.superViewController = self;
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
    self.tableview.rowHeight = 90;
    [self.tableview registerNib:[UINib nibWithNibName:@"MyFansTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    @weakify(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
        [self LoadData];
        
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         @strongify(self);
        self.page++;
        [self LoadData];
    }];
    
    [self.view addSubview:self.tableview];
    
    
}
//无数据处理
- (UIView *)ZHN_tempStatusPlaceholderView {
    
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor whiteColor];
    UILabel *stateLabel = [[UILabel alloc]init];
    [tempView addSubview:stateLabel];
    stateLabel.center = self.view.center;
    stateLabel.bounds = CGRectMake(0, 0, 100, 200);
    stateLabel.text = @"没有数据";
    tempView.backgroundColor = [UIColor yellowColor];
    
    return tempView;
}
- (BOOL)ZHN_tempStatusEnableTableViewScroll {
    
    return YES;
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Arr_data.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegateSignal = [RACSubject subject];
    @weakify(self);
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        
        [self FollowOrCancelFollow:x];
        
    }];
    [cell SetModel:self.Arr_data[indexPath.row] withtype:self.type withrow:indexPath.row];
    return cell;
    
}
//关注或者取关
-(void)FollowOrCancelFollow:(NSString *)tag{

    _model = [self.Arr_data objectAtIndex:[tag integerValue]];
    BOOL isFocus = [self.type isEqualToString:@"粉丝"]? _model.if_each_fan :_model.isfocus;
    if (isFocus) {
        //取消关注
        @weakify(self);
        [HttpEngine UserCancelFocususerid:[self.model.id integerValue] complete:^(BOOL success, id responseObject) {
            @strongify(self);
            if (success) {
                
                 [self Changestatus:isFocus];
            }
        }];
    }else{
        @weakify(self);
        //关注
        [HttpEngine UserFocususerid:[self.model.id integerValue] complete:^(BOOL success, id responseObject) {
            @strongify(self);
            if (success) {
                [self Changestatus:isFocus];
            }
        }];
    }
}
//状态更改
-(void)Changestatus:(BOOL )isFocus{

    if([self.type isEqualToString:@"粉丝"])_model.if_each_fan =!isFocus;
    else _model.isfocus = !isFocus;
    [self.tableview reloadData];
}

@end
