//
//  MyPostViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyPostViewController.h"
#import "MyPost_OneTableViewCell.h"
#import "MyPost_TwoTableViewCell.h"
#import "YouAnUserPosttingModel.h"
#import "PostingDeatilViewController.h"
@interface MyPostViewController ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btn_main;
@property(nonatomic,strong)UIButton *btn_back;
@property(nonatomic,strong)UIView *view_line;
@property(nonatomic,strong)UIView *view_line_two;

//page
@property(nonatomic,assign)NSInteger page_master;
@property(nonatomic,assign)NSInteger page_comment;

@property(nonatomic,strong)NSMutableArray *Arr_master;
@property(nonatomic,strong)NSMutableArray *Arr_comment;

//判断是否还有更多数据
@property(nonatomic,assign)BOOL isNoMoreData_master;
@property(nonatomic,assign)BOOL isNoMoreData_comments;

@property(nonatomic,strong)YouAnUserPosttingModel *Posttingmodel;


@end

@implementation MyPostViewController
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
    [self LoadData:self.page_master withtype:StatusMaster];
    [self LoadData:self.page_comment withtype:StatusComments];
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page_master = 1;
    self.page_comment = 1;
    self.Arr_master = [NSMutableArray arrayWithCapacity:0];
    self.Arr_comment = [NSMutableArray arrayWithCapacity:0];

}
-(void)LoadData:(NSInteger )page withtype:(Posttingtype )type{
    
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page],
                          @"if_master":[NSNumber numberWithInteger:type]};
    @weakify(self);
    [HttpEngine UserPostting_master_comment:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            //数据处理
            switch (type) {
                case StatusMaster:{
                    MYLOG(@"处理主贴");
                    [self DataProcessing_master:responseObject withpage:page];

                }
                    break;
                case StatusComments:{
                    MYLOG(@"处理评论");
                    [self DataProcessing_comment:responseObject withpage:page];
                }
                    break;
            }
            [self.tableView reloadData];
            [self DealWithFooter];
        }
    }];
}
/**
 主贴数据处理
 */
-(void)DataProcessing_master:(id )responseObject withpage:(NSInteger )page{

    if (page==1) {
        
        [self.Arr_master removeAllObjects];
    }
    if ([(NSArray *)responseObject count]<10) {
        
        self.isNoMoreData_master =YES;
        
    }
    for (NSDictionary *dic in responseObject) {
        
        self.Posttingmodel = [YouAnUserPosttingModel whc_ModelWithJson:dic];
        
        [self.Arr_master addObject:self.Posttingmodel];
    }
    
}
/**
评论贴数据处理
 */
-(void)DataProcessing_comment:(id )responseObject withpage:(NSInteger )page{
    
    if (page==1) {
        
        [self.Arr_comment removeAllObjects];
    }
    if ([(NSArray *)responseObject count]<10) {
        
        self.isNoMoreData_comments =YES;
        
    }
    for (NSDictionary *dic in responseObject) {
        
        self.Posttingmodel = [YouAnUserPosttingModel whc_ModelWithJson:dic];
        
        [self.Arr_comment addObject:self.Posttingmodel];
    }
    

}

-(void)CreateUI{
    
    self.title = @"我的帖子";
    UIView *view_top = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 44)];
    view_top.backgroundColor = [UIColor whiteColor];
    self.btn_main = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_main setTitle:@"主贴" forState:UIControlStateNormal];
    self.btn_main.selected=YES;
    [self.btn_main addTarget:self action:@selector(Btn_switch:) forControlEvents:UIControlEventTouchUpInside];
    self.btn_main.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn_main setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    
    self.btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_back setTitle:@"回帖" forState:UIControlStateNormal];
    self.btn_back.selected=NO;
    self.btn_back.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn_back addTarget:self action:@selector(Btn_switch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_back setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.view_line = [UIView new];
    self.view_line.backgroundColor = GETMAINCOLOR;
    
    self.view_line_two = [UIView new];
    self.view_line_two.backgroundColor = RGB(229, 229, 229);
    
    [view_top addSubview:self.btn_main];
    [view_top addSubview:self.btn_back];
    [view_top addSubview:self.view_line];
    [view_top addSubview:self.view_line_two];
    [self.view addSubview:view_top];
    
    self.btn_main.whc_LeftSpace(0).whc_TopSpace(0).whc_Height(41.5).whc_Width(SCREEN_WIDTH/2);
    self.btn_back.whc_TopSpaceEqualView(self.btn_main).whc_RightSpace(0).whc_HeightEqualView(self.btn_main).whc_WidthEqualView(self.btn_main);
    self.view_line.whc_Height(2).whc_Width(85).whc_CenterXToView(0,self.btn_main).whc_BottomSpaceToView(0,self.view_line_two);
    self.view_line_two.whc_Height(0.5).whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
    
    //表格
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyPost_OneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyPost_OneTableViewCell class])];
    [self.tableView registerClass:[MyPost_TwoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyPost_TwoTableViewCell class])];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if (self.btn_main.selected) {
            
            self.page_master = 1;
            self.isNoMoreData_master =NO;
            [self LoadData:self.page_master withtype:StatusMaster];
            
        }else{
        
            self.page_comment = 1;
            self.isNoMoreData_comments = NO;
            [self LoadData:self.page_comment withtype:StatusComments];
        }
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if (self.btn_main.selected) {
            
            
            [self LoadData:++self.page_master withtype:StatusMaster];
            
        }else{
            
            [self LoadData:++self.page_comment withtype:StatusComments];
        }
    }];

}

#pragma mark tableviewdelegate
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [self.tableView reloadData];
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [self.tableView reloadData];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (self.btn_main.selected) {
        
        return self.Arr_master.count;
        
    }else{
    
        return self.Arr_comment.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)return 10;
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MyPost_OneTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.btn_main.selected) {
        MyPost_OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyPost_OneTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell SetSection:indexPath.section withModel:self.Arr_master[indexPath.section]];
        return cell;
    }
    MyPost_TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyPost_TwoTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetSection:indexPath.section withModel:self.Arr_comment[indexPath.section]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PostingDeatilViewController *view = [PostingDeatilViewController new];
    if (self.btn_main.selected) {
        
        self.Posttingmodel = self.Arr_master[indexPath.section];
        view.posting_id = self.Posttingmodel.tid;
        
    }else{
    
        self.Posttingmodel = self.Arr_comment[indexPath.section];
        view.posting_id = self.Posttingmodel.tid;
    }
    [self.navigationController pushViewController:view animated:YES];
}



















//切换按钮
-(void)Btn_switch:(UIButton *)sender{

    if(sender.selected)return;
    [sender setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    self.view_line.whc_Height(2).whc_Width(85).whc_CenterXToView(0,sender).whc_BottomSpaceToView(0,self.view_line_two);
    sender.selected=YES;
    if (sender==self.btn_main) {
        
        [self.btn_back setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        self.btn_back.selected=NO;
        MYLOG(@"主贴");
        
        
        
    }else{
    
        [self.btn_main setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        self.btn_main.selected = NO;
        MYLOG(@"回帖");
    }
    [self.tableView reloadData];
    [self DealWithFooter];
}

/**
 这里处理footer
 */
-(void)DealWithFooter{

    if (self.btn_main.selected) {
        
        if (self.isNoMoreData_master) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
        
            [self.tableView.mj_footer resetNoMoreData];
        }
        
    }else{
    
        if (self.isNoMoreData_comments) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            [self.tableView.mj_footer resetNoMoreData];
        }
        
    }
    
}
@end
