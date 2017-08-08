//
//  FeedbackViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/8.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "FeedbackViewController.h"
#import "YouAnTextLinePositionModifier.h"

@interface FeedbackViewController ()<YYTextViewDelegate>


@property(nonatomic,strong)YYTextView *textview;

@property(nonatomic,strong)UIView *view_phone;

@property(nonatomic,strong)UIButton *btn_input;
@end

@implementation FeedbackViewController
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
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    
    self.title = @"意见反馈";
    self.textview = [YYTextView new];
    self.textview.delegate =self;
    self.textview.backgroundColor = [UIColor clearColor];
    self.textview.backgroundColor = [UIColor clearColor];
    self.textview.textColor = RGB(51, 51, 51);
    self.textview.font = [UIFont systemFontOfSize:16];
    self.textview.showsVerticalScrollIndicator =NO;
    self.textview.textContainerInset = UIEdgeInsetsMake(15, 15, 12, 15);
    self.textview.textParser = [WBStatusComposeTextParser new];
    self.textview.placeholderText = @"我要吐槽或是给点意见";
    self.textview.placeholderFont = [UIFont systemFontOfSize:16];
    self.textview.placeholderTextColor = RGB(153, 153, 153);
    self.textview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.textview becomeFirstResponder];
    
    YouAnTextLinePositionModifier *modifier = [YouAnTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"PingFang SC" size:16];
    modifier.paddingTop = 12;
    modifier.paddingBottom = 12;
    modifier.lineHeightMultiple = 1.4;
    self.textview.linePositionModifier = modifier;
    
    
    self.view_phone = [UIView new];
    self.view_phone.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [UILabel new];
    [lab setText:[BWCommon GetNSUserDefaults:@"PHONE"]];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:RGB(102, 102, 102)];
    [lab sizeToFit];
    
    
    self.btn_input = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_input.frame = CGMAKE(45, 24, SCREEN_WIDTH-90, 50);
    [self.btn_input setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    [self.btn_input setBackgroundColor:GETMAINCOLOR];
    self.btn_input.userInteractionEnabled =YES;
    [self.btn_input setTitle:@"确定" forState:UIControlStateNormal];
    self.btn_input.layer.masksToBounds = NO;
    self.btn_input.layer.cornerRadius = 25.0f;
    [self.btn_input addTarget:self action:@selector(Btn_input) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    [self.view addSubview:self.textview];
    [self.view_phone addSubview:lab];
    [self.view addSubview:self.view_phone];
    [self.view addSubview:self.btn_input];
    
    
    
    
    
    self.textview.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpace(0).whc_Height(155);
    lab.whc_LeftSpace(15).whc_TopSpace(0).whc_BottomSpace(0);
    self.view_phone.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(0,self.textview).whc_Height(50);
    self.btn_input.whc_LeftSpace(45).whc_RightSpace(45).whc_TopSpaceToView(24,self.view_phone).whc_Height(50);
    
}
-(void)Btn_input{
    
    
    
    
}
#pragma mark @protocol YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
    
    MYLOG(@"%@",textView.text);
}
@end
