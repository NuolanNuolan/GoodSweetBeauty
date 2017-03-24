//
//  HJViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

//所有页面全部继承与这个父Controller

#import "HJViewController.h"

@interface HJViewController ()
//无网络时lable
@property(nonatomic,strong)  UILabel *label_Network;

@end

@implementation HJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
    
    //注册网络通知只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       [self RegistryNetworkNotice];
        
    });

    // Do any additional setup after loading the view.
}

-(void)RegistryNetworkNotice{

    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                MYLOG(@"未知网络也是网络");
                [self removeLable];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                MYLOG(@"无网络");
                [self showNoNetWorkUI];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                MYLOG(@"手机自带网络");
                [self removeLable];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                MYLOG(@"WIFI");
                [self removeLable];
                break;
        }
    }];
}
//无网络时弹出框
- (void)showNoNetWorkUI{
    
    self.label_Network = [[UILabel alloc] init];
    self.label_Network.text = @"无网络连接";
    self.label_Network.textColor = [UIColor whiteColor];
    self.label_Network.backgroundColor = [UIColor blackColor];
    self.label_Network.textAlignment = NSTextAlignmentCenter;
    self.label_Network.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:self.label_Network];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:self.label_Network];
    [self.label_Network mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.offset(20);
        make.height.mas_equalTo(20);
    }];
}
//移除无网络lable
-(void)removeLable
{
    
    [self.label_Network removeFromSuperview];
    self.label_Network = nil;
}

@end
