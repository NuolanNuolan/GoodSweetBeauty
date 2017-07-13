//
//  CenterTwoViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterTwoViewController.h"

@interface CenterTwoViewController ()

@end

@implementation CenterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateBtn];
    // Do any additional setup after loading the view.
}
-(void)CreateBtn{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGMAKE(0, ScreenHeight-50-64, ScreenWidth, 50);
    UIView *view_line = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, 0.5)];
    view_line.backgroundColor = RGB(233, 233, 233);
    
    [view addSubview:[self CreateBtn:@"分享" imagename:@"iconShareBlue" frame:CGMAKE(0, 0, ScreenWidth/2, 50) action:@selector(Share)]];
    [view addSubview:[self CreateBtn:@"发口碑" imagename:@"iconKoubeiBlue" frame:CGMAKE(ScreenWidth/2, 0, ScreenWidth/2, 50) action:@selector(Postcomment)]] ;
    [view addSubview:view_line];
    [self.view addSubview:view];
    
}
-(UIButton *)CreateBtn:(NSString *)title imagename:(NSString *)imagename frame:(CGRect )rect action:(nonnull SEL)action{
    
    UIButton *btn_focus = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_focus.frame = rect;
    [btn_focus setTitle:title forState:UIControlStateNormal];
    [btn_focus addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn_focus.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_focus setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_focus.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_focus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_focus setTitleEdgeInsets:UIEdgeInsetsMake(0,7,0,0)];
    [btn_focus setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    return btn_focus;
}
//分享
-(void)Share{

    MYLOG(@"分享")
    
}
//发口碑
-(void)Postcomment{
     
    MYLOG(@"发口碑")
}


@end
