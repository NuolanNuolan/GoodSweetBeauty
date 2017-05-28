//
//  CenterBaseViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterBaseViewController.h"

@interface CenterBaseViewController ()<YNPageScrollViewControllerDataSource>

@end

@implementation CenterBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%tu----%@----%@",self.ynPageScrollViewController.pageIndex,@(indexPath.section),@(indexPath.row)];
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


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view_backgroud = [[UIView alloc]initWithFrame:CGMAKE(0, -1000, SCREEN_WIDTH, 1000)];
        view_backgroud.backgroundColor = GETMAINCOLOR;
        [_tableView addSubview:view_backgroud];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
    
};

@end
