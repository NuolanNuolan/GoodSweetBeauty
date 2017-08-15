//
//  SetPwdViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/16.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SetPwdViewController.h"
#import "MyAuthTableViewCell.h"


@interface SetPwdViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableview;
//input按钮
@property(nonatomic,strong)UIButton *btn_input;

@property(nonatomic,copy)NSString *str_new_pwd;
@end

@implementation SetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    //添加监听
    GCD_AFTER(
              0.5,
              [self StatObserver];
              );
    // Do any additional setup after loading the view.
}
-(void)CreateUI{


    self.title = @"设置密码";
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
    return 1;
    
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
    
    MyAuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyAuthTableViewCell class])];
    if (!cell) {
        cell  = [[MyAuthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MyAuthTableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetPwd:indexPath.row];
    
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
-(void)StatObserver{
    
    UITextField *text_old = [self.view viewWithTag:101];
    @weakify(self);
    [[text_old rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
        if ([x length]>5) {
            
            self.str_new_pwd = [NSString stringWithFormat:@"%@",x];
            self.btn_input.userInteractionEnabled=YES;
            [self.btn_input setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
        
            self.str_new_pwd = @"";
            self.btn_input.userInteractionEnabled=NO;
            [self.btn_input setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
        }
    }];
}

-(void)Btn_input{

    NSDictionary *dic = @{@"mobile":self.phone,
                          @"code":self.Verification_code,
                          @"password":self.str_new_pwd};
    @weakify(self);
    [HttpEngine ForGotPas_Mes:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
         
            MYLOG(@"%@",responseObject);
            [MBProgressHUD showSuccess:responseObject[@"msg"]];
            GCD_AFTER(0.5,
                      
                      for (UIViewController *controller in self.navigationController.viewControllers) {
                          if ([controller isKindOfClass:[LoginViewController class]]) {
                              LoginViewController *loginview =(LoginViewController *)controller;
                              [self.navigationController popToViewController:loginview animated:YES];
                          }
                      }
                      );
            
            
        }else{
        
            MYLOG(@"%@",responseObject);
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    }];
    
    
}
@end
