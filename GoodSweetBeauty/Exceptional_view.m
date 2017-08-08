//
//  Exceptional_view.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/4.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "Exceptional_view.h"
@interface Exceptional_view(){

    
}
@property(nonatomic,copy)exceptionalBlock exceptional_block;
//打赏金额列表
@property(nonatomic,copy)NSArray *Arr_Amount;
//余额
@property(nonatomic,assign)NSInteger balance;
//打赏文字
@property(nonatomic,copy)NSString *title;


//主view
@property(nonatomic,retain)UIView *view_main;
//打赏 view
@property(nonatomic,retain)UIView *view_except;
//title
@property(nonatomic,retain)UILabel *lab_title;
//可用余额
@property(nonatomic,retain)UILabel *lab_balance;
//分割线
@property(nonatomic,retain)UIView *view_line;
//stackview
@property(nonatomic,retain)WHC_StackView *stackview;
//打赏按钮
@property(nonatomic,retain)UIButton *btn_except;

//传出去的打赏金额
@property(nonatomic,assign)NSInteger choose_balance;


@end
@implementation Exceptional_view



//传入有安币余额 以及打赏金额列表
+(instancetype)alertViewExceptional:(NSInteger )balance
                         withAmount:(NSArray *)Arr_Amount
                       except_title:(NSString *)title
              exceptionalblockclick:(exceptionalBlock)exceptionalblock{
    
    return [[self alloc]initWithalertViewExceptional:balance withAmount:Arr_Amount except_title:title exceptionalblockclick:exceptionalblock];
    
}
-(instancetype)initWithalertViewExceptional:(NSInteger )balance
                                 withAmount:(NSArray *)Arr_Amount
                               except_title:(NSString *)title
                      exceptionalblockclick:(exceptionalBlock)exceptionalblock{

    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.Arr_Amount = [NSArray arrayWithArray:Arr_Amount];
        self.balance = balance;
        self.exceptional_block = exceptionalblock;
        self.title = title;
        //布局
        [self InitFarme];
        //需要联网获取自己的有安币数量
        [self LoadCoins];
    }
    return self;
}
-(void)InitFarme{

    self.choose_balance = 0;
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    self.view_main = [UIView new];
    self.view_main.backgroundColor = [UIColor clearColor];
    
    self.view_except = [UIView new];
    self.view_except.backgroundColor = [UIColor whiteColor];
    
    self.lab_title = [UILabel new];
    [self.lab_title sizeToFit];
    [self.lab_title setFont:[UIFont systemFontOfSize:14]];
    [self.lab_title  setText:self.title];
    [self.lab_title setTextColor:RGB(51, 51, 51)];
    
    self.lab_balance = [UILabel new];
    [self.lab_balance sizeToFit];
    [self.lab_balance  setFont:[UIFont systemFontOfSize:16]];
    [self.lab_balance setTextColor:RGB(250, 111, 42)];
    [self.lab_balance setText:[NSString stringWithFormat:@"可用有安币: %ld",(long)self.balance]];
    
    self.view_line = [UIView new];
    self.view_line.backgroundColor = RGB(233, 233, 233);
    
    self.stackview = [WHC_StackView new];
    self.stackview.backgroundColor = [UIColor whiteColor];
    self.stackview.whc_Column = 3;               // 最大几列
    self.stackview.whc_Edge = UIEdgeInsetsMake(15, 25, 25, 25);  // 内边距
    self.stackview.whc_HSpace = 10;                // 图片之间的空隙为
    self.stackview.whc_VSpace = 15;                 //垂直间隙
    self.stackview.whc_SubViewWidth = (SCREEN_WIDTH-70)/3;
    self.stackview.whc_SubViewHeight = 56;
    
    self.stackview.whc_Orientation = All;        // 横竖混合布局
    
    for (NSString *str in self.Arr_Amount) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:RGB(250, 111, 42) forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn addTarget:self action:@selector(choose_click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag  = [str integerValue];
        btn.layer.masksToBounds =YES;
        btn.layer.cornerRadius = 5.0f;
        btn.layer.borderColor = RGB(250, 111, 42).CGColor;
        btn.layer.borderWidth = 0.5f;
        [self.stackview addSubview:btn];
    }
    
    
    self.btn_except = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_except setBackgroundColor:[UIColor whiteColor]];
    [self.btn_except setTitle:@"打赏" forState:UIControlStateNormal];
    [self.btn_except addTarget:self action:@selector(except_click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_except setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    self.btn_except.titleLabel.font = [UIFont systemFontOfSize:16];
    

    [self.view_except addSubview:self.lab_title];
    [self.view_except addSubview:self.lab_balance];
    [self.view_except addSubview:self.view_line];
    [self.view_except addSubview:self.stackview];
    [self.view_main addSubview:self.view_except];
    [self.view_main addSubview:self.btn_except];
    [self addSubview:self.view_main];
    
    self.view_main.whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0).whc_Height(302.5);
    
    self.view_except.whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpaceToView(-8,self.btn_except).whc_Height(238.5);
    
    self.btn_except.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(56).whc_BottomSpace(0);
    
    self.lab_title.whc_TopSpace(17).whc_CenterX(0);
    
    self.lab_balance.whc_TopSpaceToView(8,self.lab_title).whc_CenterX(0);
    
    self.view_line.whc_Width(ScreenWidth-20).whc_CenterX(0).whc_Height(0.5);
    
    self.stackview.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(0,self.view_line).whc_BottomSpace(0).whc_Height(168).whc_CenterX(0);
    


    [self.stackview whc_StartLayout];
    
    
    
    
    
}
-(void)choose_click:(UIButton *)btn_choose{

    self.choose_balance = btn_choose.tag;
    btn_choose.selected = YES;
    [btn_choose setBackgroundColor:RGB(250, 111, 42)];
    for (NSString *str in self.Arr_Amount) {
        
        if ([str integerValue]!=btn_choose.tag) {
            
            UIButton *btn = [self viewWithTag:[str integerValue]];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.selected = NO;
        }
        
    }
}
-(void)show{

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.view_main.frame, point))
    {
        [self dismiss];
    }
}
- (void)dismiss
{
    [self removeFromSuperview];
    
    
}
-(void)except_click{

    if (self.choose_balance == 0) return;
    if (self.exceptional_block) {
        
        self.exceptional_block(self,self.choose_balance);
    }
}
- (void)dealloc
{
    
    MYLOG(@"view dealloc");
    
    
}
-(void)LoadCoins{
    
    @weakify(self);
    [HttpEngine UserDetailcomplete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            self.balance = [responseObject[@"coins"] integerValue];
            [self.lab_balance setText:[NSString stringWithFormat:@"可用有安币: %ld",(long)self.balance]];
        }else{
        
            [self.lab_balance setText:[NSString stringWithFormat:@"获取可用有安币失败"]];
        }
    }];
}
@end
