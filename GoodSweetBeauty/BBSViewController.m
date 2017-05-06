//
//  BBSViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSViewController.h"

@interface BBSViewController ()

@end

@implementation BBSViewController
-(void)viewWillAppear:(BOOL)animated{

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    
}


-(void)CreateUI{
    
    self.view.backgroundColor = RGB(247, 247, 247);
    self.navigationItem.title = @"有安";
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
