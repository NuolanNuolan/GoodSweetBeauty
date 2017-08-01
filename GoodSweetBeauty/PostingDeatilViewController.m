//
//  PostingDeatilViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/30.
//  Copyright © 2017年 YLL. All rights reserved.
//
#define AUTOW(x)   x*SCREEN_WIDTH/iphone6_width
static NSString *const kMycommentsCellIdentifier = @"kMycommentsCellIdentifier";
static NSString *const kMycommentsfatherCellIdentifier = @"kMycommentsfatherCellIdentifier";
#import "PostingDeatilViewController.h"
#import "YouAnBBSDeatilModel.h"
#import "BBSDeatilTableViewCell.h"
#import "BBSTitleDeatilTableViewCell.h"
#import "BBSimageDeatilTableViewCell.h"
#import "BBSExceptionalTableViewCell.h"
#import "CommentsDeatilTableViewCell.h"




@interface PostingDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}

//楼主按钮
@property(nonatomic,strong)UIButton *btn_Poster;
//是否是只看楼主
@property(nonatomic,assign)BOOL      if_master;
//更多按钮
@property(nonatomic,strong)UIButton *btn_More;
//分享收藏立即回复
@property(nonatomic,strong)UIButton *btn_share;

@property(nonatomic,strong)UIButton *btn_collection;

@property(nonatomic,strong)UIButton *btn_back;

@property(nonatomic,strong)UITableView *tableview;
//model
@property(nonatomic,strong)YouAnBBSDeatilModel *Deatilmodel;
//page
@property(nonatomic,assign)NSInteger page;
//评论数组
@property(nonatomic,strong)NSMutableArray *Arr_comments_hot;
@property(nonatomic,strong)NSMutableArray *Arr_comments_all;
//此处定义主贴图片是否展开
@property(nonatomic,assign)BOOL Master_image_isopen;


/**
 评论头部视图
 */
@property(nonatomic,strong)UIView *view_head_hot;

@property(nonatomic,strong)UIView *view_head_all;

@property(nonatomic,strong)UILabel *lab_hot_comments;

@property(nonatomic,strong)UILabel *lab_all_comments;

@property(nonatomic,strong)UIView *view_head_line;

//尾部视图
@property(nonatomic,strong)UILabel *lab_footer;
//是否需要隐藏尾部视图
@property(nonatomic,assign)BOOL     ishidden_lab_footer;
//用户主页相关
@property(nonatomic,strong)YouAnBusinessCardModel *busmodel;

@end

@implementation PostingDeatilViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"ISREFRESH"]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ISREFRESH"];
        self.page =1;
        [self.tableview.mj_footer resetNoMoreData];
        [self LoadData:self.page];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self InitData];
    [self CreateUI];
    //请求
    [self LoadData:self.page];
    
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
    
    
}
//请求
-(void)LoadData:(NSInteger )page{
    
    @weakify(self);
    [HttpEngine PostingDeatil:self.posting_id withpage:page withpige_size:0 if_master:self.if_master complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [self.tableview.mj_footer endRefreshing];
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            [self DataProcessingwithpage:page withdata:responseObject];
            
        }else{
        
            self.page =page-1;
        }
    }];
}
/**
 数据处理
 */
