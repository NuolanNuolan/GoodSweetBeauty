//
//  YNTestThreeViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNTestThreeViewController.h"

@implementation YNTestThreeViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing];
        
    });
//    [self.tableView.mj_header beginRefreshing];

    
}


@end
