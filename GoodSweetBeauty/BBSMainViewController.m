//
//  BBSMainViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/25.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSMainViewController.h"

@interface BBSMainViewController ()<YNPageScrollViewControllerDelegate>

@end

@implementation BBSMainViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    
//    self.navigationItem.title = @"有安";
    self.view.backgroundColor = RGB(247, 247, 247);
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconTitlebarSearch"] style:UIBarButtonItemStyleDone target:self action:@selector(PushSearch)];
    self.navigationItem.rightBarButtonItem = btn_right;
    //创建发帖按钮
    UIButton *btn_post = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_post setBackgroundImage:[UIImage imageNamed:@"iconFixedEdit"] forState:UIControlStateNormal];
    btn_post.adjustsImageWhenHighlighted = NO;
    [btn_post addTarget:self action:@selector(Btn_Posting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_post];
    btn_post.whc_RightSpace(15).whc_BottomSpace(75).whc_Size(50,50);
    
}






//发帖
-(void)Btn_Posting{
    
    MYLOG(@"发帖");
    
    
    
}
-(void)PushSearch{
    
    MYLOG(@"搜索");
    LoginViewController *view = [LoginViewController new];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}

@end
