//
//  SearchViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomTextField.h"
#import "YouAnSearchMemberModel.h"
#import "YouAnSearchThreadsModel.h"
#import "MyFansTableViewCell.h"
#import "SearchThreadsTableViewCell.h"
#import "PostingDeatilViewController.h"
typedef NS_ENUM(NSUInteger, YouANSearchType) {
    
    YouAnStatusSearchUser,  ///< user
    YouAnStatusSearchThreads, ///< 帖子
    YouAnStatusSearchNoDeatil, ///< 没有
    YouAnStatusSearchAll,      ///<都有
    
};


@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>

@property(nonatomic, assign) YouANSearchType type;

@property(nonatomic,strong)YouAnBusinessCardModel * BusinessModel;

//添加一个bool值判断是否展现查看更多用户按钮
@property(nonatomic,assign)BOOL isShowMoreUser;

@property(nonatomic,strong)CustomTextField *text_search;
@property(nonatomic,strong)YouAnSearchMemberModel *Model_Members;
@property(nonatomic,strong)YouAnSearchThreadsModel *Model_Threads;

@property(nonatomic,strong)UITableView *tableview;

//两个page
@property(nonatomic,assign)NSInteger page_member;
@property(nonatomic,assign)NSInteger page_threads;
//两个arr
@property(nonatomic,strong)NSMutableArray *arr_member;
@property(nonatomic,strong)NSMutableArray *arr_threads;

//headview
@property(nonatomic,strong)UIView *view_head_member;
@property(nonatomic,strong)UIView *view_head_threads;

//footerview
@property(nonatomic,strong)UIView *view_foot_member;

//定义keyword
@property(nonatomic,copy)NSString *str_keyword;
@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;

    [self.navigationController.navigationBar setTintColor:GETMAINCOLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self InitData];
    
}
-(void)CreateUI{

    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(Pop_view)];
    self.navigationItem.rightBarButtonItem = btn_right;
    //搜索框
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth-63, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    //左视图
    UIView *view_left = [[UIView alloc]initWithFrame:CGMAKE(0, 0, 28, 28)];
    view_left.backgroundColor = [UIColor clearColor];
    UIImageView *image_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search-Glyph"]];
    image_left.frame = CGMAKE(7, 8, 13.5, 13.5);
    
    [view_left addSubview:image_left];
    
    
    self.text_search = [[CustomTextField alloc]initWithFrame:CGMAKE(0, 8, ScreenWidth-63, 28)];
    self.text_search.placeholder = @"搜索内容";
    self.text_search.layer.masksToBounds =YES;
    self.text_search.layer.cornerRadius = 14.0f;
    self.text_search.backgroundColor = RGB(234, 235, 236);
    self.text_search.leftView = view_left;
    self.text_search.delegate =self;
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
    [self.text_search addTarget:self action:@selector(Text_Change:) forControlEvents:UIControlEventEditingChanged];
    
    @weakify(self);
