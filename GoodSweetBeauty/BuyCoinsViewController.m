//
//  BuyCoinsViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/11.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BuyCoinsViewController.h"
#import "HistoricalRecordViewController.h"

@interface BuyCoinsViewController ()


@property(nonatomic,strong)UILabel *lab_coins;
//两个数组
@property(nonatomic,copy)NSArray * arr_banlance;
@property(nonatomic,copy)NSArray * arr_coins;
//保存当前选择的
@property(nonatomic,strong)NSDictionary *dic_choose;


@property(nonatomic,strong)UIImage *image1;
@property(nonatomic,strong)UIImage *image2;

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
    btn.frame = CGMAKE(ScreenWidth-100, 0, 100, 76);
    
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
    
    
    WHC_StackView *stackview = [WHC_StackView new];
    stackview.whc_Column = 3;
    stackview.whc_Edge = UIEdgeInsetsMake(0, 15, 0, 15);
    stackview.whc_HSpace = 10;
    stackview.whc_VSpace = 15;
    stackview.whc_Orientation = All;
    stackview.whc_SubViewWidth = (ScreenWidth-50)/3;
    stackview.whc_SubViewHeight = 56;
    for (int i =0; i<self.arr_coins.count; i++) {
        
        [stackview addSubview:[self CreateView:self.arr_banlance[i] coins:self.arr_coins[i] tag:i]];
    }
    [stackview whc_StartLayout];
    
    UIButton *btn_top_up = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_top_up setTitle:@"充值" forState:UIControlStateNormal];
    [btn_top_up setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_top_up.titleLabel.font = [UIFont systemFontOfSize:16];
    btn_top_up.layer.masksToBounds =YES;
    btn_top_up.layer.cornerRadius = 20.0f;
    [btn_top_up setBackgroundColor:RGB(250, 111, 42)];
    
    
    [view_back addSubview:stackview];
    [view_back addSubview:lab_recommended];
    [view_back addSubview:view_line];
    [view_back addSubview:btn_top_up];
    [self.view addSubview:view_back];
    
    //布局
    view_back.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(10,view_top).whc_Height(296);
    lab_recommended.whc_LeftSpace(15.5).whc_TopSpace(7.5).whc_Height(14);
    view_line.whc_LeftSpace(0).whc_TopSpaceToView(7,lab_recommended).whc_Height(0.5).whc_RightSpace(0);
    btn_top_up.whc_Size(191,40).whc_BottomSpace(50).whc_CenterX(0);
    stackview.whc_TopSpaceToView(20,view_line).whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpaceToView(30,btn_top_up);
}

-(UIView *)CreateView:(NSString *)banlance coins:(NSString *)coins tag:(NSInteger )i{

    UIView *view = [UIView new];
    view.userInteractionEnabled = YES;
    view.layer.masksToBounds =YES;
    view.layer.cornerRadius = 5.0f;
    view.layer.borderColor = RGB(250, 111, 42).CGColor;
    view.layer.borderWidth = 0.5f;
    view.tag = 100+i;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose_banlance:)];
    [view addGestureRecognizer:tap];
    UILabel *lab_banlance = [UILabel new];
    [lab_banlance setText:[NSString stringWithFormat:@"￥%@.00",banlance]];
    [lab_banlance setFont:[UIFont systemFontOfSize:18]];
    [lab_banlance setTextColor:RGB(250, 111, 42)];
    [lab_banlance sizeToFit];
    
    
    
    
    UIView *view_coins = [UIView new];
    view_coins.backgroundColor  = [UIColor clearColor];
    UIImageView *image_view = [[UIImageView alloc]initWithImage:self.image1];
    
    UILabel *lab_coins = [UILabel new];
    [lab_coins setText:[NSString stringWithFormat:@" %@",coins]];
    [lab_coins setFont:[UIFont systemFontOfSize:15]];
    [lab_coins setTextColor:RGB(51, 51, 51)];
    [lab_coins sizeToFit];
    
    [view_coins addSubview:image_view];
    [view_coins addSubview:lab_coins];

    
    [view addSubview:lab_banlance];
    [view addSubview:view_coins];
    
    lab_banlance.whc_TopSpace(10).whc_Height(14).whc_CenterX(0);
    view_coins.whc_TopSpaceToView(10,lab_banlance).whc_CenterX(0).whc_WidthAuto().whc_HeightAuto();
    image_view.whc_Size(12,10).whc_LeftSpace(0).whc_CenterYToView(0,lab_coins).whc_RightSpaceToView(0,lab_coins);
    lab_coins.whc_TopSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
    
    
    
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

-(void)choose_banlance:(UITapGestureRecognizer *)tap{

    tap.view.backgroundColor = RGB(255, 111, 42);
    self.dic_choose = @{@"banlance":self.arr_banlance[tap.view.tag-100],
                        @"coins":self.arr_coins[tap.view.tag-100]};
    MYLOG(@"选择: %@",self.dic_choose);
    for (UIView *subviews in tap.view.subviews) {
        if ([[subviews class]isSubclassOfClass:[UILabel class]]) ((UILabel *)subviews).textColor = [UIColor whiteColor];
        else{
        
            for (UIView *subview_view in subviews.subviews) {
                
                if ([[subview_view class]isSubclassOfClass:[UIImageView class]]) ((UIImageView *)subview_view).image = self.image2;
                else ((UILabel *)subview_view).textColor = [UIColor whiteColor];
            }
        }
    }
    
    for (int i =100; i<100+self.arr_coins.count; i++) {
        if (i!=tap.view.tag) {
            
            UIView *view = [self.view viewWithTag:i];
            view.backgroundColor = [UIColor whiteColor];
            for (UIView *subviews in view.subviews) {
                if ([[subviews class]isSubclassOfClass:[UILabel class]]) ((UILabel *)subviews).textColor = RGB(255, 111, 42);
                else{
                    for (UIView *subview_view in subviews.subviews) {
                        
                        if ([[subview_view class]isSubclassOfClass:[UIImageView class]])  ((UIImageView *)subview_view).image = self.image1;
                        else ((UILabel *)subview_view).textColor = RGB(51, 51, 51);
                    }
                }
            }
        }
    }
    
}
-(void)HistoricalRecord{

    HistoricalRecordViewController *view = [[HistoricalRecordViewController alloc]initWithtype:Statustopinrecord];
    [self.navigationController pushViewController:view animated:YES];
}
-(UIImage *)image1{

    if (!_image1) {
        
        _image1  = [UIImage imageNamed:@"iconBiSmGold"];
    }
    return _image1;
}
-(UIImage *)image2{
    
    if (!_image2) {
        
        _image2  = [UIImage imageNamed:@"iconBiSmWhite"];
    }
    return _image2;
}
@end
