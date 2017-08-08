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
@property(nonatomic,assign)NSInteger authtype;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *email;

@end

@implementation AuthViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self initData];
    [self CreateUI];
    //添加监听
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self Addobserver];
    });
    // Do any additional setup after loading the view.
}
-(void)initData{

    self.authtype = 0;
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
        
        self.authtype = [[NSString stringWithFormat:@"%@",x] isEqualToString:@"个人认证"]?1:2;
        
    }else{
    
        self.name = [NSString stringWithFormat:@"%@",[x objectAtIndex:0]];
        self.phone = [NSString stringWithFormat:@"%@",[x objectAtIndex:1]];
        self.email = [NSString stringWithFormat:@"%@",[x objectAtIndex:2]];
    }
    
    if (![self.name isEqualToString:@""]&&![self.phone isEqualToString:@""]&&![self.email isEqualToString:@""]&&self.authtype!=0) {
        self.btn_input.userInteractionEnabled=YES;
        [self.btn_input setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        
        self.btn_input.userInteractionEnabled=NO;
        [self.btn_input setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    }
}
-(void)Btn_input{

    //开始正则匹配
    //姓名 不能有下划线 数字 符号 空格
    if (![BWCommon Predicate:@"^[a-zA-Z\u4e00-\u9fa5]+$" str:self.name]) {
        
        [MBProgressHUD showError:@"请输入正确的姓名"];
        
        return;
    }
    //联系方式 只有数字 座机有中划线 位数不做限制
    if (![BWCommon Predicate:@"^\\d{3}-\\d{8}|\\d{4}-\\d{7,8}$" str:self.phone]&&![BWCommon checkInputMobile:self.phone]) {
        
        [MBProgressHUD showError:@"请输入正确的联系方式"];
        return;
    }
    //邮箱
    if (![BWCommon Predicate:@"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" str:self.email]) {
        
        [MBProgressHUD showError:@"请输入正确的邮箱"];
        return;
    }
    //验证通过
    NSDictionary *dic = @{@"real_name":self.name,
                          @"vip_type":[NSNumber numberWithInteger:self.authtype],
                          @"phone":self.phone,
                          @"email":self.email};
    @weakify(self);
    [HttpEngine Vip_Application:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            [MBProgressHUD showSuccess:responseObject[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
        
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    }];
    
    
}

@end
