//
//  ToolsViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ToolsViewController.h"
#import "CustomTextField.h"

@interface ToolsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@property(nonatomic,strong)CustomTextField *text_search;
@end

@implementation ToolsViewController
-(void)viewWillAppear:(BOOL)animated{

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    
}


-(void)CreateUI{
    
    self.view.backgroundColor = RGB(247, 247, 247);
    self.navigationItem.title = @"工具";
    //搜索框
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    //左视图
    UIView *view_left = [[UIView alloc]initWithFrame:CGMAKE(0, 0, 28, 28)];
    view_left.backgroundColor = [UIColor clearColor];
    UIImageView *image_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search-Glyph"]];
    image_left.frame = CGMAKE(7, 8, 13.5, 13.5);
    
    [view_left addSubview:image_left];
    
    
    self.text_search = [[CustomTextField alloc]initWithFrame:CGMAKE(8, 8, ScreenWidth-16, 28)];
    self.text_search.placeholder = @"搜索内容";
    self.text_search.layer.masksToBounds =YES;
    self.text_search.layer.cornerRadius = 14.0f;
    self.text_search.backgroundColor = RGB(234, 235, 236);
    self.text_search.leftView = view_left;
    self.text_search.leftViewMode = UITextFieldViewModeAlways;
    self.text_search.tintColor = GETMAINCOLOR;
    self.text_search.font = [UIFont systemFontOfSize:14];
    self.text_search.textColor = GETFONTCOLOR;
    UIColor * color = RGB(153, 153, 153);
    [self.text_search setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    UIFont * font = [UIFont systemFontOfSize:14];
    [self.text_search setValue:font forKeyPath:@"_placeholderLabel.font"];
    self.text_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text_search.returnKeyType =UIReturnKeySearch;
    @weakify(self);
    [[self.text_search rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
//        [self SearchUsername:x];
    }];
    
    [view addSubview:self.text_search];
    [self.view addSubview:view];

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
