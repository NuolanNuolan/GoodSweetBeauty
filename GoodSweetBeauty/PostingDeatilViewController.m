//
//  PostingDeatilViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/30.
//  Copyright © 2017年 YLL. All rights reserved.
//
#define AUTOW(x)   x*SCREEN_WIDTH/iphone6_width

#import "PostingDeatilViewController.h"
#import "YouAnBBSDeatilModel.h"

@interface PostingDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>{

    
}

//楼主按钮
@property(nonatomic,strong)UIButton *btn_Poster;
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

@end

@implementation PostingDeatilViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [MBProgressHUD showMessage:@"" toView:self.view];
    [self InitData];
    //请求
    [self LoadData:self.page];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
}
//请求
-(void)LoadData:(NSInteger )page{
    
    @weakify(self);
    [HttpEngine PostingDeatil:self.posting_id withpage:page withpige_size:1 complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [MBProgressHUD hideHUDForView:self.view];
        if (success) {
            
            self.Deatilmodel = [YouAnBBSDeatilModel whc_ModelWithJson:responseObject];
            
        }
        
        
    }];
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
    [self.view addSubview:self.tableview];
    
}
-(void)CreateRightBtn{

    self.btn_Poster = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_Poster.frame = CGMAKE(-20, 0, 40, 20);
    self.btn_Poster.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.btn_Poster setTitle:@"楼主" forState:UIControlStateNormal];
    [self.btn_Poster setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.btn_Poster.layer.masksToBounds =YES;
    self.btn_Poster.layer.borderColor = RGB(102, 102, 102).CGColor;
    self.btn_Poster.layer.borderWidth = 0.5f;
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [bgview  addSubview:self.btn_Poster];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithCustomView:bgview];
    
    self.btn_More = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_More.frame = CGMAKE(0, 0, 4, 18);
    self.btn_More.adjustsImageWhenHighlighted =NO;
    [self.btn_More setBackgroundImage:[UIImage imageNamed:@"iconTitlebarMore"] forState:UIControlStateNormal];
    UIBarButtonItem *collectionButton = [[UIBarButtonItem alloc]initWithCustomView:self.btn_More];
    NSArray *barItems = [[NSArray alloc] initWithObjects:collectionButton,shareButton, nil];
    [self.navigationItem setRightBarButtonItems:barItems];
}
-(void)CreateBotBtn{

    UIView *view_btn = [[UIView alloc]initWithFrame:CGMAKE(0, SCREEN_HEIGHT-50-64, ScreenWidth, 50)];
    view_btn.backgroundColor = [UIColor whiteColor];
    self.btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_back.frame = CGMAKE(ScreenWidth-AUTOW(145), 0, AUTOW(145), 50);
    [self.btn_back setBackgroundColor:GETMAINCOLOR];
    [self.btn_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_back setTitle:@"立即回复" forState:UIControlStateNormal];
    self.btn_back.titleLabel.font =[UIFont systemFontOfSize:16];
    
    UIView *view_share = [UIView new];
    view_share.backgroundColor = [UIColor whiteColor];
    self.btn_share =[self create_btn_bot:@"分享" withimage:@"iconBottombarShare"];
    [view_share addSubview:self.btn_share];
    
    UIView *view_collection = [UIView new];
    view_collection.backgroundColor = [UIColor whiteColor];
    self.btn_collection =[self create_btn_bot:@"收藏" withimage:@"iconBottombarShoucang"];
    [view_collection addSubview:self.btn_collection];
    
    [view_btn addSubview:view_share];
    [view_btn addSubview:view_collection];
    [view_btn addSubview:self.btn_back];
    [self.view addSubview:view_btn];
    
    view_share.whc_LeftSpace(0).whc_TopSpace(0).whc_BottomSpace(0).whc_RightSpaceToView(0,view_collection);
    view_collection.whc_LeftSpaceToView(0,view_share).whc_TopSpaceEqualView(view_share).whc_RightSpaceToView(0,self.btn_back).whc_BottomSpaceEqualView(view_share).whc_WidthEqualView(view_share);
    self.btn_share.whc_CenterX(0).whc_TopSpace(6.5);
    self.btn_collection.whc_CenterX(-20).whc_TopSpace(8);
}
//底部按钮封装
-(UIButton *)create_btn_bot:(NSString *)title withimage:(NSString *)imagename{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    [btn setTitleColor:RGB(144, 148, 153) forState:UIControlStateNormal];
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0 ,0, -18,0)];
    if ([title isEqualToString:@"分享"])  [btn setTitleEdgeInsets:UIEdgeInsetsMake(0 ,0, -18,0)];
    else if ([title isEqualToString:@"收藏"]) [btn setTitleEdgeInsets:UIEdgeInsetsMake(0 ,0, -20,0)];
    return btn;
}
@end