-(void)DataProcessingwithpage:(NSInteger )page withdata:(id)responseObject{

    self.Deatilmodel = [YouAnBBSDeatilModel whc_ModelWithJson:responseObject];
    //是否收藏
    if (self.Deatilmodel.if_favor) {
        
        [self.btn_collection setBackgroundImage:[UIImage imageNamed:@"iconBottombarShoucangActive"] forState:UIControlStateNormal];
    }
    //这里分离出评论数据
    if (page==1) {
        if (![BWCommon islogin]) {
            
            self.ishidden_lab_footer = NO;
            self.tableview.mj_footer.hidden =YES;
        }
        [self.Arr_comments_all removeAllObjects];
        [self.Arr_comments_hot removeAllObjects];
        
    }
    if (self.Deatilmodel.posts.count<10) {
        
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
        
    }
    for (Posts *Postsmodel in self.Deatilmodel.posts) {
        Postsmodel.isopen = NO;
        [self.Arr_comments_all addObject:Postsmodel];
    }
    //只有1时才有热门评论
    if (page==1) {
        
        for (Posts *Hotsmodel in self.Deatilmodel.hot_posts) {
            
            [self.Arr_comments_hot addObject:Hotsmodel];
        }
    }

//    if (page==1) [self.tableview reloadData];
//    else{
//        
//        [UIView performWithoutAnimation:^{
//            
////            [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableview reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
////            [self.tableview reloadData];
//        }];
//    }
    [self.tableview reloadData];
    
}
-(void)CreateUI{
    
    //表格
    [self Createtableview];
    //右上角按钮
    [self CreateRightBtn];
    //下方操作按钮
    [self CreateBotBtn];
    
}
-(void)Createtableview{

    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, ScreenHeight-64-50) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableview registerClass:[BBSDeatilTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSDeatilTableViewCell class])];
    [self.tableview registerClass:[BBSTitleDeatilTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSTitleDeatilTableViewCell class])];
    [self.tableview registerClass:[BBSExceptionalTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSExceptionalTableViewCell class])];
    [self.tableview registerClass:[BBSimageDeatilTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSimageDeatilTableViewCell class])];
    [self.tableview registerClass:[BBSDeatilTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BBSDeatilTableViewCell class])];
    [self.tableview registerClass:[CommentsDeatilTableViewCell class] forCellReuseIdentifier:kMycommentsCellIdentifier];
    [self.tableview registerClass:[CommentsDeatilTableViewCell class] forCellReuseIdentifier:kMycommentsfatherCellIdentifier];
    [self.view addSubview:self.tableview];
    @weakify(self);
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        [self LoadData:++self.page];
        
    }];
    [ZFCWaveActivityIndicatorView show:self.view];

    
    
    
}
-(void)CreateRightBtn{

    self.btn_Poster = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_Poster.frame = CGMAKE(20, 12.5, 40, 20);
    self.btn_Poster.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.btn_Poster setTitle:@"楼主" forState:UIControlStateNormal];
    [self.btn_Poster setEnlargeEdgeWithTop:20 right:10 bottom:20 left:30];
    [self.btn_Poster setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self.btn_Poster addTarget:self action:@selector(Poster_click) forControlEvents:UIControlEventTouchUpInside];
    self.btn_Poster.layer.masksToBounds =YES;
    self.btn_Poster.layer.borderColor = RGB(102, 102, 102).CGColor;
    self.btn_Poster.layer.borderWidth = 0.5f;
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [bgview  addSubview:self.btn_Poster];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithCustomView:bgview];
    
    self.btn_More = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_More.frame = CGMAKE(0, 0, 4, 18);
    [self.btn_More setEnlargeEdgeWithTop:0 right:20 bottom:10 left:10];
    self.btn_More.adjustsImageWhenHighlighted =NO;
    [self.btn_More addTarget:self action:@selector(more_click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_More setBackgroundImage:[UIImage imageNamed:@"iconTitlebarMore"] forState:UIControlStateNormal];
    UIBarButtonItem *collectionButton = [[UIBarButtonItem alloc]initWithCustomView:self.btn_More];
    NSArray *barItems = [[NSArray alloc] initWithObjects:collectionButton,shareButton, nil];
    [self.navigationItem setRightBarButtonItems:barItems];
}
-(void)CreateBotBtn{

    UIView *view_btn = [[UIView alloc]initWithFrame:CGMAKE(0, SCREEN_HEIGHT-50.5-64, ScreenWidth, 50.5)];
    UIView *view_line = [[UIView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 0.5)];
    view_line.backgroundColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:0.1];
    
    view_btn.backgroundColor = [UIColor whiteColor];
    self.btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_back.frame = CGMAKE(ScreenWidth-AUTOW(145), 0, AUTOW(145), 50.5);
    [self.btn_back setBackgroundColor:GETMAINCOLOR];
    [self.btn_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_back addTarget:self action:@selector(back_click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_back setTitle:@"立即回复" forState:UIControlStateNormal];
    self.btn_back.titleLabel.font =[UIFont systemFontOfSize:16];
    
    UIView *view_share = [self create_btn_bot:@"分享" withimage:@"iconBottombarShare"];
    ;
    UIView *view_collection = [self create_btn_bot:@"收藏" withimage:@"iconBottombarShoucang"];

    
    
    [view_btn addSubview:view_line];
    [view_btn addSubview:view_share];
    [view_btn addSubview:view_collection];
    [view_btn addSubview:self.btn_back];
    [self.view addSubview:view_btn];
    
    view_share.whc_LeftSpace(0).whc_TopSpace(0.5).whc_BottomSpace(0).whc_RightSpaceToView(0,view_collection);
    view_collection.whc_LeftSpaceToView(0,view_share).whc_TopSpaceEqualView(view_share).whc_RightSpaceToView(0,self.btn_back).whc_BottomSpaceEqualView(view_share).whc_WidthEqualView(view_share);
//    self.btn_share.whc_CenterX(0).whc_TopSpace(6.5);
//    self.btn_collection.whc_CenterX(-20).whc_TopSpace(8);
}
//底部按钮封装
-(UIView *)create_btn_bot:(NSString *)title withimage:(NSString *)imagename{

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setEnlargeEdgeWithTop:0 right:30 bottom:40 left:40];
    [btn addTarget:self action:@selector(btn_bot_click:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lab_title = [UILabel new];
    [lab_title setText:title];
    [lab_title setFont:[UIFont systemFontOfSize:11]];
    [lab_title setTextColor:RGB(144, 148, 153)];
    [lab_title setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:btn];
    [view addSubview:lab_title];
    
    if ([title isEqualToString:@"分享"]) {
        self.btn_share = btn;
        btn.whc_Size(21,21).whc_TopSpace(6.5).whc_LeftSpace(27.5);
        lab_title.whc_TopSpace(34).whc_Size(30,11).whc_CenterXToView(0,btn);
        
    }else{
    
        self.btn_collection = btn;
        btn.whc_Size(19,17.4).whc_TopSpace(9).whc_LeftSpace(13);
        lab_title.whc_TopSpace(34).whc_Size(30,11).whc_CenterXToView(0,btn);
    }
    
    
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 4:{
         
            if (self.Arr_comments_hot.count>0)return self.Arr_comments_hot.count;
            else return 1;

        }
            break;
        case 5:{
            
            if (self.Arr_comments_all.count>0)return self.Arr_comments_all.count;
            else return 1;
            
        }
            break;
            
        default:{
        
            return 1;
        }
            break;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==5) {
        if (![BWCommon islogin]) {
            if (self.Deatilmodel.posts_count>10){
                if (!self.ishidden_lab_footer) {
                    
                    return 40;
                }
            }
        }
    }
    return 0.001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 4:{
        
            if (self.Arr_comments_hot.count>0)return 38;
            else return 0.001;
        }
            break;
        case 5:{
            
            if (self.Arr_comments_all.count>0)return 38;
            else return 0.001;
        }
            break;
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
    switch (indexPath.section) {
        case 0:
            return [BBSDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            break;
        case 1:
            return [BBSTitleDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView ];
            break;
        case 2:{
        
            if (![_Deatilmodel.image isEqualToString:@""]) {
                
                return [BBSimageDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            }else{
            
                return 0.001;
            }
        }
            
            break;
        case 3:
            return [BBSExceptionalTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            break;
        case 4:{
        
            if (self.Arr_comments_hot.count>0)return [CommentsDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            else return 0.001;
            
        }
            break;
        case 5:{
            
            if (self.Arr_comments_all.count>0)return [CommentsDeatilTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            else return 0.001;
            
        }
            break;
    }
    return 0.001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            BBSDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSDeatilTableViewCell class])];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setmodel:_Deatilmodel];
            cell.delegateSignal = [RACSubject subject];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                 if ([x[@"type"] isEqualToString:@"头像点击"]){
                     
                    [self headimg:[x[@"authid"] integerValue]];
                 }
            }];

            return cell;
            
        }
            break;
        case 1:{
            
            BBSTitleDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSTitleDeatilTableViewCell class])];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setmodel:_Deatilmodel];
            @weakify(self);
            cell.delegateSignal = [RACSubject subject];
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                
                [self Atscreening:x];

                
            }];
            
            return cell;
        }
            break;
        case 2:{
            if ([_Deatilmodel.master_posts.image isEqualToString:@""]||!_Deatilmodel.master_posts.image) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    [cell setBackgroundColor:[UIColor whiteColor]];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                }
                return cell;
            }else{
            
                BBSimageDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSimageDeatilTableViewCell class])];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.delegateSignal = [RACSubject subject];
                @weakify(self);
                [cell.delegateSignal subscribeNext:^(id x) {
                    @strongify(self);
                    //刷新此表格
                    self.Master_image_isopen = YES;
                    [self.tableview reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
                }];
                [cell setmodel:_Deatilmodel isopen:self.Master_image_isopen];
                return cell;
            }
        }
            break;
        case 3:{
            
            BBSExceptionalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBSExceptionalTableViewCell class])];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            @weakify(self);
            cell.delegateSignal = [RACSubject subject];
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                [self Exceptional:x];
            }];
            [cell setmodel:_Deatilmodel];
            return cell;
        }
            break;
        case 4:{
            if (self.Arr_comments_hot.count==0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    [cell setBackgroundColor:[UIColor whiteColor]];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                }
                return cell;
            }else{
                
                Posts *postsmodel = self.Arr_comments_hot[indexPath.row];
                CommentsDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postsmodel.father_id ==0?kMycommentsCellIdentifier:kMycommentsfatherCellIdentifier];
                [cell SetAllPotsModel:postsmodel withisopen:postsmodel.isopen withrow:indexPath.row isfather:postsmodel.father_id ==0?NO:YES withAllrow:self.Arr_comments_hot.count isAllcomments:NO];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.delegateSignal = [RACSubject subject];
                @weakify(self);
                [cell.delegateSignal subscribeNext:^(id x) {
                    @strongify(self);
                    if ([x[@"type"] isEqualToString:@"回复楼层"]) {
                        
                        [self backtoTheFloor:x[@"btn"]];
                    }else if ([x[@"type"] isEqualToString:@"展开评论"]){
                        
                        [self opencomment:x[@"btn"]];
                    }else if ([x[@"type"] isEqualToString:@"头像点击"]){
                        
                        [self headimg:[x[@"authid"] integerValue]];
                    }else if([x[@"type"] isEqualToString:@"AllComments"]||[x[@"type"] isEqualToString:@"HotComents"]){
                    
                        [self Atscreening:x];
                    }
                }];
                return cell;
            }
            
        }
            break;
        case 5:{
            if (self.Arr_comments_all.count==0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    [cell setBackgroundColor:[UIColor whiteColor]];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                }
                return cell;
            }else{
                
                Posts *postsmodel = self.Arr_comments_all[indexPath.row];
                CommentsDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postsmodel.father_id ==0?kMycommentsCellIdentifier:kMycommentsfatherCellIdentifier];
                
                [cell SetAllPotsModel:postsmodel withisopen:postsmodel.isopen withrow:indexPath.row isfather:postsmodel.father_id ==0?NO:YES withAllrow:self.Arr_comments_all.count isAllcomments:YES];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.delegateSignal = [RACSubject subject];
                @weakify(self);
                [cell.delegateSignal subscribeNext:^(id x) {
                    @strongify(self);
                    if ([x[@"type"] isEqualToString:@"回复楼层"]) {
                        
                        [self backtoTheFloor:x[@"btn"]];
                    }else if ([x[@"type"] isEqualToString:@"展开评论"]){
                    
                        [self opencomment:x[@"btn"]];
                    }else if ([x[@"type"] isEqualToString:@"头像点击"]){
                        
                        [self headimg:[x[@"authid"] integerValue]];
                    }else if([x[@"type"] isEqualToString:@"AllComments"]||[x[@"type"] isEqualToString:@"HotComents"]){
                        
                        [self Atscreening:x];
                    }

                    
                }];
                return cell;
            }
            
        }
            break;
    }

    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view_head = [UIView new];
    switch (section) {
        case 4:{
            
            if (self.Arr_comments_hot.count>0){
            
                [view_head addSubview:self.view_head_hot];
                [_lab_hot_comments setText:[NSString stringWithFormat:@"热门评论(%lu)",(unsigned long)self.Arr_comments_hot.count]];
                return view_head;
                
            }
            else{
            
                return view_head;
            }
            
        }
            break;
        case 5:{
            
            if (self.Arr_comments_all.count>0){
            
                [view_head addSubview:self.view_head_all];
                [_lab_all_comments setText:[NSString stringWithFormat:@"全部评论(%lu)",(long)self.Deatilmodel.posts_count]];
                return view_head;
                
            }else{
            
                return view_head;
            }
        }
            break;
    }
    return view_head;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view_footer = [UIView new];
    if (section==5) {
        if (![BWCommon islogin]) {
            if (self.Deatilmodel.posts_count>10) {
                if (!self.ishidden_lab_footer) {
                    
                    [view_footer addSubview:self.lab_footer];
                    [_lab_footer setText:[NSString stringWithFormat:@"查看更多%ld条回复...",self.Deatilmodel.posts_count-10]];
                }else{
                
                    self.tableview.mj_footer.hidden =NO;
                }
            }
        }
    }
    return view_footer;
}
/**
 更多
 */
