//
//  MyImMessagesViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyImMessagesViewController.h"

@interface MyImMessagesViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation MyImMessagesViewController
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
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.title = @"我的私信";
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.superViewController = self;
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
    self.tableview.rowHeight = 90;
    
    
    
    [self.view addSubview:self.tableview];
    
}


@end
