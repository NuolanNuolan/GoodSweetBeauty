//
//  ResSendCodeViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/13.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ResSendCodeViewController.h"
#import "ResSetUsernameViewController.h"
#import "SetPwdViewController.h"

@interface ResSendCodeViewController (){

    dispatch_source_t _timer;
    int timeout;
    
}


//手机号 view
@property(nonatomic,strong)UIView *view_phone;
//titlelab
@property(nonatomic,strong)UILabel *lab_title;
//手机号
@property(nonatomic,strong)UILabel *lab_phone;
//验证码输入框
@property(nonatomic,strong)UITextField *text_code;
//线
@property(nonatomic,strong)UIView *view_line;
//验证码倒计时按钮
@property(nonatomic,strong)UIButton *btn_code;
//submit
@property(nonatomic,strong)UIButton *btn_submit;
@end

@implementation ResSendCodeViewController
- (void)viewWillDisappear:(BOOL)animated
{
    //置空
    _timer=nil;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateUI];
    [self Addobserver];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    if ([self.type isEqualToString:@"注册"]) self.title = @"注册";
    else if ([self.type isEqualToString:@"验证码登录"])self.title = @"登录";
    else  self.title = @"输入验证码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view_phone = [UIView new];
    self.view_phone.backgroundColor = RGB(247, 247, 247);
    
    self.lab_title = [UILabel new];
    [self.lab_title setText:@"已发送短信验证码到"];
    [self.lab_title setTextColor:RGB(51, 51, 51)];
    [self.lab_title setFont:[UIFont systemFontOfSize:18]];
    [self.lab_title sizeToFit];
    
    self.lab_phone = [UILabel new];
    [self.lab_phone setText:[NSString stringWithFormat:@"+86 %@",self.phone]];
    [self.lab_phone setTextColor:RGB(51, 51, 51)];
    [self.lab_phone setFont:[UIFont boldSystemFontOfSize:22]];
    [self.lab_phone sizeToFit];
    
    [self.view_phone addSubview:self.lab_phone];
    [self.view_phone addSubview:self.lab_title];
    
    
    
    //右视图按钮
    self.btn_code = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_code setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
    self.btn_code.frame = CGMAKE(0, 21, 102, 25);
    self.btn_code.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn_code.layer.masksToBounds =YES;
    [self.btn_code addTarget:self action:@selector(re_sendMes) forControlEvents:UIControlEventTouchUpInside];
    self.btn_code.layer.cornerRadius = 12.5f;
    self.btn_code.layer.borderWidth = 0.5f;
    self.btn_code.layer.borderColor = RGB(136, 136, 136).CGColor;
    
    
    
    self.text_code = [UITextField new];
    //    self.text_username.delegate = self;
    //    self.text_username.backgroundColor = [UIColor redColor];
    [self.text_code setTintColor:GETMAINCOLOR];
    [self.text_code setFont:[UIFont boldSystemFontOfSize:18]];
    [self.text_code setTextColor:RGB(51, 51, 51)];
    [self.text_code setKeyboardType:UIKeyboardTypeNumberPad];
    [self.text_code setReturnKeyType:UIReturnKeyNext];
    self.text_code.rightView = self.btn_code;
    self.text_code.rightViewMode = UITextFieldViewModeAlways;
    [self.text_code setPlaceholder:@"请输入验证码"];
    UIColor * color = RGB(153, 153, 153);
    [self.text_code setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    UIFont * font = [UIFont systemFontOfSize:16];
    [self.text_code setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    self.view_line = [UIView new];
    self.view_line.backgroundColor = RGB(229, 229, 299);
    
    self.btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_submit setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_submit setBackgroundColor:GETMAINCOLOR];
    self.btn_submit.userInteractionEnabled =NO;
    [self.btn_submit setTitle:@"提交" forState:UIControlStateNormal];
    self.btn_submit.layer.masksToBounds = YES;
    self.btn_submit.layer.cornerRadius = 25.0f;
    [self.btn_submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.view_phone];
    [self.view addSubview:self.text_code];
    [self.view addSubview:self.view_line];
    [self.view addSubview:self.btn_submit];
    
    
    self.view_phone.whc_TopSpace(0).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(118.5);
    self.lab_title.whc_TopSpace(36.5).whc_CenterX(0);
    self.lab_phone.whc_TopSpaceToView(10,self.lab_title).whc_CenterX(0);
    
    self.text_code.whc_LeftSpace(45).whc_RightSpace(45).whc_Height(45).whc_TopSpaceToView(15,self.view_phone);
    
    self.view_line.whc_LeftSpaceEqualView(self.text_code).whc_RightSpaceEqualView(self.text_code).whc_TopSpaceToView(0,self.text_code).whc_Height(0.5);
    
    self.btn_submit.whc_LeftSpaceEqualView(self.text_code).whc_RightSpaceEqualView(self.text_code).whc_Height(50).whc_TopSpaceToView(40,self.view_line);
    //开启倒计时
    [self StartCcountdown];
}
//倒计时
-(void)StartCcountdown{

    timeout=60;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时结束
                self.btn_code.userInteractionEnabled=YES;
                [self.btn_code setTitle:@"重新获取" forState:UIControlStateNormal];
            });
        }else{
            NSString* strTime=[NSString stringWithFormat:@"重新获取(%d)",(int)(timeout)];
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时
                self.btn_code.userInteractionEnabled=NO;
                [self.btn_code setTitle:strTime forState:UIControlStateNormal];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

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
    [[self.text_code rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
        if ([x length]==4) {
            self.btn_submit.userInteractionEnabled = YES;
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
    
    self.view_line.backgroundColor = GETMAINCOLOR;
    
    
}
// 键盘隐藏
-(void)handleKeyboardWillHide:(NSNotification *)paramNotification

{
    self.view_line.backgroundColor = RGB(229, 229, 229);
    
}

//提交
-(void)submit{
    
    //首先判断验证码
    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine Mescheck:self.phone Type:[self.type isEqualToString:@"注册"]?@"register":@"forgetpwd" code:self.text_code.text complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
         
            //根据type跳转不同页面
            if ([self.type isEqualToString:@"验证码登录"]) {
                
                MYLOG(@"直接登录");
                
                
            }else if ([self.type isEqualToString:@"注册"]){
                MYLOG(@"注册");
                ResSetUsernameViewController *view = [ResSetUsernameViewController new];
                view.phone = self.phone;
                [self.navigationController pushViewController:view animated:YES];
                
            }else{
                
                MYLOG(@"重新设置密码");
                SetPwdViewController *view = [SetPwdViewController new];
                [self.navigationController pushViewController:view animated:YES];
            }
            
            
        }else{
        
            if (responseObject) {
                
                [MBProgressHUD showError:responseObject toView:self.view];
            }
        }
    }];
    
}
//重新获取验证码
-(void)re_sendMes{

    MYLOG(@"重新获取验证码 我的类型是--%@",self.type);
    @weakify(self)
    [HttpEngine SendMes:self.phone Type:[self.type isEqualToString:@"注册"]?@"register":@"forgetpwd" complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            [MBProgressHUD showSuccess:@"发送成功"];
            //重新计时
            [self StartCcountdown];
            
            
        }else{
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
            
        }
    }];
}
@end
