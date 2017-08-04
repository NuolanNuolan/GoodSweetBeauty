//
//  MycommentViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MycommentViewController.h"
#import "YouAnMyCommentModel.h"
#import "MyCommentsHead.h"
#import "CommentsTableViewCell.h"


@interface MycommentViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *Arr_data;
@property(nonatomic,strong)YouAnMyCommentModel *model;
@property(nonatomic,strong)commentsresults *commmentmodel;

@end

@implementation MycommentViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
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

    self.title = @"我的评价";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyCommentsHead class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([MyCommentsHead class])];
    [self.tableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CommentsTableViewCell class])];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -1000, SCREEN_WIDTH, 1000)];
    topView.backgroundColor = GETMAINCOLOR;
    [_tableView addSubview:topView];
    [self.view addSubview:self.tableView];
}
-(void)LoadData{

    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine MyCommentspage:self.page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            [self DealData:self.page withresponseObject:responseObject];
            
        }else{
        
            
        }
    }];
}
-(void)DealData:(NSInteger )page withresponseObject:(id )responseObject{

    self.model = [YouAnMyCommentModel whc_ModelWithJson:responseObject];
    if (page==1) {
        
        [self.Arr_data removeAllObjects];
    }
    for (commentsresults *res in self.model.results) {
        
        res.isopen = NO;
        [self.Arr_data addObject:res];
        
    }
    [self.tableView reloadData];
    
}
#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.Arr_data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)return 171;
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section==0) {
        
        MyCommentsHead *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([MyCommentsHead class])];
        [cell SetModel:self.model];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [CommentsTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentsTableViewCell class])];
    
    [cell SetModel:self.Arr_data[indexPath.section] withsection:indexPath.section];
    @weakify(self);
    cell.delegateSignal = [RACSubject subject];
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        
        //回调数据处理
        [self DealData:x];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



/**
 
 回调数据处理
 */
-(void)DealData:(NSDictionary *)dic{

    if ([dic[@"type"]isEqualToString:@"open"]) {
        
        _commmentmodel = self.Arr_data[[dic[@"value"] integerValue]];
        _commmentmodel.isopen =YES;
        //刷新表格
        [self.tableView reloadSection:[dic[@"value"] integerValue] withRowAnimation:UITableViewRowAnimationNone];
    }else if ([dic[@"type"]isEqualToString:@"at"]){
    
        
        
    }
}
@end
