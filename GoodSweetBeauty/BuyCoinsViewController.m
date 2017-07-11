//
//  BuyCoinsViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/11.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BuyCoinsViewController.h"

@interface BuyCoinsViewController ()


@property(nonatomic,strong)UILabel *lab_coins;
//两个数组
@property(nonatomic,copy)NSArray * arr_banlance;
@property(nonatomic,copy)NSArray * arr_coins;
@end

@implementation BuyCoinsViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self LoadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitData];
    [self CreateUI];
    
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.arr_banlance = [NSArray arrayWithObjects:@"6",@"12",@"30",@"98",@"618", nil];
    self.arr_coins = [NSArray arrayWithObjects:@"60",@"120",@"300",@"980",@"6180", nil];
}
-(void)CreateUI{

    self.title = @"我的余额";
    UIView *view_top = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, 76)];
    view_top.backgroundColor = RGB(250, 111, 42);
    UIImageView *image_conis = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconBiBigWhite"]];
    image_conis.frame = CGMAKE(15, 31, 17, 14);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"查看充值记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(HistoricalRecord) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.frame = CGMAKE(ScreenWidth-100, 0, 85, 76);
    
    self.lab_coins = [[UILabel alloc]initWithFrame:CGMAKE(42, 26.5, 300, 22.5)];
    [self.lab_coins setTextColor:[UIColor whiteColor]];
    [self.lab_coins setFont:[UIFont boldSystemFontOfSize:30]];
    [view_top addSubview:image_conis];
    [view_top addSubview:btn];
    [view_top addSubview:self.lab_coins];
    [self.view addSubview:view_top];
    
    
    UIView *view_back = [UIView new];
    view_back.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab_recommended = [UILabel new];
    [lab_recommended setText:@"充值推荐"];
    [lab_recommended setTextColor:RGB(102, 102, 102)];
    [lab_recommended setFont:[UIFont systemFontOfSize:14]];
    [lab_recommended sizeToFit];
    
    UIView *view_line = [UIView new];
    view_line.backgroundColor = RGB(233, 233, 233);
    
    
    
    
    
    
    UIButton *btn_top_up = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_top_up setTitle:@"充值" forState:UIControlStateNormal];
    [btn_top_up setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_top_up.titleLabel.font = [UIFont systemFontOfSize:16];
    btn_top_up.layer.masksToBounds =YES;
    btn_top_up.layer.cornerRadius = 20.0f;
    [btn_top_up setBackgroundColor:RGB(250, 111, 42)];
    
    
    
    [view_back addSubview:lab_recommended];
    [view_back addSubview:view_line];
    [view_back addSubview:btn_top_up];
    [self.view addSubview:view_back];
    
    //布局
    view_back.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(10,view_top).whc_Height(296);
    lab_recommended.whc_LeftSpace(15.5).whc_TopSpace(7.5).whc_Height(14);
    view_line.whc_LeftSpace(0).whc_TopSpaceToView(7,lab_recommended).whc_Height(0.5).whc_RightSpace(0);
    btn_top_up.whc_Size(191,40).whc_BottomSpace(50).whc_CenterX(0);

}

-(UIView *)CreateView:(NSString *)banlance coins:(NSString *)conis{

    UIView *view = [UIView new];
    view.userInteractionEnabled = YES;
    view.layer.masksToBounds =YES;
    view.layer.cornerRadius = 5.0f;
    view.layer.borderColor = RGB(250, 111, 42).CGColor;
    view.layer.borderWidth = 0.5f;
    
    
    
    
    
    return view;
}
//拉取最新的有安币
-(void)LoadData{

    @weakify(self);
    [HttpEngine UserDetailcomplete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            self.lab_coins.text = [NSString stringWithFormat:@"%@",responseObject[@"coins"]];
        }
    }];

    
}


-(void)HistoricalRecord{

    MYLOG(@"历史记录")
}
@end
