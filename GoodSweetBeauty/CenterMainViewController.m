//
//  CenterMainViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterMainViewController.h"

@interface CenterMainViewController ()<YNPageScrollViewControllerDelegate>

@end

@implementation CenterMainViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
