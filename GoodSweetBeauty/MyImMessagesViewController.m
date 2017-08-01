//
//  MyImMessagesViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyImMessagesViewController.h"
#import "MesListTableViewCell.h"
#import "PointMesViewController.h"

@interface MyImMessagesViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}
@property(nonatomic,strong)YouAnMessageModel *MesModel;
@property(nonatomic,strong)NSMutableArray *Arr_data;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)BOOL Ispush_One;
@end

@implementation MyImMessagesViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //从接口读取
    if (self.Ispush_One) {
        self.Ispush_One = !self.Ispush_One;
        return;
    }
    [self ApiLoadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    //进行读取数据库消息
    [self LoadData];
    //添加监听通知
    
    // Do any additional setup after loading the view.
}
-(void)LoadData{

    
    NSArray *Mesarr = [WHCSqlite query:[YouAnMessageModel class]];
    if (Mesarr.count>0) {
        
        self.MesModel = Mesarr[0];

        [self.tableview reloadData];
    }
}
-(void)ApiLoadData{

    @weakify(self);
    [HttpEngine Getmessagescomplete:^(BOOL success, id responseObject) {
        @strongify(self);
            if (success) {
                
                if ([responseObject[@"total"] integerValue]!=0) {
                    
                    self.MesModel = [YouAnMessageModel whc_ModelWithJson:responseObject];
                    [WHCSqlite clear:[YouAnMessageModel class]];
                    [WHCSqlite insert:self.MesModel];
                    [self LoadData];
                }
            }
    }];

}


-(void)CreateUI{

    self.title = @"我的私信";
    self.Ispush_One = YES;
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    [self.tableview registerClass:[MesListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MesListTableViewCell class])];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];

    
    
    
    [self.view addSubview:self.tableview];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.MesModel.results.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MesListTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MesListTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellformodel:self.MesModel.results[indexPath.section]];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //取出fromid
    Results *res =  self.MesModel.results[indexPath.section];
    if (res.new_mes) {
        res.new_mes = NO;
        //更新model
        [WHCSqlite clear:[YouAnMessageModel class]];
        [WHCSqlite insert:self.MesModel];
    }
    PointMesViewController *view = [[PointMesViewController alloc]init];
    view.sessionid = res.from_member_id;
    view.name = res.from_member_name;
    [self.navigationController pushViewController:view animated:YES];
    
}




-(NSMutableArray *)Arr_data{

    if (!_Arr_data) {
        
        _Arr_data = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_data;
}
@end
