//
//  SettingViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SettingSwitchTableViewCell.h"
#import "AccountSecurityViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "VersionInformationViewController.h"

@interface SettingViewController()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SettingViewController
-(void)viewWillAppear:(BOOL)animated{

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    
    self.title = @"设置";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.rowHeight = 50;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingSwitchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView];
}
#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==4)return 70;
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0: case 2:case 3:
            return 10;
            break;
            
            default:
            return 1;
            break;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==2) {
        
        SettingSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell SetSection:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    if (section==4) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font =[UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(LoginOut) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGMAKE(0, 20, SCREEN_WIDTH, 50);
        [view addSubview:btn];
        return view;
    }
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HJViewController *view;
    switch (indexPath.section) {
        case 0:
            MYLOG(@"账号安全");
            view = [AccountSecurityViewController new];
            break;
        case 1:
            MYLOG(@"关于有安");
            view = [AboutUsViewController new];
            break;
        case 3:
            MYLOG(@"版本信息");
            view = [VersionInformationViewController new];
            break;
        case 4:
            MYLOG(@"意见反馈");
            view = [FeedbackViewController new];
            break;
    }
    view.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];
}


-(void)LoginOut{

    MYLOG(@"退出登录");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        MYLOG(@"%@",key);
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