//    [[self.text_search rac_textSignal]subscribeNext:^(id x) {
//        @strongify(self);
//        [self SearchUsername:x];
//    }];
    [view addSubview:self.text_search];
    [self.navigationItem setTitleView:view];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
    [self.tableview registerNib:[UINib nibWithNibName:@"MyFansTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[SearchThreadsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SearchThreadsTableViewCell class])];
    [self.view addSubview:self.tableview];
    //添加一个帖子的上拉加载
    self.tableview.mj_footer.hidden =YES;
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        self.page_threads++;
        [self Load_threads:self.page_threads];
    }];
    
    
    
}
-(void)Text_Change:(UITextField *)text{

    [self SearchUsername:text.text];
    
}
-(void)Pop_view{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 初始化数据
 */
-(void)InitData{

    self.page_member = 1;
    self.page_threads = 1;
    self.isShowMoreUser=NO;
    self.arr_member = [NSMutableArray arrayWithCapacity:0];
    self.arr_threads = [NSMutableArray arrayWithCapacity:0];
    self.type = YouAnStatusSearchNoDeatil;
    [self.text_search becomeFirstResponder];
}
/**
 搜索
 */
-(void)SearchUsername:(NSString *)search_key{

    MYLOG(@"%@",search_key)
    self.str_keyword = search_key;
    [PPNetworkHelper cancelRequestWithURL:[NSString stringWithFormat:@"%@/search/",ADDRESS_API]];
    if ([search_key isEqualToString:@""]) {
        
        [self DeatilNoMoreData];

        
    }else{
        
        
        
        self.page_member = 1;
        self.page_threads = 1;
        [self Load_Member:self.page_member];
        [self Load_threads:self.page_threads];
    }
}
/*
 加载会员数据
 **/
-(void)Load_Member:(NSInteger )page{

    NSDictionary *dic = @{@"page_size":@"10",
                          @"keyword":self.str_keyword,
                          @"strict":@"member",
                          @"page":[NSNumber numberWithInteger:page]};
    @weakify(self);
    [HttpEngine Search:dic complete:^(BOOL success, id responseObject) {
        
        @strongify(self);
        if (success) {
            
            [self Deal_Member:page res:responseObject];
        }
        
    }];
    
}
/*
 加载帖子数据
 **/
-(void)Load_threads:(NSInteger )page{
    
    NSDictionary *dic = @{@"page_size":@"10",
                          @"keyword":self.str_keyword,
                          @"strict":@"threads",
                          @"page":[NSNumber numberWithInteger:page]};
    @weakify(self);
    [HttpEngine Search:dic complete:^(BOOL success, id responseObject) {
        
        @strongify(self);
        [self.tableview.mj_footer endRefreshing];
        if (success) {

            [self Deal_Threads:page res:responseObject];
        }
        
    }];
}
/**
 处理请求回来的会员数据
 */
-(void)Deal_Member:(NSInteger )page res:(id )responseObject{

    self.Model_Members = [YouAnSearchMemberModel whc_ModelWithJson:responseObject];
    
    if (page==1) {
        
        [self.arr_member removeAllObjects];
    }
//    self.isShowMoreUser
    if ((self.Model_Members.members.results.count<10&&self.Model_Members.members.results.count>0)||self.Model_Members.members.results.count==0) {
        //不展示
        self.isShowMoreUser = NO;
        
    }else if (self.Model_Members.members.results.count==10){
        
        //展示
        self.isShowMoreUser =YES;
    }
    
    [self.arr_member addObjectsFromArray:self.Model_Members.members.results];
    
    [self JudgeState];
    
    
    

}
/**
 处理请求回来的帖子数据
 */
-(void)Deal_Threads:(NSInteger )page res:(id )responseObject{
    
    self.Model_Threads = [YouAnSearchThreadsModel whc_ModelWithJson:responseObject];
    
    if (page==1) {
        
        [self.arr_threads removeAllObjects];
    }
    if (self.Model_Threads.threads.results.count<10&&self.Model_Threads.threads.results.count>0) {
        
        self.tableview.mj_footer.hidden =NO;
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }else if (self.Model_Threads.threads.results.count==10){
    
        self.tableview.mj_footer.hidden = NO;
    }else if (self.Model_Threads.threads.results.count==0){
    
        self.tableview.mj_footer.hidden =YES;
    }
    [self.arr_threads addObjectsFromArray:self.Model_Threads.threads.results];
    
//    if (self.arr_threads.count==self.Model_Threads.threads.total) {
//        //全部获取完了
//        self.tableview.mj_footer.hidden =NO;
//        [self.tableview.mj_footer endRefreshingWithNoMoreData];
//    }else if (self.arr_threads.count>0)
    
    
    [self JudgeState];

    
}
/**
 没数据统计处理 需要注意是谁没数据 是user还是threads
 */
-(void)DeatilNoMoreData{
    
    self.Model_Threads = nil;
    self.Model_Members = nil;
    self.isShowMoreUser=NO;
    [self.tableview.mj_footer resetNoMoreData];
    self.tableview.mj_footer.hidden =YES;
    [self.arr_threads removeAllObjects];
    [self.arr_member removeAllObjects];
    [self JudgeState];
}
/**
 判断状态
 */
-(void)JudgeState{

    if (self.arr_threads.count>0&&self.arr_member.count>0) {
        
        self.type = YouAnStatusSearchAll;
        
    }else if (self.arr_member.count>0){
        
        self.type = YouAnStatusSearchUser;
        
    }else if (self.arr_threads.count>0){
    
        self.type = YouAnStatusSearchThreads;
        
    }else{
    
        self.type =YouAnStatusSearchNoDeatil;
    }
    [self.tableview reloadData];
    
}
/**
 查看更多用户
 */
-(void)Qur_More_User{

    self.page_member++;
    [self Load_Member:self.page_member];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.type) {
        case YouAnStatusSearchAll:{
            
            if (section==0) {
                
                return self.arr_member.count;
                
            }else{
            
                return self.arr_threads.count;
                
            }
        }
            break;
        case YouAnStatusSearchUser:{
            
            return self.arr_member.count;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            return self.arr_threads.count;
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return 0;
        }
            break;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    switch (self.type) {
        case YouAnStatusSearchAll:{
        
            return 2;
        }
            break;
        case YouAnStatusSearchUser:{
            
            return 1;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            return 1;
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return 0;
        }
            break;
    }
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (self.type) {
        case YouAnStatusSearchAll:{
            
            if (indexPath.section==0) {
                
                return 90;
            }else{
            
                return [SearchThreadsTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            }
        }
            break;
        case YouAnStatusSearchUser:{
            
            return 90;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            return [SearchThreadsTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return 0;
        }
            break;
    }
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (self.type) {
        case YouAnStatusSearchAll:{
            
            return 38;
        }
            break;
        case YouAnStatusSearchUser:{
            
            return 38;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            return 38;
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return 0.0001;
        }
            break;
    }
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (self.type==YouAnStatusSearchAll) {
        if (section==0) {
            
            if (self.isShowMoreUser) {
                
                return 50;
            }
        }
    }else if (self.type==YouAnStatusSearchUser){
        
        if (self.isShowMoreUser) {
            
            return 50;
        }
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (self.type==YouAnStatusSearchAll) {
        if (section==0) {
            
            if (self.isShowMoreUser) {
                
                return self.view_foot_member;
            }
        }
    }else if (self.type==YouAnStatusSearchUser){
        
        if (self.isShowMoreUser) {
            
            return self.view_foot_member;
        }
    }
    return nil;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (self.type) {
        case YouAnStatusSearchAll:{
            
            if (section ==0) {
                
                return self.view_head_member;
            }else{
            
                return self.view_head_threads;
            }
        }
            break;
        case YouAnStatusSearchUser:{
            
            return self.view_head_member;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            return self.view_head_threads;
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return nil;
        }
            break;
    }
    return nil;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断几种状态
    switch (self.type) {
        case YouAnStatusSearchAll:{
            
            if (indexPath.section ==0) {
                
                MyFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell SetMemberResults:self.arr_member[indexPath.row] withrow:indexPath.row withkeyword:self.str_keyword];
                
                return cell;
                
            }else{
                
                SearchThreadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchThreadsTableViewCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell SetThreadsModel:self.arr_threads[indexPath.row] withrow:indexPath.row withkeyword:self.str_keyword];
                
                return cell;
            }
        }
            break;
        case YouAnStatusSearchUser:{
            
            MyFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell SetMemberResults:self.arr_member[indexPath.row] withrow:indexPath.row withkeyword:self.str_keyword];
            return cell;
        }
            break;
        case YouAnStatusSearchThreads:{
            
            SearchThreadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchThreadsTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell SetThreadsModel:self.arr_threads[indexPath.row] withrow:indexPath.row withkeyword:self.str_keyword];
            return cell;
            
        }
            break;
        case YouAnStatusSearchNoDeatil:{
            
            return nil;
        }
            break;
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.type == YouAnStatusSearchAll||self.type==YouAnStatusSearchUser||self.type==YouAnStatusSearchThreads) {

        [self.text_search resignFirstResponder];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MYLOG(@"%ld--%ld",(long)indexPath.section,(long)indexPath.row);
    
    switch (indexPath.section) {
        case 0:{
        
            [self Click_UserDeail:indexPath.row];
            
        }
            break;
        case 1:{
            
            [self Click_Threads_Deail:indexPath.row];
        }
            break;
    }
    
}
/**
 处理点击的user
 */
-(void)Click_UserDeail:(NSInteger )row{

    MemberResults *resmodel = self.arr_member[row];
    
    [[BWCommon sharebwcommn]PushTo_UserDeatil:resmodel.id view:self];
    
//    @weakify(self);
//    [ZFCWaveActivityIndicatorView show:self.view];
//    [HttpEngine BusinessCard:resmodel.id complete:^(BOOL success, id responseObject) {
//        @strongify(self);
//        [ZFCWaveActivityIndicatorView hid:self.view];
//        if (success) {
//            
//            self.BusinessModel = [YouAnBusinessCardModel whc_ModelWithJson:responseObject];
//            UIViewController *view = [[BWCommon sharebwcommn]UserDeatil:self.BusinessModel];
//            view.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:view animated:YES];
//            
//        }else{
//            
//            if (responseObject[@"msg"]) {
//                
//                [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
//                
//            }else{
//                
//                [MBProgressHUD showError:@"信息拉取失败" toView:self.view];
//            }
//        }
//    }];
}
/**
 处理点击的帖子
 */
-(void)Click_Threads_Deail:(NSInteger )row{
    
    ThreadsResults *resmodel = self.arr_threads[row];
    PostingDeatilViewController *view = [PostingDeatilViewController new];
    view.posting_id = resmodel.id;
    [self.navigationController pushViewController:view animated:YES];
}





/**
 return按键处理
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    [textField resignFirstResponder];
    return YES;
}
-(UIView *)view_head_member{

    if (!_view_head_member) {
        
        _view_head_member = [UIView new];
        _view_head_member.backgroundColor = RGB(247, 247, 247);
        
        UIView * view_bot = [UIView new];
        view_bot.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *lab_user = [UILabel new];
        [lab_user setText:@"用户"];
        [lab_user setTextColor:RGB(102, 102, 102)];
        [lab_user setFont:[UIFont systemFontOfSize:14]];
        [lab_user sizeToFit];
        
        UIView *view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 229);
        
        [view_bot addSubview:lab_user];
        [view_bot addSubview:view_line];
        [_view_head_member addSubview:view_bot];
        
        view_bot.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpace(10).whc_Height(28);
        lab_user.whc_LeftSpace(15).whc_CenterY(0);
        view_line.whc_Height(0.5).whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
        
    }
    return _view_head_member;
}
-(UIView *)view_head_threads{
    
    if (!_view_head_threads) {
        
        _view_head_threads = [UIView new];
        _view_head_threads.backgroundColor = RGB(247, 247, 247);
        
        UIView * view_bot = [UIView new];
        view_bot.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab_user = [UILabel new];
        [lab_user setText:@"帖子"];
        [lab_user setTextColor:RGB(102, 102, 102)];
        [lab_user setFont:[UIFont systemFontOfSize:14]];
        [lab_user sizeToFit];
        
        UIView *view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 229);
        
        [view_bot addSubview:lab_user];
        [view_bot addSubview:view_line];
        [_view_head_threads addSubview:view_bot];
        
        view_bot.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpace(10).whc_Height(28);
        lab_user.whc_LeftSpace(15).whc_CenterY(0);
        view_line.whc_Height(0.5).whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
        
    }
    return _view_head_threads;
}
-(UIView *)view_foot_member{

    if (!_view_foot_member) {
        
        _view_foot_member = [UIView new];
        _view_foot_member.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"查看更多用户" forState:UIControlStateNormal];
        [btn setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(Qur_More_User) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_view_foot_member addSubview:btn];
        
        btn.whc_TopSpace(0).whc_BottomSpace(0).whc_CenterX(0).whc_Width(100);
    }
    return _view_foot_member;
}
@end
