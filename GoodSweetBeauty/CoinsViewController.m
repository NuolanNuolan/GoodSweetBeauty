//
//  CoinsViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CoinsViewController.h"
#import "CoinsOneTableViewCell.h"
#import "CoinsOneTableViewCell.h"
#import "ConisTwoTableViewCell.h"
#import "HistoricalRecordViewController.h"
#import "YouAnConisRecordModel.h"
#import "HistoryCoinsTableViewCell.h"
#import "TimeHeaderFooterView.h"
#import "BuyCoinsViewController.h"

@interface CoinsViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btn_coins;
@property(nonatomic,strong)UIButton *btn_record;
@property(nonatomic,strong)UIView *view_line;
@property(nonatomic,strong)UIView *view_line_two;

//page
@property(nonatomic,assign)NSInteger page_coins;
@property(nonatomic,assign)NSInteger page_record;

//判断是否还有更多数据
@property(nonatomic,assign)BOOL isNoMoreData_coins;
@property(nonatomic,assign)BOOL isNoMoreData_record;


//兑换记录的数据
@property(nonatomic,strong)YouAnConisRecordModel *Model_Conis;
@property(nonatomic,strong)NSMutableArray *Arr_time;
@property(nonatomic,strong)NSMutableArray *Arr_show_data;
@property(nonatomic,strong)NSMutableArray *Arr_data;
@end

