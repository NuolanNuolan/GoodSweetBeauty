//
//  AtChooseViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AtChooseViewController.h"

#import "BMChineseSort.h"
#import "AtContactTableViewCell.h"
#import "AtTitleheadview.h"
#import "UIView+Utils.h"
#import "CustomTextField.h"
@interface AtChooseViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{

    
}
@property(nonatomic,strong)NSMutableSet *set_arr;
@property(nonatomic,strong)CustomTextField *text_search;
//搜索到的数据
@property(nonatomic,strong)NSMutableArray *Arr_search;
@property(nonatomic,strong)UITableView *tableview;

//定义page
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)YouAnFansFollowModel *model;

//初始的数据
@property(nonatomic,strong)NSMutableArray *dataArray;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

//返回的数据
@property(nonatomic,strong)NSMutableArray *apiArray;
@end

@implementation AtChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self InitData];
    [self CreateUI];
    [self LoadData];
    
    
    // Do any additional setup after loading the view.
}
-(void)InitData{

    self.page = 1;
    self.set_arr = [[NSMutableSet alloc]initWithCapacity:0];
}
-(void)CreateUI{

    self.title = @"联系人";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *button_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(Pop_click)];
    [button_left setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                          NSForegroundColorAttributeName :RGB(51, 51, 51)} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = button_left;
    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight = 60.0f;
    self.tableview.sectionHeaderHeight = 28.0f;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    self.tableview.sectionIndexColor = RGB(102, 102, 102);
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableview registerClass:[AtTitleheadview class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([AtTitleheadview class])];
    [self.tableview registerClass:[AtContactTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AtContactTableViewCell class])];
    [self.view addSubview:self.tableview];
    //搜索框
    UIView *view = [[UIView alloc]initWithFrame:CGMAKE(0, 64, ScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    //左视图
    UIView *view_left = [[UIView alloc]initWithFrame:CGMAKE(0, 0, 28, 28)];
    view_left.backgroundColor = [UIColor clearColor];
    UIImageView *image_left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search-Glyph"]];
    image_left.frame = CGMAKE(7, 8, 13.5, 13.5);
    
    [view_left addSubview:image_left];
    
    
    self.text_search = [[CustomTextField alloc]initWithFrame:CGMAKE(8, 8, ScreenWidth-16, 28)];
    self.text_search.placeholder = @"搜索联系人";
    self.text_search.layer.masksToBounds =YES;
    self.text_search.layer.cornerRadius = 14.0f;
    self.text_search.backgroundColor = RGB(234, 235, 236);
    self.text_search.leftView = view_left;
    self.text_search.leftViewMode = UITextFieldViewModeAlways;
    self.text_search.tintColor = GETMAINCOLOR;
    self.text_search.font = [UIFont systemFontOfSize:14];
    self.text_search.textColor = RGB(51, 51, 51);
    UIColor * color = RGB(153, 153, 153);
    [self.text_search setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    UIFont * font = [UIFont systemFontOfSize:14];
    [self.text_search setValue:font forKeyPath:@"_placeholderLabel.font"];
    self.text_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text_search.returnKeyType =UIReturnKeySearch;
    @weakify(self);
    [[self.text_search rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
        [self SearchUsername:x];
    }];
    
    [view addSubview:self.text_search];
    [self.view addSubview:view];
    
    
    
    
    
    
}
-(void)Pop_click{

    self.popblock();
    [self dismissViewControllerAnimated:YES completion:nil];
}
//加载数据
-(void)LoadData{

    //我关注的人And关注我的人
    //两个请求  队列
    [self.apiArray removeAllObjects];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    @weakify(self);
    [ZFCWaveActivityIndicatorView show:self.view];
    [HttpEngine UserFanspage:self.page pagesize:50 complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            @synchronized (self.apiArray) {
                [self.apiArray addObjectsFromArray:responseObject];
                dispatch_group_leave(group);
            }
        }
        
        
    }];
    [HttpEngine Userfollowupspage:self.page pagesize:50 complete:^(BOOL success, id responseObject) {
        @strongify(self);
        if (success) {
            
            MYLOG(@"%@",responseObject)
            @synchronized (self.apiArray) {
                [self.apiArray addObjectsFromArray:responseObject];
                dispatch_group_leave(group);

            }
        }
        
        
    }];
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MYLOG(@"请求完成")
        //取消刷新状态
        if (self.apiArray.count==0) {
            MYLOG(@"提示没有更多数据")
            
        }else{
            for (NSDictionary * dic in self.apiArray) {
                //去重
                if (![self.set_arr containsObject:dic[@"username"]]) {
                    MYLOG(@"%@",dic[@"username"])
                    self.model = [YouAnFansFollowModel whc_ModelWithJson:dic];
                    //把username 添加一个拼音字段
                    self.model.pinyin = [BWCommon Pinyin:self.model.username];
                    [self.dataArray addObject:self.model];
                }
                [self.set_arr addObject:dic[@"username"]];
            }
            
            [self Sorting:self.dataArray];
            
            GCD_MAIN(
                     [ZFCWaveActivityIndicatorView hid:self.view];
                     [self.tableview reloadData];
                     );
        }
    });
    
    
    
    
}
#pragma mark - UITableView -
//section的titleHeader
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    AtTitleheadview *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([AtTitleheadview class])];
    
    [view Settitle:[self.indexArray objectAtIndex:section]];
    
    return view;
    
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.indexArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArr objectAtIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AtContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AtContactTableViewCell class])];
    //获得对应的Person对象<替换为你自己的model对象>
    _model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell SetModel:_model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.modelblock([[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    [self Pop_click];
    
}

/**
 搜索用户名
 */
-(void)SearchUsername:(NSString *)text{
    
    //去掉空格
    if (![[text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [self.Arr_search removeAllObjects];
        //首字母排序
//        int ismatching_count = 0;
        //从data中搜索
        //再对结果进行排序
        
        for (YouAnFansFollowModel *model in self.dataArray) {
            
            if ([BWCommon DoesItIncludeBetween:model.username withString:text]||[BWCommon DoesItIncludeBetween:model.pinyin withString:text]) {
                
                [self.Arr_search addObject:model];
                
            }
//            NSArray *arr = [model.pinyin componentsSeparatedByString:@" "];
//            if (arr.count>=text.length) {
//                
//                for (int i =0; i<text.length; i++) {
//                    //首字母匹配
//                    if ([[text substringWithRange:NSMakeRange(i, 1)] rangeOfString:[arr[i] substringWithRange:NSMakeRange(0, 1)] options:NSCaseInsensitiveSearch].location == NSNotFound) {
//                        MYLOG(@"不匹配")
//                        
//                        break;
//                    }else{
//                    
//                        
//                        break;
//                    }
//                }
//            }
        }
        
        //排序
        [self Sorting:self.Arr_search];
        [self.tableview reloadData];
        
    }else{
    
        [self Sorting:self.dataArray];
        [self.tableview reloadData];
    }
    
}
//排序算法
-(void)Sorting:(NSMutableArray *)arr{

    self.indexArray = [BMChineseSort IndexWithArray:arr Key:@"username"];
    self.letterResultArr = [BMChineseSort sortObjectArray:arr Key:@"username"];
}






-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataArray;
}
-(NSMutableArray *)indexArray{

    if (!_indexArray) {
        
        _indexArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _indexArray;
}
-(NSMutableArray *)letterResultArr{

    if (!_letterResultArr) {
        
        _letterResultArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _letterResultArr;
}
-(NSMutableArray *)apiArray{

    if (!_apiArray) {
        
        _apiArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _apiArray;
}
-(NSMutableArray *)Arr_search{

    if (!_Arr_search) {
        _Arr_search = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _Arr_search;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.text_search resignFirstResponder];
    
}
@end
