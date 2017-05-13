//
//  RegisterViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/13.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginTextField.h"

@interface RegisterViewController ()




//logo
@property(nonatomic,strong)UIImageView *image_logo;
//用户名左视图
@property(nonatomic,strong)UIImageView *image_user_left;
//用户名输入框
@property(nonatomic,strong)LoginTextField *text_username;
//用户框下面的线
@property(nonatomic,strong)UIView *view_line_username;
//注册按钮
@property(nonatomic,strong)UIButton *btn_res;
//用户协议
@property(nonatomic,strong)UILabel *lab_userdelegate;


@end

@implementation RegisterViewController
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
    [self Addobserver];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.image_logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Loginlogo"]];
    
    self.image_user_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconSignMobile"]];
    self.image_user_left.frame = CGMAKE(0, 19, 13, 20);
    
    self.text_username = [LoginTextField new];
//    self.text_username.delegate = self;
    //    self.text_username.backgroundColor = [UIColor redColor];
    [self.text_username setTintColor:GETMAINCOLOR];
    [self.text_username setFont:[UIFont boldSystemFontOfSize:18]];
    [self.text_username setTextColor:RGB(51, 51, 51)];
    [self.text_username setReturnKeyType:UIReturnKeyNext];
    self.text_username.leftView = self.image_user_left;
    self.text_username.leftViewMode = UITextFieldViewModeAlways;
    [self.text_username setPlaceholder:@"请输入手机号码"];
    UIColor * color = RGB(153, 153, 153);
    [self.text_username setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    UIFont * font = [UIFont systemFontOfSize:16];
    [self.text_username setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    self.view_line_username = [UIView new];
    self.view_line_username.backgroundColor = RGB(229, 229, 229);

    self.btn_res = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_res setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_res setBackgroundColor:GETMAINCOLOR];
    self.btn_res.userInteractionEnabled =NO;
    [self.btn_res setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    self.btn_res.layer.masksToBounds = YES;
    self.btn_res.layer.cornerRadius = 25.0f;
    [self.btn_res addTarget:self action:@selector(sendcode) forControlEvents:UIControlEventTouchUpInside];
    
    self.lab_userdelegate = [UILabel new];
    [self.lab_userdelegate setTextColor:RGB(102, 102, 102)];
    [self.lab_userdelegate setFont:[UIFont systemFontOfSize:12]];
    [self.lab_userdelegate setAttributedText:[BWCommon setupAttributeString:@"我已阅读并同意 用户注册协议" highlightText:@"用户注册协议" collor:GETMAINCOLOR]];
    [self.lab_userdelegate sizeToFit];
    self.lab_userdelegate.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userdelegate)];
    [self.lab_userdelegate addGestureRecognizer:tap];
    
    
    [self.view addSubview:self.image_logo];
    [self.view addSubview:self.text_username];
    [self.view addSubview:self.view_line_username];
    [self.view addSubview:self.btn_res];
    [self.view addSubview:self.lab_userdelegate];
    
    self.image_logo.whc_TopSpace(35).whc_Size(80,80).whc_CenterX(0);
    
    self.text_username.whc_LeftSpace(45).whc_RightSpace(45).whc_Height(45).whc_TopSpaceToView(30,self.image_logo);
    
    self.view_line_username.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(0.5).whc_TopSpaceToView(0,self.text_username);
    
    self.btn_res.whc_LeftSpaceEqualView(self.text_username).whc_RightSpaceEqualView(self.text_username).whc_Height(50).whc_TopSpaceToView(40,self.view_line_username);

    self.lab_userdelegate.whc_CenterX(0).whc_TopSpaceToView(20,self.btn_res);
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
    [[self.text_username rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
        if ([x length]==11) {
            self.btn_res.userInteractionEnabled = NO;
            [self.btn_res setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
        
            self.btn_res.userInteractionEnabled=NO;
            [self.btn_res setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
        }
        
    }];
    
}


// 键盘出现
-(void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    self.view_line_username.backgroundColor = GETMAINCOLOR;

    
}
// 键盘隐藏
-(void)handleKeyboardWillHide:(NSNotification *)paramNotification

{
    self.view_line_username.backgroundColor = RGB(229, 229, 229);
    
}





//获取验证码
-(void)sendcode{

    
}
//用户协议
-(void)userdelegate{

    
}
@end
