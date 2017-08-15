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
#import "BackCommentTableViewCell.h"
#import "WBEmoticonInputView.h"
#import "AtChooseViewController.h"
#import "PostStarTableViewCell.h"
#import "ChooseProductTableViewCell.h"


@interface UserPostingViewController ()<UITableViewDataSource,UITableViewDelegate,YYTextKeyboardObserver,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate,WBStatusComposeEmoticonViewDelegate,YYTextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;


@property (nonatomic, strong) UIView * toolbar;
//选择图片按钮
@property (nonatomic, strong)UIButton *btn_choose_image;
//表情
@property (nonatomic, strong)UIButton *btn_choose_emoji;
//@按钮
@property (nonatomic, strong)UIButton *btn_choose_at;

//用户输入的标题
@property(nonatomic,copy)NSString *str_title;
//用户输入的帖子内容
@property(nonatomic,copy)NSString *str_posting_deatil;
//用户选择的图片数组
@property(nonatomic,strong)NSMutableArray *arr_image;
//图片上传的URL
@property(nonatomic,strong)NSMutableArray *arr_image_url;
//回复的时候@的人
@property(nonatomic,strong)NSMutableArray *Arr_at;

//口碑评价
@property(nonatomic,assign)NSInteger product_score;
@property(nonatomic,assign)NSInteger service_score;

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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
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

    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *button_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [button_left setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                     NSForegroundColorAttributeName :GETFONTCOLOR} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = button_left;

    UIBarButtonItem *button_right = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(input)];
    [button_right setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                     NSForegroundColorAttributeName :GETMAINCOLOR} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = button_right;
    
}
-(void)CreateTableview{
    
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-46) style:UITableViewStyleGrouped];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview registerClass:[PostingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PostingTableViewCell class])];
    [self.tableview registerClass:[PostingImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PostingImageTableViewCell class])];
    
    [self.view addSubview:self.tableview];
    switch (_type) {
        case YouAnStatusComposeViewTypePostTing:
            self.title = @"发帖";
            self.tableview.backgroundColor = [UIColor whiteColor];
            [self.tableview registerNib:[UINib nibWithNibName:@"PostingTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
            break;
        case YouAnStatusComposeViewTypeStatus:
            self.title = @"回复";
            self.tableview.backgroundColor=RGB(247, 247, 247);
            break;
        case YouAnStatusComposeViewTypeComment:
            self.title = @"回复";
            self.tableview.backgroundColor=RGB(247, 247, 247);
            [self.tableview registerNib:[UINib nibWithNibName:@"BackCommentTableViewCell"bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"cell"];
            break;
        case YouAnStatusComposeViewTypePostKouBei:
            self.title = @"发表评论";
            [self.tableview registerClass:[PostStarTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PostStarTableViewCell class])];
            [self.tableview registerNib:[UINib nibWithNibName:@"ChooseProductTableViewCell"bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"cell"];
            self.tableview.backgroundColor = [UIColor whiteColor];
            break;
    }
}
-(void)CreateToolbar{

    _toolbar = [[UIView alloc]initWithFrame:CGMAKE(0, self.view.height-46, self.view.width, 46)];
    _toolbar.backgroundColor = RGB(246, 246, 246);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *view_toolbar_top = [[UIView alloc]initWithFrame:CGMAKE(0, 0, ScreenWidth, 0.5)];
    view_toolbar_top.backgroundColor = RGB(224, 224, 224);
    
    UIView *view_toolbar_bot = [[UIView alloc]initWithFrame:CGMAKE(0, 46-0.5, ScreenWidth, 0.5)];
    view_toolbar_bot.backgroundColor = RGB(224, 224, 224);
    
    [_toolbar addSubview:view_toolbar_top];
    [_toolbar addSubview:view_toolbar_bot];
    [self.view addSubview:_toolbar];
    [self toolbarbtn];
    
}
-(void)toolbarbtn{

    NSArray *arr_image ;
//    if (self.type == YouAnStatusComposeViewTypePostTing) arr_image = [NSArray arrayWithObjects:@"iconImg",@"iconBiaoqing", nil];
//    else arr_image = [NSArray arrayWithObjects:@"iconImg",@"iconBiaoqing",@"icon_At", nil];
    arr_image = [NSArray arrayWithObjects:@"iconImg",@"iconBiaoqing",@"icon_At", nil];
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
        button.whc_Size(45.5,45.5).whc_CenterX(0).whc_CenterY(0);
        switch (i) {
            case 0:{
                self.btn_choose_image = button;
            view.whc_LeftSpace(0).whc_TopSpace(0.5).whc_BottomSpace(0).whc_Height(45.5).whc_Width(ScreenWidth/3);
                
            }
                break;
            case 1:{
                self.btn_choose_emoji = button;
                view.whc_LeftSpace(ScreenWidth/3).whc_TopSpace(0.5).whc_BottomSpace(0).whc_Height(45.5).whc_Width(ScreenWidth/3);
            }
                break;
            case 2:{
                self.btn_choose_at = button;
                view.whc_LeftSpace(ScreenWidth*2/3).whc_TopSpace(0.5).whc_BottomSpace(0).whc_Height(45.5).whc_Width(ScreenWidth/3);
            }
                break;
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    switch (_type) {
        case YouAnStatusComposeViewTypePostTing:
            return 3;
            break;
        case YouAnStatusComposeViewTypeStatus:
            return 2;
            break;
        case YouAnStatusComposeViewTypeComment:
            return 3;
            break;
        case YouAnStatusComposeViewTypePostKouBei:
            return 4;
            break;
    }
    return 1;
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
        case 0:{
        
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:{
                    
                    return 50;
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    return 150;
                    
                }
                    break;
                case YouAnStatusComposeViewTypeComment:{
                    
                    return 50;
                    
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                    return 100;
                    
                }
                    break;
            }
        }
            break;
        case 1:{
        
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:{
                    return 150;
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    return [PostingImageTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                }
                    break;
                case YouAnStatusComposeViewTypeComment:{
                    
                    return 150;
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                    return 55.5f;
                }
                    break;
            }
        }
            break;
        case 2:{
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:{
                    
                    return [PostingImageTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    
                }
                    break;
                case YouAnStatusComposeViewTypeComment:{
                    
                    return [PostingImageTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                    return 150;
                }
                    break;
            }
        }
        case 3:{
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:{
                    
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    
                }
                    break;
                case YouAnStatusComposeViewTypeComment:{
                    
                    
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                   return [PostingImageTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                }
                    break;
            }
        }
            break;
            
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    switch (indexPath.section) {
        case 0:{
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:{
                    
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
                case YouAnStatusComposeViewTypeStatus:{
                    
                    PostingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingTableViewCell class])];
                    [cell settype:_type];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    self.textView = cell.textView;
                    self.textView.delegate =self;
                    return cell;
                }
                    break;
                case YouAnStatusComposeViewTypeComment:{
                    
                    BackCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell setPostsModel:self.postsmodel];
                    
                    return cell;
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                    PostStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostStarTableViewCell class])];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegateSignal = [RACSubject subject];
                    @weakify(self);
                    [cell.delegateSignal subscribeNext:^(id x) {
                        @strongify(self);
                        
                        if ([x[@"type"] isEqualToString:@"product_score"]){
                            
                            self.product_score = [x[@"product_score"] intValue];
                            
                        }else if ([x[@"type"] isEqualToString:@"service_score"]){
                            
                            self.service_score = [x[@"service_score"] intValue];
                        }
                        
                    }];
                    
                    
                    return cell;
                }
                    break;
            }

            
        }
            break;
        case 1:{
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing:
                case YouAnStatusComposeViewTypeComment:{
                    
                    PostingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingTableViewCell class])];
                    [cell settype:_type];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    self.textView = cell.textView;
                    self.textView.delegate =self;
                    return cell;
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    PostingImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingImageTableViewCell class])];

                    [cell Setimage:self.arr_image];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegateSignal = [RACSubject subject];
                    @weakify(self);
                    [cell.delegateSignal subscribeNext:^(id x) {
                        @strongify(self);
                        if ([x isKindOfClass:[NSString class]]) {
                            
                            [self CancelImageupload:x];
                            
                        }else{
                            
                            [self ToViewLarger:x];
                        }
                        
                    }];
                    return cell;
                    
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                    
                    ChooseProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegateSignal = [RACSubject subject];
                    @weakify(self);
                    [cell.delegateSignal subscribeNext:^(id x) {
                        @strongify(self);
                        
                        if ([x[@"type"] isEqualToString:@"productname"]) {
                            
                            self.str_title = [NSString stringWithFormat:@"%@",x[@"productname"]];
                        }else if ([x[@"type"] isEqualToString:@"product_score"]){
                        
                            self.product_score = [x[@"product_score"] intValue];
                            
                        }else if ([x[@"type"] isEqualToString:@"service_score"]){
                            
                            self.service_score = [x[@"service_score"] intValue];
                        }
                        
                    }];
                    return cell;
                }
                    break;
            }
        }
            break;
        case 2:{
            switch (_type) {
                case YouAnStatusComposeViewTypePostTing :
                case YouAnStatusComposeViewTypeComment  :{
                    
                    PostingImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingImageTableViewCell class])];
                    [cell Setimage:self.arr_image];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegateSignal = [RACSubject subject];
                    @weakify(self);
                    [cell.delegateSignal subscribeNext:^(id x) {
                        @strongify(self);
                        if ([x isKindOfClass:[NSString class]]) {
                            
                            [self CancelImageupload:x];
                            
                        }else{
                            
                            [self ToViewLarger:x];
                        }
                        
                    }];
                    return cell;
                }
                    break;
                case YouAnStatusComposeViewTypeStatus:{
                    
                    
                }
                    break;
                case YouAnStatusComposeViewTypePostKouBei:{
                
                    PostingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingTableViewCell class])];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    [cell settype:_type];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    self.textView = cell.textView;
                    self.textView.delegate =self;
                    return cell;
                }
                    break;
            }
        }
            break;
        case 3:{

            PostingImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PostingImageTableViewCell class])];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell Setimage:self.arr_image];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegateSignal = [RACSubject subject];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(id x) {
                @strongify(self);
                if ([x isKindOfClass:[NSString class]]) {
                    
                    [self CancelImageupload:x];
                    
                }else{
                    
                    [self ToViewLarger:x];
                }
                
            }];
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
            
            [self chooseemoji];
        }
            break;
        case 102:{
            
            //@人
            [self AtPerson];
        }
            break;
    }
}
//选择图片
-(void)chooseimage{
    
    if (self.arr_image.count==9) return;
    [self.view endEditing:YES];
    TZImagePickerController *imagePC=[[TZImagePickerController alloc]initWithMaxImagesCount:9-self.arr_image.count delegate:self];
    //不能发送视频
    imagePC.allowPickingVideo= NO;
    //不能选择原图
    imagePC.allowPickingOriginalPhoto=NO;
    [self presentViewController:imagePC animated:YES completion:nil];
    
}
//表情键盘
-(void)chooseemoji{

    if (_textView.inputView) {
        
        _textView.inputView = nil;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        [_btn_choose_emoji setImage:[UIImage imageNamed:@"iconBiaoqing"] forState:UIControlStateNormal];
    }else{
    
        WBEmoticonInputView *v = [WBEmoticonInputView sharedView];
        v.delegate = self;
        _textView.inputView = v;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        [_btn_choose_emoji setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
    }
    
    
    
}

/**
 跳转@页面
 */
-(void)AtPerson{

    if ([_textView becomeFirstResponder]) {
        
        AtChooseViewController *view = [AtChooseViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:view];
        @weakify(self);
        view.popblock=^ (){
            @strongify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.textView becomeFirstResponder];
            });
        };
        view.modelblock=^(YouAnFansFollowModel *model){
            @strongify(self);
            
            [self AtDealWith:model];
        };
        [self presentViewController:navigationController animated:YES completion:nil];
        
        
    }
}
//at人数处理
-(void)AtDealWith:(YouAnFansFollowModel *)model{

    MYLOG(@"%@",model.username);
    NSString *str = [NSString stringWithFormat:@"@%@ ",model.username];
    
    if (self.Arr_at.count==0) {
        
        [self.Arr_at addObject:model];
        [self.textView replaceRange:self.textView.selectedTextRange withText:str];
        
    }else{
        
        if (self.Arr_at.count==5) {
            
            [MBProgressHUD showError:@"您最多@5人哦" toView:self.view];
            return ;
        }
        //判断是否能添加
        BOOL isCanAdd = TRUE;
        for (YouAnFansFollowModel*Arr_model in self.Arr_at) {
            if (model.id == Arr_model.id) {
                
                isCanAdd = FALSE;
                //判断文本框里面有没有这个人 如果没有添加进文本框
                if (![BWCommon DoesItInclude:self.textView.text withString:str]) {
                    //不存在
                    [self.textView replaceRange:self.textView.selectedTextRange withText:str];
                }
                break;
            }
        }
        if (isCanAdd) {

            [self.Arr_at addObject:model];
            [self.textView replaceRange:self.textView.selectedTextRange withText:str];
        }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *img=info[UIImagePickerControllerEditedImage];
    //上传图片 刷新
    [self.arr_image addObject:img];
    //刷新第三行
    NSIndexPath *indexpathone;
    switch (_type) {
        case YouAnStatusComposeViewTypePostTing:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:2];
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:1];
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:2];
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:3];
        }
            break;
    }
    [self.tableview reloadRowsAtIndexPaths:@[indexpathone] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self.arr_image addObjectsFromArray:photos];
    //刷新第三行
    NSIndexPath *indexpathone;
    switch (_type) {
        case YouAnStatusComposeViewTypePostTing:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:2];
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:1];
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:2];
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            indexpathone = [NSIndexPath indexPathForItem:0 inSection:3];
        }
            break;
    }
    
    [self.tableview reloadRowsAtIndexPaths:@[indexpathone] withRowAnimation:UITableViewRowAnimationNone];
}

