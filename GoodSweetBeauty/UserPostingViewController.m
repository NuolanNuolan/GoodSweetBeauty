//
//  UserPostingViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "UserPostingViewController.h"
#import "PostingTitleTableViewCell.h"
#import "PostingTableViewCell.h"
#import "YouAnTextLinePositionModifier.h"
#import "UIView+YYAdd.h"
#import "PostingImageTableViewCell.h"

@interface UserPostingViewController ()<UITableViewDataSource,UITableViewDelegate,YYTextKeyboardObserver,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic, strong) UIView * toolbar;
//选择图片按钮
@property (nonatomic, strong)UIButton *btn_choose_image;
//表情
@property (nonatomic, strong)UIButton *btn_choose_emoji;
//@按钮
@property (nonatomic, strong)UIButton *btn_choose_at;

//用户输入的标题
@property(nonatomic,strong)NSString *str_title;
//用户输入的帖子内容
@property(nonatomic,strong)NSString *str_posting_deatil;
//用户选择的图片数组
@property(nonatomic,strong)NSMutableArray *arr_image;


@property(nonatomic,strong)UITableView *tableview;
@end

@implementation UserPostingViewController
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self CreateTableview];
    [self CreateToolbar];
    
    
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.title = @"发帖";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *button_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [button_left setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                     NSForegroundColorAttributeName :RGB(51, 51, 51)} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = button_left;

    UIBarButtonItem *button_right = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(input)];
    [button_right setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                     NSForegroundColorAttributeName :GETMAINCOLOR} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = button_right;
    
}
-(void)CreateTableview{
    
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"PostingTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[PostingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PostingTableViewCell class])];
    [self.tableview registerClass:[PostingImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PostingImageTableViewCell class])];
    [self.view addSubview:self.tableview];
}
-(void)CreateToolbar{

    _toolbar = [[UIView alloc]initWithFrame:CGMAKE(0, self.view.height-46, self.view.width, 46)];
    _toolbar.backgroundColor = RGB(246, 246, 246);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolbar];
    [self toolbarbtn];
    
}
-(void)toolbarbtn{

    NSArray *arr_image ;
    if (self.type == YouAnStatusComposeViewTypePostTing) arr_image = [NSArray arrayWithObjects:@"iconImg",@"iconBiaoqing", nil];
    else arr_image = [NSArray arrayWithObjects:@"iconImg",@"iconBiaoqing",@"icon_At", nil];
    
    for (int i =0; i<arr_image.count; i++) {
        
        UIView *view = [UIView new];
        view.backgroundColor = RGB(246, 246, 246);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.exclusiveTouch = YES;
        button.tag = 100+i;
        [button setImage:[UIImage imageNamed:arr_image[i]] forState:UIControlStateNormal];
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_toolbar addSubview:view];
        button.whc_Size(46,46).whc_CenterX(0).whc_CenterY(0);
        switch (i) {
            case 0:{
                
            view.whc_LeftSpace(0).whc_TopSpace(0).whc_BottomSpace(0).whc_Height(46).whc_Width(ScreenWidth/3);
                
            }
                break;
            case 1:{
                
                view.whc_LeftSpace(ScreenWidth/3).whc_TopSpace(0).whc_BottomSpace(0).whc_Height(46).whc_Width(ScreenWidth/3);
            }
                break;
            case 2:{
                
                view.whc_LeftSpace(ScreenWidth*2/3).whc_TopSpace(0).whc_BottomSpace(0).whc_Height(46).whc_Width(ScreenWidth/3);
            }
                break;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return [PostingImageTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            break;
            
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    switch (indexPath.section) {
        case 0:{
            
            PostingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.delegateSignal = [RACSubject subject];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                self.str_title = [NSString stringWithFormat:@"%@",x];
                
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
        case 1:{
        
            PostingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegateSignal = [RACSubject subject];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                self.str_posting_deatil = [NSString stringWithFormat:@"%@",x];
            }];
            return cell;
        }
            break;
        case 2:{
        
            PostingImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingImageTableViewCell class])];
            [cell Setimage:self.arr_image];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
    }
    return nil;
    
}
#pragma mark @protocol YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        
        _toolbar.bottom = CGRectGetMinY(toFrame);
        
    } else {
        
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            _toolbar.bottom = CGRectGetMinY(toFrame);
            
            
        } completion:NULL];
    }
}
-(void)buttonClicked:(UIButton *)sender{

    switch (sender.tag) {
        case 100:{
            
            [self chooseimage];
            
        }
            break;
        case 101:{
            
            
        }
            break;
        case 102:{
            
            
        }
            break;
    }
}
//选择图片
-(void)chooseimage{
    
    [self.view endEditing:YES];
    TZImagePickerController *imagePC=[[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
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
    
    
    
    
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    MYLOG(@"%@",assets);
    self.arr_image = [NSMutableArray arrayWithArray:assets];
    //刷新第三行
    NSIndexPath *indexpathone = [NSIndexPath indexPathForItem:0 inSection:2];
    [self.tableview reloadRowsAtIndexPaths:@[indexpathone] withRowAnimation:UITableViewRowAnimationNone];
}

//点击取消 ；
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)input{

    if (!self.str_title||[self.str_title isEqualToString:@""]||!self.str_posting_deatil||[self.str_posting_deatil isEqualToString:@""]) {
        return;
    }
    MYLOG(@"\n标题\n%@\n内容\n%@",self.str_title,self.str_posting_deatil);
}
-(void)cancel{

    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSMutableArray *)arr_image{

    if (!_arr_image) {
        
        _arr_image  = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr_image;
}
@end
