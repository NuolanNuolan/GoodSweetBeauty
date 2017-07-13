//
//  CenterOneViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterOneViewController.h"

@interface CenterOneViewController ()

@end

@implementation CenterOneViewController

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
    
    [view addSubview:[self CreateBtn:@"关注" imagename:@"iconJiaBlue" frame:CGMAKE(0, 0, ScreenWidth/2, 50) action:@selector(Focus)]];
    [view addSubview:[self CreateBtn:@"私信" imagename:@"iconSixinBlue" frame:CGMAKE(ScreenWidth/2, 0, ScreenWidth/2, 50) action:@selector(PostIM)]];
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
//关注
-(void)Focus{
    
    MYLOG(@"关注")
    
}
//私信
-(void)PostIM{
    
    MYLOG(@"私信")
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
