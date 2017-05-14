//
//  AuthViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AuthViewController.h"
#import "MyAuthTableViewCell.h"




@interface AuthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
//input按钮
@property(nonatomic,strong)UIButton *btn_input;


//认证类型
@property(nonatomic,strong)NSString *authtype;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;

@end

@implementation AuthViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self initData];
    [self CreateUI];
    //添加监听
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self Addobserver];
    });
    // Do any additional setup after loading the view.
}
-(void)initData{

    self.authtype = @"";
    self.name = @"";
    self.phone = @"";
    self.email = @"";
    
}
-(void)CreateUI{
    
    self.title = @"我要认证";
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorColor:RGB(233, 233, 233)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    self.tableview.rowHeight = 50;
    [self.view addSubview:self.tableview];

    
}
#pragma mark delegate
- (void)viewDidLayoutSubviews
{
    //iOS7只需要设置SeparatorInset(iOS7开始有的)就可以了，但是iOS8的话单单只设置这个是不行的，还需要设置LayoutMargins(iOS8开始有的)
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
//cell即将展示的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 74;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyAuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (!cell) {
        cell  = [[MyAuthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetSection:indexPath.row];
    cell.delegateSignal = [RACSubject subject];
    @weakify(self);
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        [self oberver:x];
        
    }];
    return cell;

    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    self.btn_input = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_input.frame = CGMAKE(45, 24, SCREEN_WIDTH-90, 50);
    [self.btn_input setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_input setBackgroundColor:GETMAINCOLOR];
    self.btn_input.userInteractionEnabled =YES;
    [self.btn_input setTitle:@"提交" forState:UIControlStateNormal];
    self.btn_input.layer.masksToBounds = NO;
    self.btn_input.layer.cornerRadius = 25.0f;
    [self.btn_input addTarget:self action:@selector(Btn_input) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:self.btn_input];
    
    return view;
}
-(void)Addobserver{
    
    UITextField *text_name = [self.view viewWithTag:100];
    UITextField *text_phone = [self.view viewWithTag:101];
    UITextField *text_email = [self.view viewWithTag:102];
    
    id signals = @[[text_name rac_textSignal],[text_phone rac_textSignal],[text_email rac_textSignal]];
    @weakify(self);
    [[RACSignal combineLatest:signals]subscribeNext:^(id x) {
        @strongify(self);
        
        [self oberver:x];

    }];
    
}
-(void)oberver:(id )x{

    if ([[x class]isSubclassOfClass:[NSString class]]) {
        
        self.authtype = [NSString stringWithFormat:@"%@",x];
        
    }else{
    
        self.name = [NSString stringWithFormat:@"%@",[x objectAtIndex:0]];
        self.phone = [NSString stringWithFormat:@"%@",[x objectAtIndex:1]];
        self.email = [NSString stringWithFormat:@"%@",[x objectAtIndex:2]];
    }
    
    if (![self.name isEqualToString:@""]&&![self.phone isEqualToString:@""]&&![self.email isEqualToString:@""]&&![self.authtype isEqualToString:@""]) {
        self.btn_input.userInteractionEnabled=YES;
        [self.btn_input setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        
        self.btn_input.userInteractionEnabled=NO;
        [self.btn_input setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    }
}
-(void)Btn_input{

    
    
}

@end
