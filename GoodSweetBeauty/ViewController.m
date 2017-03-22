//
//  ViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/21.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                MYLOG(@"未知网络");
                break;
                // 无网络
            case PPNetworkStatusNotReachable:
                MYLOG(@"无网络,加载缓存数据");
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                MYLOG(@"手机网络");
                break;
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                MYLOG(@"有网络,请求网络数据");
                break;
        }
        
    }];
    
    [HttpEngine TestNetWorkcomplete:^(id responseObject) {
       
        MYLOG(@"请求成功");
    }];
    GCD_AFTER(5,
    [HttpEngine TestNetWorkcomplete:^(id responseObject) {
        
        MYLOG(@"请求成功");
    }];
              );
    

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
