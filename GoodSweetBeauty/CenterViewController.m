//
//  CenterViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    
}


-(void)CreateUI{

    self.view.backgroundColor = RGB(247, 247, 247);
    self.navigationItem.title = @"我的";
    //右上角按钮
    UIBarButtonItem *Btn_Right =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconTitlebarSet"] style:UIBarButtonItemStyleDone target:self action:@selector(PushSettting)];
    
    self.navigationItem.rightBarButtonItem=Btn_Right;
}


-(void)PushSettting{

    MYLOG(@"设置");
}
@end
