//
//  UserCenterDeatilViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/18.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "UserCenterDeatilViewController.h"

@interface UserCenterDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation UserCenterDeatilViewController
-(void)viewWillLayoutSubviews{
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
}
- (void)loadView{
    self.tableView = [[UITableView alloc] initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
    self.view = self.tableView;
    UIView *view_backgroud = [[UIView alloc]initWithFrame:CGMAKE(0, -1000, SCREEN_WIDTH, 1000)];
    view_backgroud.backgroundColor = GETMAINCOLOR;
    [self.view addSubview:view_backgroud];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self CreateBtn];
    // Do any additional setup after loading the view.
}
-(void)CreateBtn{

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:view];
    view.whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(50).whc_Height(50);
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)self.index);
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%tu----%@----%@",self.index,@(indexPath.section),@(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // 通过最后一个 Footer 来补高度
    
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
