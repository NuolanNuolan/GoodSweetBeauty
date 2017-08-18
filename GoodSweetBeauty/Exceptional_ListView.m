//
//  Exceptional_ListView.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/17.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "Exceptional_ListView.h"
#import "ExceptionalTableViewCell.h"
@interface Exceptional_ListView()<UITableViewDelegate,UITableViewDataSource>{
    
    
}
@property(nonatomic,copy)exceptionalListBlock exceptional_block;

@property(nonatomic,copy)NSArray *arr_data;

//主view
@property(nonatomic,retain)UIView *view_main;
//列表view
@property(nonatomic,retain)UIView *view_except;
//表格
@property(nonatomic,strong)UITableView *tableview;
//顶部的view
@property(nonatomic,strong)UIView *view_top;
//顶部lab
@property(nonatomic,strong)UILabel *lab_title;
//关闭按钮
@property(nonatomic,strong)UIButton *btn_close;


@end
@implementation Exceptional_ListView

+(instancetype)alertViewExceptional:(NSInteger )count_pserson
                         withAmount:(NSInteger )banlance
                       except_title:(NSMutableArray *)arr_model
              exceptionalblockclick:(exceptionalListBlock)exceptionalblock{

    return [[self alloc]initWithExceptional:count_pserson withAmount:banlance except_title:arr_model exceptionalblockclick:exceptionalblock];
}
-(instancetype)initWithExceptional:(NSInteger )count_pserson
                        withAmount:(NSInteger )banlance
                      except_title:(NSMutableArray *)arr_model
             exceptionalblockclick:(exceptionalListBlock)exceptionalblock{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        //排序算法
        self.arr_data = [self sortDescriptorWithCoins:arr_model];
        self.exceptional_block = exceptionalblock;
        //布局
        [self InitFrameExceptional:count_pserson withAmount:banlance except_title:arr_model];
        
        
    }
    return self;
    
}
-(void)InitFrameExceptional:(NSInteger )count_pserson
                 withAmount:(NSInteger )banlance
               except_title:(NSMutableArray *)arr_model{


    
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    //主view
    self.view_main = [UIView new];
    self.view_main.backgroundColor = [UIColor clearColor];
    //上部分view
    self.view_top = [UIView new];
    self.view_top.backgroundColor = [UIColor whiteColor];
    //title
    self.lab_title = [UILabel new];
    [self.lab_title setText:[NSString stringWithFormat:@"%ld人打赏 该帖共收到%ld有安币",(long)count_pserson,(long)banlance]];
    [self.lab_title setTextColor:RGB(143, 143, 143)];
    [self.lab_title setFont:[UIFont systemFontOfSize:13]];
    [self.lab_title sizeToFit];
    
    //line
    UIView *view_line = [UIView new];
    view_line.backgroundColor = RGB(229, 229, 229);
    
    
    
    
    //打赏列表view
    self.view_except = [UIView new];
    self.view_except.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 230) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight =44.0f;
    [self.tableview setSeparatorColor:RGB(229, 229, 229)];
    [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableview registerClass:[ExceptionalTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ExceptionalTableViewCell class])];
    
    
    self.btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_close setBackgroundColor:[UIColor whiteColor]];
    [self.btn_close setTitle:@"关闭" forState:UIControlStateNormal];
    [self.btn_close addTarget:self action:@selector(except_click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_close setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    self.btn_close.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    [self addSubview:self.view_main];
    
    [self.view_top addSubview:self.lab_title];
    [self.view_top addSubview:view_line];
    
    [self.view_except addSubview:self.tableview];
    
    [self.view_main addSubview:self.view_top];
    [self.view_main addSubview:self.view_except];
    [self.view_main addSubview:self.btn_close];
    
    
    //开始布局
    self.view_main.whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0).whc_Height(339);
    
    self.view_top.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(44).whc_TopSpace(0);
    self.lab_title.whc_CenterX(0).whc_CenterY(0);
    view_line.whc_Height(0.5).whc_LeftSpace(15).whc_RightSpace(15).whc_BottomSpace(0);
    self.view_except.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(230).whc_TopSpaceToView(0,self.view_top);
    
    
    self.btn_close.whc_BottomSpace(0).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(56);
    
}
//按照有安币进行排序
-(NSArray *)sortDescriptorWithCoins:(NSMutableArray *)arr{

    NSSortDescriptor *ageSD = [NSSortDescriptor sortDescriptorWithKey:@"coins" ascending:NO];
    
    return [arr sortedArrayUsingDescriptors:@[ageSD]];
}
#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr_data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExceptionalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExceptionalTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetRewardsModel:self.arr_data[indexPath.row] withrow:indexPath.row];
    cell.delegateSignal = [RACSubject subject];
    @weakify(self);
    [cell.delegateSignal subscribeNext:^(id x) {
        //用户详情
        @strongify(self);
        [self DealWith:x];
    }];
    return cell;
    
    
    
}













-(void)DealWith:(NSDictionary *)dic{


    if (self.exceptional_block) {
        
        self.exceptional_block(self,[dic[@"value"] integerValue]);
    }
}
-(void)show{

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.view_main.frame, point))
    {
        [self dismiss];
    }
}
- (void)dismiss
{
    [self removeFromSuperview];
    
    
}
-(void)except_click{
    
    [self dismiss];
}

-(void)dealloc{

    MYLOG(@"打赏列表释放")
}


@end
