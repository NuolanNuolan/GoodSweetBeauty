//
//  AuthTypeView.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AuthTypeView.h"
@interface AuthTypeView (){

    
}
//主view
@property(nonatomic,retain)UIView *main_view;
@property(nonatomic,retain)UIPickerView *Pick_type;
@property(nonatomic,retain)NSArray *Arr_type;
@property(nonatomic,retain)NSString *Str_text;;
@end
@implementation AuthTypeView
+(instancetype)alertViewWithblock:(AuthTypeBlcok )typeblock{

    AuthTypeView *view = [[AuthTypeView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    view.AuthTypeblcok = typeblock;
    
    return view;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        
        self.main_view = [[UIView alloc]initWithFrame:CGMAKE(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 250)];
        self.main_view.backgroundColor = [UIColor whiteColor];
        
        //取消确定按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.tag=0;
        [cancelBtn setTitleColor:GETFONTCOLOR forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.tag=1;
        [sureBtn setTitleColor:GETFONTCOLOR forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 229);
        
        
        
        self.Pick_type = [UIPickerView new];
        self.Pick_type.backgroundColor = [UIColor whiteColor];
        self.Pick_type.delegate = self;
        self.Pick_type.dataSource = self;
        
        [self.main_view addSubview:self.Pick_type];
        [self.main_view addSubview:view_line];
        [self.main_view addSubview:cancelBtn];
        [self.main_view addSubview:sureBtn];
        [self addSubview:self.main_view];
        
        cancelBtn.whc_LeftSpace(0).whc_TopSpace(0).whc_Height(50).whc_Width(80);
        sureBtn.whc_RightSpace(0).whc_TopSpace(0).whc_Height(50).whc_WidthEqualView(cancelBtn);
        view_line.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpace(50).whc_Height(0.5);
        
        self.Pick_type.whc_TopSpace(50).whc_BottomSpace(0).whc_Width(SCREEN_WIDTH).whc_LeftSpace(0);
        self.Arr_type = [NSArray arrayWithObjects:@"个人认证",@"企业认证", nil];
        self.Str_text = self.Arr_type[0];
        
        [self.Pick_type selectRow:0 inComponent:0 animated:NO];
        
        
        
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.Arr_type.count;
    
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    //设置线条颜色
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor =RGB(238, 238, 238);
    
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = RGB(238, 238, 238);
    
    NSString *strings = @"";
    if(pickerView == self.Pick_type)
    {
        strings = self.Arr_type[row];
    }
    return strings;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        lbl.font = [UIFont boldSystemFontOfSize:18];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        lbl.textColor = GETFONTCOLOR;
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lbl;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.Str_text = self.Arr_type[row];
    
    self.AuthTypeblcok(self.Str_text);
    
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
    if (!CGRectContainsPoint(self.main_view.frame, point))
    {
        if (self.AuthTypeblcok)
        {
            self.AuthTypeblcok(self.Str_text);
        }
        [self dismiss];
    }
}
- (void)dismiss
{
    [self removeFromSuperview];
    
}
-(void)sure{
    
    [self removeFromSuperview];
    if (self.AuthTypeblcok)
    {
        self.AuthTypeblcok(self.Str_text);
    }
}
-(void)dealloc{
    
    
    MYLOG(@"控件释放");
}


@end
