//
//  VersionInformationViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/8.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "VersionInformationViewController.h"

@interface VersionInformationViewController ()

@end

@implementation VersionInformationViewController
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

    self.title = @"版本信息";
    UIImageView *image_view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iosTemplate180"]];
    
    UILabel *lab = [UILabel new];
    [lab setFont:[UIFont systemFontOfSize:14]];
    [lab setTextColor:RGB(153, 153, 153)];
    [lab setText:[NSString stringWithFormat:@"v%@",GETAPPVERSION]];
    [lab sizeToFit];
    
    
    [self.view addSubview:image_view];
    [self.view addSubview:lab];
    
    image_view.whc_TopSpace(64).whc_Size(90,90).whc_CenterX(0);
    lab.whc_CenterX(0).whc_TopSpaceToView(10,image_view);
    
    
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
