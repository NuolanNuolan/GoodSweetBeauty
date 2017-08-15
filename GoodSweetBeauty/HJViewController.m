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
- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateHJUI];
    [self NextViewBack];
    //注册网络通知只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       [self RegistryNetworkNotice];
        
        
    });
    // Do any additional setup after loading the view.
}

-(void)CreateHJUI{

    self.view.backgroundColor = RGB(247, 247, 247);
    
}
-(void)NextViewBack{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@""
                                                                style:UIBarButtonItemStylePlain
                                                               target:nil
                                                               action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"titlebarArrowWhite"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"titlebarArrowWhite"];
    self.navigationItem.backBarButtonItem = backItem;
    
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

/**
 注册HUD
 */
-(void)RegisteredHud{

    
}
//无网络时弹出框
- (void)showNoNetWorkUI{
    
    self.label_Network = [[UILabel alloc] init];
    self.label_Network.text = @"无网络连接";
    self.label_Network.textColor = [UIColor whiteColor];
    self.label_Network.backgroundColor = [UIColor blackColor];
    self.label_Network.textAlignment = NSTextAlignmentCenter;
    self.label_Network.font = [UIFont systemFontOfSize:14];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:self.label_Network];
    self.label_Network.whc_LeftSpace(0)
    .whc_RightSpace(0)
    .whc_TopSpace(20)
    .whc_Height(20);
}
//移除无网络lable
-(void)removeLable
{
    
    [self.label_Network removeFromSuperview];
    self.label_Network = nil;
}

@end
