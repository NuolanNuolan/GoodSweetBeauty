//
//  CenterViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterTableViewCell.h"

@interface CenterViewController ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UITableView *tableView;
@end



@implementation CenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    
}
-(void)CreateUI{

    self.view.backgroundColor = RGB(247, 247, 247);
    self.navigationItem.title = @"我的";
    //右上角按钮
    UIBarButtonItem *Btn_Right =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconTitlebarSet"] style:UIBarButtonItemStyleDone target:self action:@selector(PushSettting)];
    self.navigationItem.rightBarButtonItem=Btn_Right;
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.rowHeight = 50;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)return 160;
    return 0.001;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[CenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell SetSection:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [UIView new];
    if (section==0) {
        
        view.backgroundColor = GETMAINCOLOR;
        //头像
        UIImageView *image_head = [UIImageView new];
        image_head.layer.masksToBounds = YES;
        image_head.layer.cornerRadius = 40.0f;
        image_head.backgroundColor = RGB(25, 138, 240);
        //name
        UILabel *lab_name = [UILabel new];
        [lab_name setFont:[UIFont systemFontOfSize:16]];
        [lab_name setTextColor:[UIColor whiteColor]];
        [lab_name setText:@"万恶的人中赤兔"];
        [lab_name sizeToFit];
        
        UILabel *lab_balance = [UILabel new];
        [lab_balance setTextColor:RGB(242, 167, 87)];
        [lab_balance setFont:[UIFont systemFontOfSize:15]];
        
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]init];
        NSMutableAttributedString * attri1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",@"  122"]];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"iconBi"];
        attch.bounds = CGRectMake(0, -2, 17, 14);
        NSAttributedString * string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri appendAttributedString:string];
        [attri appendAttributedString:attri1];
        lab_balance.attributedText = attri;
//        [lab_balance sizeToFit];
        
        [view addSubview:image_head];
        [view addSubview:lab_name];
        [view addSubview:lab_balance];
        
        image_head.whc_TopSpace(5).whc_CenterX(0).whc_Size(80,80);
        lab_name.whc_TopSpaceToView(15,image_head).whc_CenterX(0);
        lab_balance.whc_TopSpaceToView(11.5,lab_name).whc_CenterX(0);

        
        
    }
    return view;
}
#pragma mark 事件
-(void)PushSettting{

    MYLOG(@"设置");
}
@end
