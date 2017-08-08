//
//  AboutUsViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/8.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
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

    self.title = @"关于我们";
    UIImageView *image_view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iosTemplate120"]];
    
    UILabel *lab = [UILabel new];
    lab.numberOfLines = 0;
    lab.attributedText = [BWCommon textWithStatus:@" 我们旨在赋能企业改变营销、销售和经营的方式。我们为商家、品牌及其他企业提供基本的互联网基础设施以及营销平台，让其可借助互联网的力量与用户和客户互动。我们的业务包括核心电商、云计算、数字媒体和娱乐以及创新项目和其他业务。我们并通过所投资的关联公司菜鸟网络及口碑，参与物流和本地服务行业，同时拥有蚂蚁金融服务集团的利润分成权益，该金融服务集团主要通过中国领先的第三方网上支付平台支付宝运营。" Atarr:nil font:[UIFont systemFontOfSize:15] LineSpacing:8 textColor:RGB(51, 51, 51) screenPadding:SCREEN_WIDTH-40];
    
    [self.view addSubview:image_view];
    [self.view addSubview:lab];
    
    image_view.whc_TopSpace(28).whc_Size(60,60).whc_CenterX(0);
    lab.whc_LeftSpace(20).whc_RightSpace(20).whc_TopSpaceToView(30,image_view);
    
    
}

@end