//点击取消 ；
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
-(NSMutableArray *)arr_image_url{

    if (!_arr_image_url) {
        
        _arr_image_url  = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr_image_url;
}
//用户删除了图片 删除视图 取消网络请求 重新上传
-(void)CancelImageupload:(id )x{
    
    //删除图片数组某个数组
    [self.arr_image removeObjectAtIndex:[x intValue]];
    
}
-(void)input{
    
    //根据各种状态的不同来区分发表的类型
    switch (_type) {
        case YouAnStatusComposeViewTypePostTing:{
            
            if (!self.str_title||[self.str_title isEqualToString:@""]||!self.str_posting_deatil||[self.str_posting_deatil isEqualToString:@""]) {
                return;
            }
            [self Postting];
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            if (!self.str_posting_deatil||[self.str_posting_deatil isEqualToString:@""]) {
                return;
            }
            [self ReplytoPoster];
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            if (!self.str_posting_deatil||[self.str_posting_deatil isEqualToString:@""]) {
                return;
            }
            [self ReplyFloor];
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            if (!self.str_posting_deatil||[self.str_posting_deatil isEqualToString:@""]) {
                
                return;
            }
            [self Postrating];
        }
            break;
    }
}

/**
 发帖事件
 */
-(void)Postting{

    
    NSDictionary *dic_at = [BWCommon PredicateAt:self.str_posting_deatil Atarr:self.Arr_at];
    MYLOG(@"内容:%@@的人:%@",dic_at[@"content"],dic_at[@"at"]);
    if ([dic_at[@"content"] isEqualToString:@""]) {
        [MBProgressHUD showError:@"内容不能为空"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [self.str_title stringByReplacingEmojiUnicodeToCheatCodes],@"subject",
                                dic_at[@"content"],@"content",
                                dic_at[@"at"],@"at",
                                [BWCommon getIpAddresses],@"user_ip", nil];
    [ZFCWaveActivityIndicatorView show:self.view];
    @weakify(self);
    [HttpEngine UserPostting:dic witharrimage:self.arr_image withtype:_type withpk:0 complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            MYLOG(@"%@",responseObject);
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
        
            
        }
        
        
        
    }];
}