-(void)more_click{

    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    @weakify(self);
    LPActionSheet *sheet = [[LPActionSheet alloc]initWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"收藏",@"跳页",@"举报",@"复制链接"] titlecolor:GETMAINCOLOR handler:^(LPActionSheet *actionSheet, NSInteger index) {
        @strongify(self);
        switch (index) {
            case 1:{
                
                [self btn_bot_click:self.btn_collection];
            }
                break;
            case 2:{
                
            }
                break;
            case 3:{
                
            }
                break;
            case 4:{
                
            }
                break;
        }
    }];
    [sheet show];

    
}
/**
 楼主
 */
-(void)Poster_click{

    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    self.if_master = !self.if_master;
    if (self.if_master) {
        
        [self.btn_Poster setBackgroundColor:RGB(229, 229, 229)];
        
    }else{
    
        [self.btn_Poster setBackgroundColor:[UIColor whiteColor]];
    }
    self.page = 1;
    [self LoadData:self.page];
}

/**
 回复
 */
-(void)back_click{

    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    UserPostingViewController *view = [[UserPostingViewController alloc]init];
    view.type = YouAnStatusComposeViewTypeStatus;
    view.pk = self.posting_id;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
}
/**
 回复楼层
 */
-(void)backtoTheFloor:(UIButton *)btn{

    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    UserPostingViewController *view = [[UserPostingViewController alloc]init];
    view.type = YouAnStatusComposeViewTypeComment;
    view.pk = self.posting_id;
    //取出fatherid tag需要减去100或者200判断是热门评论还是全部评论
    if (btn.tag>=200) {
        //全部评论
        Posts *postsmodel = [self.Arr_comments_all objectAtIndex:btn.tag-200];
        view.postsmodel = postsmodel;
    }else{
    
        //热门评论
        Posts *postsmodel = [self.Arr_comments_all objectAtIndex:btn.tag-100];
        view.postsmodel = postsmodel;
        
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
    
}

/**
 展开评论
 */
-(void)opencomment:(UIButton *)btn{
    
    
    NSIndexPath *  indexpathone ;

    
    if (btn.tag>=200) {
        //全部评论
        Posts *postsmodel = [self.Arr_comments_all objectAtIndex:btn.tag-200];
        postsmodel.isopen = YES;
        indexpathone = [NSIndexPath indexPathForItem:btn.tag-200 inSection:5];
    }else{
        
        //热门评论
        Posts *postsmodel = [self.Arr_comments_hot objectAtIndex:btn.tag-100];
        postsmodel.isopen = YES;
        indexpathone = [NSIndexPath indexPathForItem:btn.tag-100 inSection:4];
        
    }
    [self.tableview reloadRowsAtIndexPaths:@[indexpathone] withRowAnimation:UITableViewRowAnimationNone];
}

/**
 头像点击
 */
-(void)headimg:(NSInteger )authid{


    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine BusinessCard:authid complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            self.busmodel = [YouAnBusinessCardModel whc_ModelWithJson:responseObject];
            
            UIViewController *view = [[BWCommon sharebwcommn]UserDeatil:self.busmodel];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
            
        }else{
            
            [MBProgressHUD showError:@"信息拉取失败" toView:self.view];
        }
    }];
          
    
}
/**
 打赏
 */
