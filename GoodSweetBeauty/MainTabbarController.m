//
//  MainTabbarController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/23.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MainTabbarController.h"
#import "CenterViewController.h"
#import "BBSViewController.h"
#import "ToolsViewController.h"




#define imageRender(imageName) [[UIImage imageNamed:(imageName)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self CreateController];
    
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor =GETMAINCOLOR;

}
-(void)CreateController{

    NSMutableArray *ChildVCArray = [NSMutableArray arrayWithCapacity:0];
    BBSViewController *vc1 = [BBSViewController new];
    ToolsViewController *vc2 = [ToolsViewController new];
    CenterViewController *vc3 = [CenterViewController new];
    vc1.tabBarItem.title = @"论坛";
    vc2.tabBarItem.title = @"工具";
    vc3.tabBarItem.title = @"我的";
    
    vc1.tabBarItem.image = imageRender(@"iconBottombarHomeDef");
    vc1.tabBarItem.selectedImage = imageRender(@"iconBottombarHomeCur");
    
    vc2.tabBarItem.image = imageRender(@"iconBottombarToolDef");
    vc2.tabBarItem.selectedImage = imageRender(@"iconBottombarToolCur");
    
    vc3.tabBarItem.image = imageRender(@"iconBottombarMeDef");
    vc3.tabBarItem.selectedImage = imageRender(@"iconBottombarMeCur");
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GETMAINCOLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    vc1.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    vc2.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    vc3.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    
    vc1.navigationController.navigationBar.translucent = NO;
    vc2.navigationController.navigationBar.translucent = NO;
    vc3.navigationController.navigationBar.translucent = NO;
    
    
    [vc1.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [vc2.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                     NSForegroundColorAttributeName:[UIColor blackColor]}];
    [vc3.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [nvc1.navigationBar setTintColor:[UIColor whiteColor ]];
    [nvc2.navigationBar setTintColor:[UIColor whiteColor ]];
    [nvc3.navigationBar setTintColor:[UIColor whiteColor ]];
    
    [ChildVCArray addObject:nvc1];
    [ChildVCArray addObject:nvc2];
    [ChildVCArray addObject:nvc3];
    
    self.viewControllers = ChildVCArray;
    
    self.selectedIndex = 2;

    
}



@end