/**
 发表对于楼主的回复
 */
-(void)ReplytoPoster{
    
    NSDictionary *dic_at = [BWCommon PredicateAt:self.str_posting_deatil Atarr:self.Arr_at];
    MYLOG(@"内容:%@@的人:%@",dic_at[@"content"],dic_at[@"at"]);
    if ([dic_at[@"content"] isEqualToString:@""]) {
        [MBProgressHUD showError:@"内容不能为空"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    dic_at[@"content"],@"content",
                                    [BWCommon getIpAddresses],@"user_ip",
                                    dic_at[@"at"],@"at",
                                    nil];    
    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine UserPostting:dic witharrimage:self.arr_image withtype:_type withpk:_pk complete:^(BOOL success, id responseObject) {
        @strongify(self);
        [ZFCWaveActivityIndicatorView show:self.view];
        
        if (success) {
            MYLOG(@"%@", responseObject);
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ISREFRESH"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
        
            
        }
        
    }];

    
}

/**
 回复评论
 */
-(void)ReplyFloor{

    NSDictionary *dic_at = [BWCommon PredicateAt:self.str_posting_deatil Atarr:self.Arr_at];
    MYLOG(@"内容:%@@的人:%@",dic_at[@"content"],dic_at[@"at"]);
    if ([dic_at[@"content"] isEqualToString:@""]) {
        [MBProgressHUD showError:@"内容不能为空"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                dic_at[@"content"],@"content",
                                [BWCommon getIpAddresses],@"user_ip",
                                dic_at[@"at"],@"at",
                                [NSNumber numberWithInteger:self.postsmodel.id],@"father_id",nil];
    
    
    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine UserPostting:dic witharrimage:self.arr_image withtype:_type withpk:_pk complete:^(BOOL success, id responseObject) {
        @strongify(self);
        MYLOG(@"%@", responseObject);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            //返回之前存入一个值 需要刷新
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ISREFRESH"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
        

        }
        

    }];
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ISREFRESH"];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 口碑评价
 */