-(void)Exceptional:(NSString *)conins{

    MYLOG(@"%@",conins);
    [HttpEngine Exceptional:[conins integerValue] withpk:self.Deatilmodel.id complete:^(BOOL success, id responseObject) {
        
        if (success) {
            [MBProgressHUD showSuccess:responseObject[@"msg"] toView:self.view];
        }else{
        
            if (responseObject) {
                
                [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
                
            }else{
            
                [MBProgressHUD showError:@"服务器繁忙" toView:self.view];
            }
        }
    }];
}

/**
 帖子底部按钮操作
 */
-(void)btn_bot_click:(UIButton *)btn{

    if ([btn isEqual:self.btn_share]) {
     
        MYLOG(@"分享");
    }else{
        if(![BWCommon islogin]){
            [BWCommon PushTo_Login:self];
            return;
        }
        MYLOG(@"收藏");
        [HttpEngine Posttingcollection:self.Deatilmodel.id complete:^(BOOL success, id responseObject) {
            
            if (success) {
             
                if ([responseObject[@"msg"] isEqualToString:@"帖子收藏成功"]) {
                    
                    [self.btn_collection setBackgroundImage:[UIImage imageNamed:@"iconBottombarShoucangActive"] forState:UIControlStateNormal];
                }else{
                
                    [self.btn_collection setBackgroundImage:[UIImage imageNamed:@"iconBottombarShoucang"] forState:UIControlStateNormal];
                }
                
            }
            
        }];
    }
}

/**
 At筛选
 */
-(void)Atscreening:(NSDictionary *)x{

    if ([x[@"type"] isEqualToString:@"master"]) {
        for (Ats *atmodel in self.Deatilmodel.master_posts.ats) {
            if ([atmodel.uname isEqualToString:x[@"name"]]) {
                
                MYLOG(@"@的id:%ld",(long)atmodel.uid)
                [self headimg:atmodel.uid];
            }
        }
    }else{
        //这里可以用三元运算减少判断
        Posts *postsmodel = [x[@"type"] isEqualToString:@"AllComments"]?self.Arr_comments_all[[x[@"row"] integerValue]]:self.Arr_comments_hot[[x[@"row"] integerValue]];
        
        for (Ats *atmodel in [x[@"father"]isEqualToString:@"YES"]?postsmodel.father.ats:postsmodel.ats) {
            
            if ([atmodel.uname isEqualToString:x[@"name"]]) {
                
                MYLOG(@"@的id:%ld",(long)atmodel.uid)
                [self headimg:atmodel.uid];
            }
            
        }
    }
}
/***
 
 更多评论
 */
-(void)more_posts{

    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:self];
        return;
    }
    MYLOG(@"加载下一页,需要判断时候登录");
    self.ishidden_lab_footer = YES;
    self.tableview.mj_footer.hidden =NO;
    [self LoadData:++self.page];
    
    
    
}
#pragma mark 懒加载视图
-(UIView *)view_head_hot{

    if (!_view_head_hot) {
        
        _view_head_hot = [[UIView alloc]initWithFrame:CGMAKE(0, 10, ScreenWidth, 28)];
        _view_head_hot.backgroundColor = [UIColor whiteColor];
        
        _lab_hot_comments = [[UILabel alloc]initWithFrame:CGMAKE(15, 0, ScreenWidth, 28)];
        [_lab_hot_comments setText:[NSString stringWithFormat:@"热门评论(%lu)",(unsigned long)self.Arr_comments_hot.count]];
        [_lab_hot_comments setFont:[UIFont systemFontOfSize:14]];
        [_lab_hot_comments setTextColor:RGB(102, 102, 102)];
        
        UIView *view_line = [[UIView alloc]initWithFrame:CGMAKE(0, 27.5, ScreenWidth, 0.5)];
        [view_line setBackgroundColor:RGB(229, 229, 229)];
        
        [_view_head_hot addSubview:view_line];
        [_view_head_hot addSubview:_lab_hot_comments];
    }
    return _view_head_hot;
}
-(UIView *)view_head_all{
    
    if (!_view_head_all) {
        
        _view_head_all = [[UIView alloc]initWithFrame:CGMAKE(0, 10, ScreenWidth, 28)];
        _view_head_all.backgroundColor = [UIColor whiteColor];
        
        _lab_all_comments = [[UILabel alloc]initWithFrame:CGMAKE(15, 0, ScreenWidth, 28)];
        [_lab_all_comments setText:[NSString stringWithFormat:@"全部评论(%lu)",(long)self.Deatilmodel.posts_count]];
        [_lab_all_comments setFont:[UIFont systemFontOfSize:14]];
        [_lab_all_comments setTextColor:RGB(102, 102, 102)];
        
        UIView *view_line = [[UIView alloc]initWithFrame:CGMAKE(0, 27.5, ScreenWidth, 0.5)];
        [view_line setBackgroundColor:RGB(229, 229, 229)];
        
        [_view_head_all addSubview:view_line];
        [_view_head_all addSubview:_lab_all_comments];
    }
    return _view_head_all;
}
-(NSMutableArray *)Arr_comments_hot{

    if (!_Arr_comments_hot) {
        
        _Arr_comments_hot = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_comments_hot;
}
-(NSMutableArray *)Arr_comments_all{
    
    if (!_Arr_comments_all) {
        
        _Arr_comments_all = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_comments_all;
}
-(UILabel *)lab_footer{

    if (!_lab_footer) {
        
        _lab_footer = [[UILabel alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 40)];
        [_lab_footer setTextColor:GETMAINCOLOR];
        _lab_footer.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(more_posts)];
        [_lab_footer addGestureRecognizer:tap];
        [_lab_footer setTextAlignment:NSTextAlignmentCenter];
        [_lab_footer setFont:[UIFont systemFontOfSize:15]];
    }
    return _lab_footer;
}
@end
