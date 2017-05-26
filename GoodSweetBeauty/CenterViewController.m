//
//  CenterViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterTableViewCell.h"
#import "SettingViewController.h"
#import "MyPostViewController.h"
#import "FansViewController.h"
#import "AuthViewController.h"



@interface CenterViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//model
@property(nonatomic,strong)YouAnUserModel *usermodel;

@property(nonatomic,strong)UITableView *tableView;

//头视图
@property(nonatomic,strong)UIView *view_head;
//头像 name 金额
@property(nonatomic,strong)UIImageView *image_head;
@property(nonatomic,strong)UILabel *lab_name;
@property(nonatomic,strong)UILabel *lab_balance;
@property(nonatomic,strong)NSMutableAttributedString *attri1;
@property(nonatomic,strong)NSMutableAttributedString * attri;
@property(nonatomic,strong)NSTextAttachment *attch;
@property(nonatomic,strong)NSAttributedString * string_attributed;
@end



@implementation CenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=GETMAINCOLOR;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor ]];
    [self LoadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self CreateUI];
    
}
//会员资料
-(void)LoadData{

    @weakify(self);
    [HttpEngine UserDetailcomplete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            self.usermodel = [YouAnUserModel whc_ModelWithJson:responseObject];
            [self.tableView reloadData];
        }
    }];
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
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -1000, SCREEN_WIDTH, 1000)];
    topView.backgroundColor = GETMAINCOLOR;
    [_tableView addSubview:topView];
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
    [cell SetSection:indexPath.section withmodel:self.usermodel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section==0)return self.view_head;
    return nil;
}
//表格头视图
-(UIView *)view_head{

    if (!_view_head) {
        
        _view_head = [UIView new];
        _view_head.backgroundColor = GETMAINCOLOR;
        //头像
        self.image_head = [UIImageView new];
        self.image_head.layer.masksToBounds = YES;
        self.image_head.layer.cornerRadius = 40.0f;
        self.image_head.backgroundColor = RGB(25, 138, 240);
        self.image_head.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Change_head)];
        [self.image_head addGestureRecognizer:tap];
        //name
        self.lab_name = [UILabel new];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];
        [self.lab_name setTextColor:[UIColor whiteColor]];
        
        [self.lab_name setText:self.usermodel ? self.usermodel.username : @""];
        
        [self.lab_name sizeToFit];
        
        self.lab_balance = [UILabel new];
        [self.lab_balance setTextColor:RGB(242, 167, 87)];
        [self.lab_balance setFont:[UIFont systemFontOfSize:15]];
        
        self.attri = [[NSMutableAttributedString alloc]init];
        self.attri1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",self.usermodel ? self.usermodel.coins : @""]];
        self.attch = [[NSTextAttachment alloc] init];
        self.attch.image = [UIImage imageNamed:@"iconBi"];
        self.attch.bounds = CGRectMake(0, -2, 17, 14);
        self.string_attributed = [NSAttributedString attributedStringWithAttachment:self.attch];
        [self.attri appendAttributedString:self.string_attributed];
        [self.attri appendAttributedString:self.attri1];
        self.lab_balance.attributedText = self.attri;
        
        [_view_head addSubview:self.image_head];
        [_view_head addSubview:self.lab_name];
        [_view_head addSubview:self.lab_balance];
        
        self.image_head.whc_TopSpace(5).whc_CenterX(0).whc_Size(80,80);
        self.lab_name.whc_TopSpaceToView(15,self.image_head).whc_CenterX(0);
        self.lab_balance.whc_TopSpaceToView(11.5,self.lab_name).whc_CenterX(0);
    }
    [self.lab_name setText:self.usermodel ? self.usermodel.username : @""];
    self.attri = [[NSMutableAttributedString alloc]init];
    self.attri1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",self.usermodel ? self.usermodel.coins : @""]];
    [self.attri appendAttributedString:self.string_attributed];
    [self.attri appendAttributedString:self.attri1];
    self.lab_balance.attributedText = self.attri;
    
    return _view_head;
}
-(void)Change_head{

    @weakify(self);
    LPActionSheet *sheet = [[LPActionSheet alloc]initWithTitle:@"更换头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从相册选择"] handler:^(LPActionSheet *actionSheet, NSInteger index) {
        @strongify(self);
        switch (index) {
            case 1:
                [self Camera_photo];
                break;
                
            case 2:
                [self Album_photo];
                break;
        }
    }];
    [sheet show];

}
-(void)Camera_photo{
    
    UIImagePickerController *imageVC=[[UIImagePickerController alloc]init];
    imageVC.delegate=self;
    imageVC.allowsEditing=YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //说明相机 可以使用 ；
        imageVC.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imageVC animated:YES completion:nil];
    }
}
-(void)Album_photo{
    
    TZImagePickerController *imagePC=[[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    imagePC.cropRect =CGMAKE((SCREEN_WIDTH-320)/2, (SCREEN_HEIGHT-320)/2, 320, 320);
    imagePC.allowCrop = YES;
    
    //不能发送视频
    imagePC.allowPickingVideo= NO;
    //不能选择原图
    imagePC.allowPickingOriginalPhoto=NO;
    [self presentViewController:imagePC animated:YES completion:nil];
    
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *img=info[UIImagePickerControllerEditedImage];
    [self UploadPhoto:img];
    
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    //上传图片
    [self UploadPhoto:photos[0]];
    
}
//点击取消 ；
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//上传头像
-(void)UploadPhoto:(UIImage *)image{
    NSArray *arr_image = [NSArray arrayWithObjects:image, nil];
    //上传图片
    @weakify(self);
    [HttpEngine uploadfile:arr_image comlete:^(BOOL susccess, id responseObjecct) {
        if (susccess) {
            
            MYLOG(@"%@",responseObjecct);
            
        }else{
        
            [MBProgressHUD showError:@"服务器繁忙"];
        }
        
    }];
}
#pragma mark 事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJViewController *view;
    switch (indexPath.section) {
        case 0:{
            view = [MyPostViewController new];
            
        }
            break;
        case 1:{
            
            
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
        case 5:{
            
            
        }
            break;
        case 6:{
            
            
        }
            break;
        case 7:{
            
            view = [[FansViewController alloc]initWithtype:@"关注"];
        }
            break;
        case 8:{
            
            view = [[FansViewController alloc]initWithtype:@"粉丝"];
            
        }
            break;
        case 9:{
            
            view = [AuthViewController new];
            
            
        }
            break;
    }
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}

-(void)PushSettting{

//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:8] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    SettingViewController *view = [SettingViewController new];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
@end