-(void)Postrating{

    
    if ([self.str_title isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"产品名称不能为空"];
        return;
    }
    NSDictionary *dic_at = [BWCommon PredicateAt:self.str_posting_deatil Atarr:self.Arr_at];
    MYLOG(@"内容:%@@的人:%@",dic_at[@"content"],dic_at[@"at"]);
    if ([dic_at[@"content"] isEqualToString:@""]) {
        [MBProgressHUD showError:@"评论内容不能为空"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                dic_at[@"content"],@"content",
                                [BWCommon getIpAddresses],@"user_ip",
                                dic_at[@"at"],@"at",
                                self.product_score==0?[NSNumber numberWithInteger:5]:[NSNumber numberWithInteger:self.product_score],@"product_score",
                                self.service_score==0?[NSNumber numberWithInteger:5]:[NSNumber numberWithInteger:self.service_score],@"service_score",
                                [NSNumber numberWithInteger:self.member_id],@"member_id",
                                self.str_title,@"product_name",nil];
    
    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine UserPostting:dic witharrimage:self.arr_image withtype:_type withpk:0 complete:^(BOOL success, id responseObject) {
        @strongify(self);
        MYLOG(@"%@", responseObject);
        [ZFCWaveActivityIndicatorView hid:self.view];
        if (success) {
            
            //返回之前存入一个值 需要刷新
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            
            
        }
        
        
    }];
    
    
    

}
//浏览大图
-(void)ToViewLarger:(id )x{

    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr_image = [NSMutableArray arrayWithArray:x[@"imagearr"]];
    UIView *view = x[@"imageviewarr"];
    for (int i=0; i<arr_image.count; i++) {
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImage = arr_image[i];
        browseItem.smallImageView = view.subviews[i];
        [arr_image_view addObject:browseItem];
    }
    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:[x[@"tag"] intValue]];
     bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:self];

}
#pragma mark @protocol YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
    
    self.str_posting_deatil = textView.text;
    if ([textView.text isEqualToString:@""]) {
        
        [self.Arr_at removeAllObjects];
    }
}
#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [_textView replaceRange:_textView.selectedTextRange withText:text];
    }
}

- (void)emoticonInputDidTapBackspace {
    [_textView deleteBackward];
}

//懒加载
-(NSMutableArray *)Arr_at{

    if (!_Arr_at) {
        _Arr_at = [NSMutableArray arrayWithCapacity:0];
    }
    return _Arr_at;
}
@end