@implementation CoinsViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(instancetype)initWithconins:(NSInteger )conins{
    
    self = [super init];
    if (self) {
        
        self.conins = conins;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitData];
    [self CreateUI];
    //兑换记录
    [self LoadData:self.page_record type:Statusrecord];
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page_coins = 1;
    self.page_record = 1;
    self.Arr_data = [NSMutableArray arrayWithCapacity:0];
    
    
}
-(void)CreateUI{

    self.title = @"有安币商城";
    UIView *view_top = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, 76)];
    view_top.backgroundColor = RGB(250, 111, 42);
    UIImageView *image_conis = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconBiBigWhite"]];
    image_conis.frame = CGMAKE(15, 31, 17, 14);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"查看历史记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(HistoricalRecord) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.frame = CGMAKE(ScreenWidth-100, 0, 100, 76);
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGMAKE(42, 26.5, 300, 22.5)];
    [lab setText:[NSString stringWithFormat:@"%ld",(long)self.conins]];
    [lab setTextColor:[UIColor whiteColor]];
    [lab setFont:[UIFont boldSystemFontOfSize:30]];
    [view_top addSubview:image_conis];
    [view_top addSubview:btn];
    [view_top addSubview:lab];
    [self.view addSubview:view_top];
    
    UIView *view_btn = [[UIView alloc]initWithFrame:CGMAKE(0, 76, SCREEN_WIDTH, 44)];
    view_btn.backgroundColor = [UIColor whiteColor];
    self.btn_coins = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_coins setTitle:@"有安币" forState:UIControlStateNormal];
    self.btn_coins.selected=YES;
    [self.btn_coins addTarget:self action:@selector(Btn_switch:) forControlEvents:UIControlEventTouchUpInside];
    self.btn_coins.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn_coins setTitleColor:RGB(250, 111, 42) forState:UIControlStateNormal];
    
    self.btn_record = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_record setTitle:@"兑换记录" forState:UIControlStateNormal];
    self.btn_record.selected=NO;
    self.btn_record.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn_record addTarget:self action:@selector(Btn_switch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_record setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.view_line = [UIView new];
    self.view_line.backgroundColor = RGB(250, 111, 42);
    
    self.view_line_two = [UIView new];
    self.view_line_two.backgroundColor = RGB(229, 229, 229);
    
    [view_btn addSubview:self.btn_coins];
    [view_btn addSubview:self.btn_record];
    [view_btn addSubview:self.view_line];
    [view_btn addSubview:self.view_line_two];
    [self.view addSubview:view_btn];
    
    self.btn_coins.whc_LeftSpace(0).whc_TopSpace(0).whc_Height(41.5).whc_Width(SCREEN_WIDTH/2);
    self.btn_record.whc_TopSpaceEqualView(self.btn_coins).whc_RightSpace(0).whc_HeightEqualView(self.btn_coins).whc_WidthEqualView(self.btn_coins);
    self.view_line.whc_Height(2).whc_Width(85).whc_CenterXToView(0,self.btn_coins).whc_BottomSpaceToView(0,self.view_line_two);
    self.view_line_two.whc_Height(0.5).whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
    
    
    
    //表格
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-64-120) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CoinsOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellone"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConisTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"celltwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryCoinsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TimeHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([TimeHeaderFooterView class])];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if (self.btn_coins.selected) {
            
            self.page_coins = 1;
            self.isNoMoreData_coins =NO;
            [self LoadData:self.page_coins type:Statuscoins];
            
        }else{
            
            self.page_record = 1;
            self.isNoMoreData_record = NO;
            [self LoadData:self.page_record type:Statusrecord];
        }
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if (self.btn_coins.selected) {
            
            [self LoadData:++self.page_coins type:Statuscoins];
            
        }else{
            
            [self LoadData:++self.page_record type:Statusrecord];
        }
    }];

}
//切换按钮
-(void)Btn_switch:(UIButton *)sender{
    
    if(sender.selected)return;
    [sender setTitleColor:RGB(250, 111, 42) forState:UIControlStateNormal];
    self.view_line.whc_Height(2).whc_Width(85).whc_CenterXToView(0,sender).whc_BottomSpaceToView(0,self.view_line_two);
    sender.selected=YES;
    if (sender==self.btn_coins) {
        
        [self.btn_record setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        self.btn_record.selected=NO;
        MYLOG(@"有安币");
    }else{
        
        [self.btn_coins setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        self.btn_coins.selected = NO;
        MYLOG(@"兑换记录");
    }
    [self.tableView reloadData];
    [self DealWithFooter];
}
//数据
-(void)LoadData:(NSInteger )page type:(LoadDatatype )type{

    switch (type) {
        case Statuscoins:{
            
            
        }
            break;
        case Statusrecord:{
            
            @weakify(self);
            [HttpEngine CoinsRecord:self.page_record type:@"gift" complete:^(BOOL success, id responseObject) {
                @strongify(self);
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                if (success) {
                    
                    [self DataProcessing_comment:responseObject withpage:self.page_record];
                    
                    [self.tableView reloadData];
                    [self DealWithFooter];
                }
            }];
        }
            break;
    }
}
//兑换记录数据处理
-(void)DataProcessing_comment:(id )responseObject withpage:(NSInteger )page{

    if (page==1) {
        
        [self.Arr_data removeAllObjects];
    }
    if ([(NSArray *)responseObject count]<10) {
        
        self.isNoMoreData_record =YES;
        
    }
    for (NSDictionary *dic in responseObject) {
        
        self.Model_Conis = [YouAnConisRecordModel whc_ModelWithJson:dic];
        
        [self.Arr_data addObject:self.Model_Conis];
    }
    [self DealWithData];
}
//处理数据
-(void)DealWithData{
    
    NSString *str_date = @"";
    [self.Arr_show_data removeAllObjects];
    [self.Arr_time removeAllObjects];
    for (YouAnConisRecordModel *model in self.Arr_data) {
        
        model.date =[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"];
        
        if (![[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"] isEqualToString:str_date]) {
            
            str_date = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"yyyy年MM月"]];
            [self.Arr_time addObject:str_date];
            
        }
    }
    for (NSString *str_da in self.Arr_time) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date CONTAINS[cd] %@",str_da];
        NSArray *searchFoods = [self.Arr_data filteredArrayUsingPredicate:predicate];
        //添加进大数组
        [self.Arr_show_data addObject:searchFoods];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.btn_coins.selected) {
        
        return 1;
    }
    return [[self.Arr_show_data objectAtIndex:section] count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.btn_coins.selected) {
        
        switch (indexPath.section) {
            case 0:
                return 181;
                break;
            case 1:
                return 60;
                break;
        }
    }
    return 63.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (self.btn_coins.selected) {
        
        return 2;
        
    }
    return self.Arr_time.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (self.btn_coins.selected) {
        
        if (section==1) {
            return 10;
        }
        
    }
    return 0.001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (self.btn_coins.selected) {
        
        if (section==1) {
            return 10;
        }else{
        
            return 0.001;
        }
        
    }
    return 28;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.btn_coins.selected) {
     
        return nil;
    }
    TimeHeaderFooterView *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([TimeHeaderFooterView class])];
    
    [cell Settitle:self.Arr_time[section]];
    return cell;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.btn_coins.selected) {
        
        switch (indexPath.section) {
            case 0:{
                
                CoinsOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellone"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
                break;
            case 1:{
                
                ConisTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltwo"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegateSignal = [RACSubject subject];
                @weakify(self);
                [cell.delegateSignal subscribeNext:^(id x) {
                    @strongify(self);
                    
                    [self BuyYouAnCoins];
                    
                }];
                return cell;
            }
                break;
        }
        
    }
    HistoryCoinsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetModel:self.Arr_show_data[indexPath.section][indexPath.row]];
    return cell;
}






/**
 历史记录
 */
-(void)HistoricalRecord{

    HistoricalRecordViewController *view = [[HistoricalRecordViewController alloc]initWithtype:Statushiscoins];
    [self.navigationController pushViewController:view animated:YES];
}

/**
 购买有安币
 */
-(void)BuyYouAnCoins{

    [self.navigationController pushViewController:[BuyCoinsViewController new] animated:YES];
}


/**
 这里处理footer
 */
-(void)DealWithFooter{
    
    if (self.btn_coins.selected) {
        
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = YES;
//        if (self.isNoMoreData_coins) {
//            
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            
//            [self.tableView.mj_footer resetNoMoreData];
//        }
        
    }else{
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = NO;
        if (self.isNoMoreData_record) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            [self.tableView.mj_footer resetNoMoreData];
        }
        
    }
    
}

-(NSMutableArray *)Arr_time{
    
    if (!_Arr_time) {
        _Arr_time = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_time;
}
-(NSMutableArray *)Arr_show_data{
    
    if (!_Arr_show_data) {
        _Arr_show_data = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_show_data;
}
@end
