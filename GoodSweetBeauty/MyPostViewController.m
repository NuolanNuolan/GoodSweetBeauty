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

@interface MyPostViewController ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btn_main;
@property(nonatomic,strong)UIButton *btn_back;
@property(nonatomic,strong)UIView *view_line;
@property(nonatomic,strong)UIView *view_line_two;
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
    [self CreateUI];
    // Do any additional setup after loading the view.
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
    
    return 5;
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
        [cell SetSection:indexPath.section];
        return cell;
    }
    MyPost_TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyPost_TwoTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetSection:indexPath.section];
    return cell;
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
    
}
@end
