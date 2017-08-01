//
//  BBSMainViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/25.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSMainViewController.h"
#import "UserPostingViewController.h"

@interface BBSMainViewController ()<YNPageScrollViewControllerDelegate>

@end

@implementation BBSMainViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
//    //延迟执行
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.cycleScrollViewblock) {
//            NSArray *titles = @[@"我才是预览文字",
//                                @"我才是预览文字",
//                                @"我才是预览文字",
//                                @"我才是预览文字"
//                                ];
//            self.cycleScrollViewblock(titles);
//        }
//    });

    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    
    self.navigationItem.title = @"有安";
    self.view.backgroundColor = RGB(247, 247, 247);
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconTitlebarSearch"] style:UIBarButtonItemStyleDone target:self action:@selector(PushSearch)];
    self.navigationItem.rightBarButtonItem = btn_right;
    //创建发帖按钮
    UIButton *btn_post = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_post setBackgroundImage:[UIImage imageNamed:@"iconFixedEdit"] forState:UIControlStateNormal];
    btn_post.adjustsImageWhenHighlighted = NO;
    [btn_post addTarget:self action:@selector(Btn_Posting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_post];
    btn_post.whc_RightSpace(15).whc_BottomSpace(30).whc_Size(50,50);
    
}






//发帖
-(void)Btn_Posting{
    
    MYLOG(@"发帖");
    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    
    UserPostingViewController *view = [UserPostingViewController new];
    view.type = YouAnStatusComposeViewTypePostTing;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}
-(void)PushSearch{
    
    MYLOG(@"搜索");
//    LoginViewController *view = [LoginViewController new];
//    view.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:view animated:YES];
}

@end
