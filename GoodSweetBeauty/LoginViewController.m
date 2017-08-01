//
//  LoginViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/13.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>



//logo
@property(nonatomic,strong)UIImageView *image_logo;
//用户名左视图
@property(nonatomic,strong)UIImageView *image_user_left;
//用户名输入框
@property(nonatomic,strong)LoginTextField *text_username;
//用户框下面的线
@property(nonatomic,strong)UIView *view_line_username;
//密码左视图
@property(nonatomic,strong)UIImageView *image_pwd_left;
//密码输入框
@property(nonatomic,strong)LoginTextField *text_pwd;
//密码框下面的线
@property(nonatomic,strong)UIView *view_lin_pwd;
//忘记密码按钮
@property(nonatomic,strong)UIButton *btn_foget;
//登录按钮
@property(nonatomic,strong)UIButton *btn_login;
//短信验证登录
@property(nonatomic,strong)UIButton *btn_messvalidation_login;
//注册lab
@property(nonatomic,strong)UILabel *lab_res;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateUI];
    [self Addobserver];
    // Do any additional setup after loading the view.
}

-(void)CreateUI{

    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.image_logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Loginlogo"]];
    
    self.image_user_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconSignUsername"]];
    self.image_user_left.frame = CGMAKE(0, 19, 19, 20);
    
    self.text_username = [LoginTextField new];
    self.text_username.delegate = self;
    self.text_username.tag=100;
//    self.text_username.backgroundColor = [UIColor redColor];
    [self.text_username setTintColor:GETMAINCOLOR];
    [self.text_username setFont:[UIFont boldSystemFontOfSize:18]];
    [self.text_username setTextColor:RGB(51, 51, 51)];
    [self.text_username setReturnKeyType:UIReturnKeyNext];
    self.text_username.leftView = self.image_user_left;
    self.text_username.leftViewMode = UITextFieldViewModeAlways;
    [self.text_username setPlaceholder:@"请输入用户名或手机号"];
    UIColor * color = RGB(153, 153, 153);
    [self.text_username setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    UIFont * font = [UIFont systemFontOfSize:16];
    [self.text_username setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    self.view_line_username = [UIView new];
    self.view_line_username.backgroundColor = RGB(229, 229, 229);
    
    
    
    
    self.image_pwd_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconSignPassword"]];
    self.image_pwd_left.frame = CGMAKE(0, 17, 17, 20);
    
    self.text_pwd = [LoginTextField new];
    self.text_pwd.delegate = self;
    self.text_pwd.tag= 101;
//    self.text_pwd.backgroundColor = [UIColor redColor];
    [self.text_pwd setTintColor:GETMAINCOLOR];
    [self.text_pwd setFont:[UIFont boldSystemFontOfSize:18]];
    [self.text_pwd setTextColor:RGB(51, 51, 51)];
    [self.text_pwd setReturnKeyType:UIReturnKeyGo];
    [self.text_pwd setSecureTextEntry:YES];
    self.text_pwd.leftView = self.image_pwd_left;
    self.text_pwd.leftViewMode = UITextFieldViewModeAlways;
    [self.text_pwd setPlaceholder:@"密码"];
    [self.text_pwd setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [self.text_pwd setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    self.view_lin_pwd = [UIView new];
    self.view_lin_pwd.backgroundColor = RGB(229, 229, 229);
    
    
    self.btn_foget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_foget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.btn_foget.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_foget setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [self.btn_foget addTarget:self action:@selector(FogetPwd) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_login setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_login setBackgroundColor:GETMAINCOLOR];
    self.btn_login.userInteractionEnabled =NO;
    [self.btn_login setTitle:@"登录" forState:UIControlStateNormal];
    self.btn_login.layer.masksToBounds = YES;
    self.btn_login.layer.cornerRadius = 25.0f;
    [self.btn_login addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_messvalidation_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_messvalidation_login setTitle:@"短信验证登录" forState:UIControlStateNormal];
    self.btn_messvalidation_login.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_messvalidation_login setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    [self.btn_messvalidation_login addTarget:self action:@selector(Login_ForMes) forControlEvents:UIControlEventTouchUpInside];
    
    self.lab_res = [UILabel new];
    [self.lab_res setTextColor:RGB(102, 102, 102)];
    [self.lab_res setFont:[UIFont systemFontOfSize:15]];
    [self.lab_res setAttributedText:[BWCommon setupAttributeString:@"还没有账户？免费注册" highlightText:@"免费注册" collor:GETMAINCOLOR]];
    [self.lab_res sizeToFit];
    self.lab_res.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Res)];
    [self.lab_res addGestureRecognizer:tap];
    
    //布局
    [self.view addSubview:self.image_logo];
    [self.view addSubview:self.text_username];
    [self.view addSubview:self.text_pwd];
    [self.view addSubview:self.view_line_username];
    [self.view addSubview:self.view_lin_pwd];
    [self.view addSubview:self.btn_foget];
    [self.view addSubview:self.btn_login];
    [self.view addSubview:self.btn_messvalidation_login];
    [self.view addSubview:self.lab_res];
    
    self.image_logo.whc_TopSpace(35).whc_Size(80,80).whc_CenterX(0);
    
    self.text_username.whc_LeftSpace(45).whc_RightSpace(45).whc_Height(45).whc_TopSpaceToView(30,self.image_logo);
    
    self.view_line_username.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(0.5).whc_TopSpaceToView(0,self.text_username);
    
    
    self.text_pwd.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_HeightEqualView(self.text_username).whc_TopSpaceToView(8,self.view_line_username);
    
    self.view_lin_pwd.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(0.5).whc_TopSpaceToView(0,self.text_pwd);
    
    self.btn_foget.whc_RightSpaceEqualView(self.text_username).whc_TopSpaceToView(15,self.view_lin_pwd).whc_Height(15);
    
    self.btn_login.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(50).whc_TopSpaceToView(30,self.btn_foget);
    
    self.btn_messvalidation_login.whc_CenterX(0).whc_Width(86).whc_TopSpaceToView(50,self.btn_login).whc_Height(15);
    self.lab_res.whc_CenterX(0).whc_BottomSpace(27);
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    switch (textField.tag) {
        case 100:
            [self.text_pwd becomeFirstResponder];
            return NO;
            break;
        case 101:
            
            if (![self.text_username.text isEqualToString:@""]&&![self.text_pwd.text isEqualToString:@""]) {
                [self.text_pwd resignFirstResponder];
                //执行登录
                [self Login];
            }
            return NO;
            break;
    }
    return YES;
}
//添加监听
-(void)Addobserver{

     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(handleKeyboardWillHide:)
     
                   name:UIKeyboardWillHideNotification
     
                 object:nil];
    //这里添加text的监听
    @weakify(self);
    id single = @[[self.text_username rac_textSignal],[self.text_pwd rac_textSignal]];
    [[RACSignal combineLatest:single]subscribeNext:^(RACTuple *x) {
        @strongify(self);
        
        if ([[x first] length]>0&&[[x second] length]>=6) {
            
            self.btn_login.userInteractionEnabled=YES;
            [self.btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }else{
            
            self.btn_login.userInteractionEnabled=NO;
            [self.btn_login setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
        }
        
    }];
    
}


// 键盘出现
-(void)handleKeyboardWillShow:(NSNotification *)paramNotification
{

    if ([self.text_username isFirstResponder]) {
        self.view_line_username.backgroundColor = GETMAINCOLOR;
        self.view_lin_pwd.backgroundColor = RGB(229, 229, 229);
    }else{
    
        self.view_line_username.backgroundColor = RGB(229, 229, 229);
        self.view_lin_pwd.backgroundColor = GETMAINCOLOR;
    }
    
}
// 键盘隐藏
-(void)handleKeyboardWillHide:(NSNotification *)paramNotification

{
    self.view_line_username.backgroundColor = RGB(229, 229, 229);
    self.view_lin_pwd.backgroundColor = RGB(229, 229, 229);
    
}




//忘记密码
-(void)FogetPwd{

    RegisterViewController *view = [RegisterViewController new];
    view.type = @"忘记密码";
    [self.navigationController pushViewController:view animated:YES];
    
}
//登录
-(void)Login{

    MYLOG(@"登录");
    NSDictionary *dic = @{@"username":self.text_username.text,
                          @"password":self.text_pwd.text};
    [MBProgressHUD showMessage:@"" toView:self.view];
//    [ZFCWaveActivityIndicatorView show:self.view];
    @weakify(self);
    [HttpEngine UserLogin:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [MBProgressHUD hideHUDForView:self.view];
//        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
        
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",responseObject]];
        }
        
        
    }];
}
//短信验证登录
-(void)Login_ForMes{

    RegisterViewController *view = [RegisterViewController new];
    view.type = @"验证码登录";
    [self.navigationController pushViewController:view animated:YES];
}
//注册
-(void)Res{

    RegisterViewController *view = [RegisterViewController new];
    view.type = @"注册";
    [self.navigationController pushViewController:view animated:YES];
    
}
-(void)dealloc{

     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
