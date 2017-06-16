//
//  ResSetUsernameViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/13.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ResSetUsernameViewController.h"
#import "LoginTextField.h"

@interface ResSetUsernameViewController ()<UITextFieldDelegate>


//title
@property(nonatomic,strong)UILabel *lab_title;
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
//提醒
@property(nonatomic,strong)UILabel *lab_remind;
//输入密码提醒
@property(nonatomic,strong)UILabel *lab_remind_pwd;
//确定
@property(nonatomic,strong)UIButton *btn_submit;
@end

@implementation ResSetUsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self Addobserver];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.lab_title = [UILabel new];
    [self.lab_title setText:@"设置用户名和密码"];
    [self.lab_title setTextColor:RGB(51, 51, 51)];
    [self.lab_title setFont:[UIFont systemFontOfSize:24]];
    [self.lab_title sizeToFit];
    
    
    self.image_user_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconSignUsername"]];
    self.image_user_left.frame = CGMAKE(0, 19, 19, 20);
    
    self.text_username = [LoginTextField new];
    self.text_username.delegate = self;
    self.text_username.tag =100;
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
    
    
    self.lab_remind = [UILabel new];
    [self.lab_remind setTextColor:RGB(237, 67, 67)];
    [self.lab_remind setText:@"用户名4-14位字符，设置后不可更改"];
    self.lab_remind.hidden = YES;
    [self.lab_remind setFont:[UIFont systemFontOfSize:11]];
    [self.lab_remind sizeToFit];
    
    self.image_pwd_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconSignPassword"]];
    self.image_pwd_left.frame = CGMAKE(0, 17, 17, 20);
    
    self.text_pwd = [LoginTextField new];
    self.text_pwd.delegate = self;
    self.text_pwd.tag =101;
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
    
    self.lab_remind_pwd = [UILabel new];
    [self.lab_remind_pwd setTextColor:RGB(237, 67, 67)];
    [self.lab_remind_pwd setText:@"密码6-14位数字、字母、符合组合"];
    self.lab_remind_pwd.hidden = YES;
    [self.lab_remind_pwd setFont:[UIFont systemFontOfSize:11]];
    [self.lab_remind_pwd sizeToFit];
    
    self.btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_submit setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_submit setBackgroundColor:GETMAINCOLOR];
    self.btn_submit.userInteractionEnabled =NO;
    [self.btn_submit setTitle:@"确定" forState:UIControlStateNormal];
    self.btn_submit.layer.masksToBounds = YES;
    self.btn_submit.layer.cornerRadius = 25.0f;
    [self.btn_submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.lab_title];
    [self.view addSubview:self.text_username];
    [self.view addSubview:self.text_pwd];
    [self.view addSubview:self.lab_remind];
    [self.view addSubview:self.view_line_username];
    [self.view addSubview:self.view_lin_pwd];
    [self.view addSubview:self.btn_submit];
    [self.view addSubview:self.lab_remind_pwd];
    
    self.lab_title.whc_TopSpace(37).whc_CenterX(0);
    
    self.text_username.whc_LeftSpace(45).whc_RightSpace(45).whc_Height(45).whc_TopSpaceToView(50,self.lab_title);
    
    self.view_line_username.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(0.5).whc_TopSpaceToView(0,self.text_username);
    
    self.lab_remind.whc_TopSpaceToView(6,self.view_line_username).whc_LeftSpace(78);
    
    self.text_pwd.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_HeightEqualView(self.text_username).whc_TopSpaceToView(13,self.lab_remind);
    
    self.view_lin_pwd.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(0.5).whc_TopSpaceToView(0,self.text_pwd);
    
    self.lab_remind_pwd.whc_TopSpaceToView(6,self.view_lin_pwd).whc_LeftSpace(78);
    
    
    self.btn_submit.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(50).whc_TopSpaceToView(57.5,self.view_lin_pwd);

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
                [self submit];
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
            
            self.btn_submit.userInteractionEnabled=YES;
            [self.btn_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }else{
            
            self.btn_submit.userInteractionEnabled=NO;
            [self.btn_submit setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
        }
        
    }];
    
}


// 键盘出现
-(void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    if ([self.text_username isFirstResponder]) {
        self.view_line_username.backgroundColor = GETMAINCOLOR;
        self.lab_remind.hidden=NO;
        self.lab_remind_pwd.hidden =YES;
        self.view_lin_pwd.backgroundColor = RGB(229, 229, 229);
    }else{
        
        self.view_line_username.backgroundColor = RGB(229, 229, 229);
        self.lab_remind.hidden=YES;
        self.lab_remind_pwd.hidden =NO;
        self.view_lin_pwd.backgroundColor = GETMAINCOLOR;
    }
    
}
// 键盘隐藏
-(void)handleKeyboardWillHide:(NSNotification *)paramNotification

{
    self.view_line_username.backgroundColor = RGB(229, 229, 229);
    self.view_lin_pwd.backgroundColor = RGB(229, 229, 229);
    
}

//提交
-(void)submit{

    MYLOG(@"确定 %@----%@-----%@",self.phone,self.text_username.text,self.text_pwd.text);
    NSDictionary *dic = @{@"username":self.text_username.text,
                          @"password":self.text_pwd.text,
                          @"mobile":self.phone,
                          @"reg_ip":[BWCommon getIpAddresses]};
    [MBProgressHUD showMessage:@"" toView:self.view];
//    [ZFCWaveActivityIndicatorView show:self.view];
    @weakify(self);
    [HttpEngine RegistrationInput:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [MBProgressHUD hideHUDForView:self.view];
//        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            //自动登录
            [self Login];
            
        }else{
        
            if (responseObject[@"username"]) {
                
                [MBProgressHUD showError:responseObject[@"username"][0] toView:self.view];
                
            }else if (responseObject[@"mobile"]){
            
                [MBProgressHUD showError:responseObject[@"mobile"][0] toView:self.view];
            }else{
            
                [MBProgressHUD showError:@"服务器繁忙" toView:self.view];
            }
        }
        
    }];
    
}
-(void)Login{

    NSDictionary *dic = @{@"username":self.text_username.text,
                          @"password":self.text_pwd.text};
//    [MBProgressHUD showMessage:@"" toView:self.view];
    [ZFCWaveActivityIndicatorView show:self.view];
    @weakify(self);
    [HttpEngine UserLogin:dic complete:^(BOOL success, id responseObject) {
        @strongify(self);
//        [MBProgressHUD hideHUDForView:self.view];
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",responseObject]];
        }
        
        
    }];
    
}
@end
