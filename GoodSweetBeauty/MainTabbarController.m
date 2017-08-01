//
//  MainTabbarController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/23.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MainTabbarController.h"
#import "CenterViewController.h"
#import "ToolsViewController.h"
#import "BBSMainViewController.h"
#import "YNTestOneViewController.h"
#import "YNTestTwoViewController.h"
#import "YNTestThreeViewController.h"





#define imageRender(imageName) [[UIImage imageNamed:(imageName)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

@interface MainTabbarController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self CreateController];

    
    
//    [self CancelTabbar];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor =GETMAINCOLOR;
//    [UITabBar appearance].translucent = NO;
    //上部分阴影
//
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}
//去掉tabbar上部分黑线
-(void)CancelTabbar
{
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    
    [self.tabBar setShadowImage:img];
}
-(void)CreateController{

    NSMutableArray *ChildVCArray = [NSMutableArray arrayWithCapacity:0];
    
    
    UIViewController *vc1 = [self CreateUIMain];
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
    
    
    [vc1.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [vc2.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                     NSForegroundColorAttributeName:[UIColor blackColor]}];
    [vc3.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [nvc1.navigationBar setTintColor:[UIColor whiteColor ]];
    [nvc2.navigationBar setTintColor:[UIColor whiteColor ]];
    [nvc3.navigationBar setTintColor:[UIColor whiteColor ]];
    
    [ChildVCArray addObject:nvc1];
    [ChildVCArray addObject:nvc2];
    [ChildVCArray addObject:nvc3];
    
    self.viewControllers = ChildVCArray;
    
    self.selectedIndex = 0;

    
}
-(UIViewController *)CreateUIMain{

    YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three = [[YNTestThreeViewController alloc]init];
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    configration.normalItemColor = RGB(51, 51, 51);
    configration.selectedItemColor = GETMAINCOLOR;
    configration.lineColor = GETMAINCOLOR;
    configration.scrollMenu =NO;
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    
    BBSMainViewController *vc = [BBSMainViewController pageScrollViewControllerWithControllers:@[one,two,three] titles:@[@"最新回复",@"最新帖子",@"精品帖子"] Configration:configration];
    vc.dataSource = self;
    
    //头部headerView
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 163)];
    //轮播器
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    NSArray *titles = @[@"我是预览文字",
                        @"我是预览文字",
                        @"我是预览文字",
                        @"我是预览文字"
                        ];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 163) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    self.cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:16];
    self.cycleScrollView.titleLabelHeight = 50;
    self.cycleScrollView.userInteractionEnabled=YES;
    self.cycleScrollView.pageControlBottomOffset = 10;
    self.cycleScrollView.pageControlRightOffset = 2;
    self.cycleScrollView.delegate =self;
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.cycleScrollView.titlesGroup = titles;

    [headerView2 addSubview:self.cycleScrollView];
    vc.headerView = headerView2;

    vc.cycleScrollViewblock = ^(id responseObject){
    
//         self.cycleScrollView.titlesGroup = responseObject;
    };
    return vc;

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"轮播图 点击 Index : %zd",index);
//    LoginViewController *view = [LoginViewController new];
//    view.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
}
- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

@end
