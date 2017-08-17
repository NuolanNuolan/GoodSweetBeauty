//
//  PointMesViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "PointMesViewController.h"
#import "MesDeatilTableViewCell.h"
#import "YouAnPointMessageModel.h"
#import "SendMesTextField.h"

@interface PointMesViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YYTextKeyboardObserver,UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray *Arr_data;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)YouAnPointMessageModel *model;
@property(nonatomic,assign)NSInteger userid;
@property(nonatomic,strong)UIView *view_input;
@property(nonatomic,strong)SendMesTextField *text_input;

@end

@implementation PointMesViewController
- (instancetype)init {
    self = [super init];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    return self;
}

- (void)dealloc {
    
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
    [IQKeyboardManager sharedManager].enable = NO;
    
}
- (void) viewWillDisappear: (BOOL)animated {
    
    //关闭键盘事件相应
    [IQKeyboardManager sharedManager].enable = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitData];
    
    [self CreateUI];
    //请求数据
    [self LoadData];
    [self AddKeyBord];
    
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
    self.Arr_data = [NSMutableArray arrayWithCapacity:0];
    //取出我的userid
    self.userid = [[NSUserDefaults standardUserDefaults]integerForKey:@"USERID"];
}
-(void)AddKeyBord{

    //键盘框
    
    self.view_input = [[UIView alloc]initWithFrame:CGMAKE(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
    self.view_input.backgroundColor = RGB(245, 245, 245);
//    self.view_input.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    UIView *view_line = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 0.5)];
    view_line.backgroundColor = RGB(212, 212, 212);
    self.text_input = [SendMesTextField new];
    self.text_input.layer.masksToBounds =YES;
    self.text_input.layer.cornerRadius = 4.0f;
    self.text_input.layer.borderColor = RGB(212, 212, 212).CGColor;
    self.text_input.layer.borderWidth=0.5f;
    self.text_input.returnKeyType = UIReturnKeySend;
    self.text_input.delegate =self;
    
    [self.view_input addSubview:view_line];
    [self.view_input addSubview:self.text_input];
    [self.view addSubview:self.view_input];
    
    self.text_input.whc_LeftSpace(15).whc_RightSpace(15).whc_Height(36).whc_CenterY(0);
    
    
    
    
    
}
-(void)CreateUI{

    self.title = self.name;
    self.view.backgroundColor = RGB(233, 233, 233);
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableview registerClass:[MesDeatilTableViewCell class] forCellReuseIdentifier:@"mesleft"];
    [self.tableview registerClass:[MesDeatilTableViewCell class] forCellReuseIdentifier:@"mesright"];
    self.tableview.showsVerticalScrollIndicator=NO;
    
    [self.view addSubview:self.tableview];
    
    @weakify(self);
    MJRefreshNormalHeader *header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page ++ ;
        
        [self LoadData];
        
    }];
    header.lastUpdatedTimeLabel.hidden =YES;
    header.stateLabel.hidden =YES;
    self.tableview.mj_header = header;

    
}
-(void)LoadData{

    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine GetPointMessage:self.sessionid page:self.page complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [self.tableview.mj_header endRefreshing];
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            [self DealData:self.page data:responseObject];
            
            
        }else{
            //
            [self.tableview.mj_header setHidden:YES];
        }
        
    }];
    
}
//处理数据
-(void)DealData:(NSInteger )page data:(id )responseObject{

    
    if (((NSArray *)responseObject[@"results"]).count<10) {
        
        [self.tableview.mj_header setHidden:YES];
    }
    if (page==1) {
        
        [self.Arr_data removeAllObjects];
        
        
    }
    NSMutableArray *Arr_deal = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in responseObject[@"results"]) {
        
        self.model = [YouAnPointMessageModel whc_ModelWithJson:dic];
        [Arr_deal addObject:self.model];
    }
    [self.Arr_data insertObjects:Arr_deal atIndex:0];
    if (page!=1) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:((NSArray *)responseObject[@"results"]).count inSection:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            [self.tableview reloadData];
            [self.tableview scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        });
        
    }else{
    
        [self.tableview reloadData];
        if (self.Arr_data.count!=0) {
            [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.Arr_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.Arr_data.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MesDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    _model = self.Arr_data[indexPath.row];
    MesDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_model.from_member_id==self.userid?@"mesright":@"mesleft"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self);
    cell.delegateSignal = [RACSubject subject];
    [cell.delegateSignal subscribeNext:^(id x) {
        @strongify(self);
        
        [self PushUserDeail:x];
        
    }];
    [cell SetModel:_model];
    
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    MYLOG(@"%f",scrollView.contentOffset.y)
//    [self.view endEditing:YES];
    
}
#pragma mark @protocol YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        
        self.view_input.bottom = CGRectGetMinY(toFrame);
    
    } else {
        
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.view_input.bottom = CGRectGetMinY(toFrame);
            if (CGRectGetMinY(toFrame)+64==SCREEN_HEIGHT) {
                
                self.tableview.frame = CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
                
            }else{
            
                self.tableview.frame = CGMAKE(0, 0, SCREEN_WIDTH, CGRectGetMinY(toFrame)-64+14);
                if (self.Arr_data.count != 0)
                {
                    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.Arr_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
            
        } completion:NULL];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    MYLOG(@"发送消息")
    if (![textField.text isEqualToString:@""]) {
        
        
        YouAnPointMessageModel *model = [YouAnPointMessageModel new];
        model.from_member_id = self.userid;
        model.content = textField.text;
        model.created = [[BWCommon GetNowTimestamps] integerValue];
        model.to_member_id = self.sessionid;
        
        From_member *from_membermodel = [From_member new];
        from_membermodel.avatar = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERIMAGEHEAD"];
        model.from_member=from_membermodel;
        
        [self.Arr_data addObject:model];
        [self.tableview reloadData];
        if (self.Arr_data.count != 0) {
            [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.Arr_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        [self SendMes:textField.text];
        textField.text=@"";
    }
    
    
    return YES;
}
-(void)SendMes:(NSString *)content{

    @weakify(self);
    [HttpEngine SendPointMes:self.sessionid withcontent:content complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            MYLOG(@"%@",responseObject)
            
        }else{
        
            [MBProgressHUD showError:@"发送失败" toView:self.view];
            [self.Arr_data removeLastObject];
            [self.tableview reloadData];
            if (self.Arr_data.count != 0) {
                [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.Arr_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
    }];
}
/**
 跳转用户详情
 */
-(void)PushUserDeail:(NSDictionary *)dic{

    if ([dic[@"type"]isEqualToString:@"UserDeatil"]) {
        
        [[BWCommon sharebwcommn]PushTo_UserDeatil:[dic[@"value"] integerValue] view:self];
    }
    
}
@end
