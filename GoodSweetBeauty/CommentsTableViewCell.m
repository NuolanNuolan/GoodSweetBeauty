//
//  CommentsTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CommentsTableViewCell.h"
@interface CommentsTableViewCell(){
    
    //被评价人view
    UIView *view_Byevaluation;
    //被评价人头像
    UIImageView *image_head_Byevaluation;
    //被评价人name
    UILabel *lab_username_Byevaluation;
    //箭头
    UIImageView *image_arrow_Byevaluation;
    //line
    UIView *view_Byevaluation_line;
    
    //头像
    UIImageView *image_head;
    //用户name
    UILabel *lab_username;
    //时间
    UILabel *lab_time;
    //打分
    UILabel *lab_star;
    //star view
    UIView *view_star;
    //总共5个✨
    UIImageView *image_star;
    //项目名称
    UILabel *lab_productname;
    //主评论
    XXLinkLabel * lab_comments;
    //评论图片
    WHC_StackView *stack_imageview;
    //展开按钮
    UIButton *btn_open;
    //分享按钮 删除按钮
    UIButton *btn_share;
    UIButton *btn_del;
    
    commentsresults * momdel_comment;
    
    
    
}
@end

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self SetFrameForComments];
    }
    return self;
}
-(void)SetFrameForComments{

    view_Byevaluation = [UIView new];
    view_Byevaluation.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(user_click:)];
    [view_Byevaluation addGestureRecognizer:tap];
    view_Byevaluation.backgroundColor = [UIColor whiteColor];
    
    image_head_Byevaluation = [[UIImageView alloc]initWithRoundingRectImageView];
    image_head_Byevaluation.image = [UIImage imageNamed:@"bw_pla"];
    
    lab_username_Byevaluation = [UILabel new];
    [lab_username_Byevaluation setTextColor:GETFONTCOLOR];
    [lab_username_Byevaluation setFont:[UIFont boldSystemFontOfSize:15]];
    [lab_username_Byevaluation sizeToFit];
    
    image_arrow_Byevaluation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconArowRight"]];
    
    view_Byevaluation_line = [UIView new];
    [view_Byevaluation_line setBackgroundColor:RGB(247, 247, 247)];

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    
    lab_username = [UILabel new];
    [lab_username setTextColor:GETFONTCOLOR];
    [lab_username setFont:[UIFont systemFontOfSize:15]];
    [lab_username sizeToFit];
    
    lab_time  = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_star = [UILabel new];
    [lab_star setTextColor:GETFONTCOLOR];
    [lab_star setFont:[UIFont systemFontOfSize:11]];
    [lab_star setText:@"打分"];
    [lab_star sizeToFit];
    
    
    lab_productname = [UILabel new];
    [lab_productname setTextColor:GETFONTCOLOR];
    [lab_productname setFont:[UIFont systemFontOfSize:17]];
    [lab_productname sizeToFit];
    
    lab_comments = [XXLinkLabel new];
    lab_comments.userInteractionEnabled =YES;
    lab_comments.linkTextColor = GETMAINCOLOR;
    lab_comments.regularType = XXLinkLabelRegularTypeAboat;
    lab_comments.selectedBackgroudColor = [UIColor whiteColor];
    [lab_comments sizeToFit];
    
    btn_open = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_open setTitle:@"展开" forState:UIControlStateNormal];
    [btn_open setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    [btn_open addTarget:self action:@selector(open_click:) forControlEvents:UIControlEventTouchUpInside];
    btn_open.titleLabel.font = [UIFont systemFontOfSize:14];
    
    stack_imageview = [WHC_StackView new];
    stack_imageview.whc_Column = 3;               // 最大3列
    stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    stack_imageview.whc_HSpace = 4;                // 图片之间的空隙为4
    stack_imageview.whc_VSpace = 4;
    stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
    stack_imageview.whc_Orientation = All;        // 横竖混合布局
    
    btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_share.adjustsImageWhenHighlighted = NO;
    [btn_share setTitle:@"分享" forState:UIControlStateNormal];
    [btn_share addTarget:self action:@selector(btn_share_click) forControlEvents:UIControlEventTouchUpInside];
    btn_share.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_share setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_share.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_share.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_share setTitleEdgeInsets:UIEdgeInsetsMake(0,7,0,0)];
    [btn_share setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [btn_share setImage:[UIImage imageNamed:@"iconShareSm"] forState:UIControlStateNormal];
    
    btn_del = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_del.adjustsImageWhenHighlighted = NO;
    [btn_del setTitle:@"删除" forState:UIControlStateNormal];
    [btn_del addTarget:self action:@selector(btn_del_click:) forControlEvents:UIControlEventTouchUpInside];
    btn_del.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_del setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    btn_del.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_del.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_del setTitleEdgeInsets:UIEdgeInsetsMake(0,7,0,0)];
    [btn_del setImage:[UIImage imageNamed:@"iconDel"] forState:UIControlStateNormal];
    
   
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:lab_star];
    [self.contentView addSubview:lab_productname];
    [self.contentView addSubview:lab_comments];
    [self.contentView addSubview:btn_open];
    [self.contentView addSubview:btn_share];
    [self.contentView addSubview:btn_del];
    [self.contentView addSubview:stack_imageview];
    
    [self.contentView addSubview:view_Byevaluation];
    [view_Byevaluation addSubview:image_arrow_Byevaluation];
    [view_Byevaluation addSubview:image_head_Byevaluation];
    [view_Byevaluation addSubview:lab_username_Byevaluation];
    [view_Byevaluation addSubview:view_Byevaluation_line];
    
    for (int i=0; i<5; i++) {
        
        image_star = [UIImageView new];
        image_star.image = [UIImage imageNamed:@"dafenDefault"];
        image_star.tag = 100+i;
        [self.contentView addSubview:image_star];
        
        image_star.whc_Size(11,11).whc_CenterYToView(0,lab_star).whc_LeftSpaceToView(5+(i*14),lab_star);
        
    }
    
    view_Byevaluation.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpace(0).whc_Height(50);
    image_head_Byevaluation.whc_LeftSpace(15).whc_CenterY(0).whc_Size(28,28);
    lab_username_Byevaluation.whc_LeftSpaceToView(10,image_head_Byevaluation).whc_CenterY(0);
    image_arrow_Byevaluation.whc_RightSpace(15).whc_Size(7,13).whc_CenterY(0);
    
    view_Byevaluation_line.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(0.5).whc_BottomSpace(0);
    
    image_head.whc_Size(40,40).whc_LeftSpace(15).whc_TopSpaceToView(15,view_Byevaluation);
    
    lab_username.whc_LeftSpaceToView(10,image_head).whc_TopSpaceToView(20,view_Byevaluation);
    
    lab_time.whc_RightSpace(15).whc_TopSpaceToView(21,view_Byevaluation);
    
    lab_star.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(6,lab_username);
    
    lab_productname.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(15,lab_star).whc_RightSpace(15);
    
    lab_comments.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(15,lab_productname).whc_RightSpace(15);
    
    btn_open.whc_Size(35,15).whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(0,lab_comments);
    
    stack_imageview.whc_LeftSpaceEqualView(lab_username).whc_RightSpace(15).whc_TopSpaceToView(15,btn_open).whc_HeightAuto();
    
    btn_del.whc_RightSpace(15).whc_TopSpaceToView(15,stack_imageview).whc_Size(55,14);
    
    btn_share.whc_RightSpaceToView(40,btn_del).whc_TopSpaceEqualView(btn_del).whc_SizeEqualView(btn_del);
    
    self.whc_TableViewWidth = SCREEN_WIDTH;
    self.whc_CellBottomOffset = 15;
}

-(void)SetModel:(commentsresults *)resmodel withsection:(NSInteger )section{

    if (resmodel) {
        
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,resmodel.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        [lab_username setText:resmodel.from_member_name];
        
        view_Byevaluation.tag = resmodel.member_id;
        
        btn_del.tag = section;
        
        lab_username_Byevaluation.text = resmodel.member_name;
        
        [lab_time setText:[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)resmodel.created] withtype:@"MM-dd"]];
        //打分
        [self DealStar:resmodel.total_score];
        [lab_productname setText:[NSString stringWithFormat:@"产品: %@",resmodel.product_name]];
        //评论
        [self DealComment:resmodel withsection:section];
        //@用户点击
        [self DealAt:resmodel withsection:section];
        //图片
        [self DealImage:resmodel];
        
    }
}

//处理打分
-(void)DealStar:(NSInteger )star{

    for (int i =0; i<star; i++) {
        UIImageView *starview = [self viewWithTag:100+i];
        starview.image = [UIImage imageNamed:@"dafenActive"];
    }
}
//处理评论
-(void)DealComment:(commentsresults *)resmodel withsection:(NSInteger )section{

    NSDictionary *dic = [BWCommon textWithStatusRowHeight:resmodel.content Atarr:resmodel.ats font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:GETFONTCOLOR screenPadding:ScreenWidth-80];
    //判断是否有展开按钮
    CGFloat height = [dic[@"height"] floatValue];
    btn_open.tag = section;
    if (height<61) {
        //行数小于三行 不需要展开按钮
        lab_comments.numberOfLines = 0;
        btn_open.hidden =YES;
        btn_open.whc_Size(0,0).whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(0,lab_comments);
        
    }else{
    
        //看用户是否需要展开
        if (resmodel.isopen) {
            //展开
            lab_comments.numberOfLines = 0;
            btn_open.hidden =YES;
            btn_open.whc_Size(0,0).whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(0,lab_comments);
        }else{
            
            //不展开
            lab_comments.numberOfLines = 3;
            btn_open.hidden = NO;
            btn_open.whc_Size(35,15).whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(0,lab_comments);
        }
    }
    lab_comments.attributedText = dic[@"text"];
    
}
-(void)DealAt:(commentsresults *)resmodel withsection:(NSInteger )section{

    @weakify(self);
    lab_comments.regularLinkClickBlock = ^(NSString *clickedString) {
        @strongify(self);
        //正则提取出来的内容 包含@和空格
        NSString *str_result =  [clickedString substringFromIndex:1];
        
        str_result = [str_result substringToIndex:str_result.length-1];
        
        MYLOG(@"@的人: %@",str_result)
        if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"at",
                                                                 @"value":str_result,
                                                                 @"section":[NSString stringWithFormat:@"%ld",(long)section]}];
    };
}
-(void)user_click:(UITapGestureRecognizer *)tap{

    if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"top_at",
                                                             @"value":[NSNumber numberWithInteger:tap.view.tag]}];
}
//处理图片
-(void)DealImage:(commentsresults *)resmodel{

    momdel_comment = resmodel;
    [stack_imageview whc_RemoveAllSubviews];
    NSInteger newCount = resmodel.images.count;
    if (newCount==0) stack_imageview.whc_LeftSpaceEqualView(lab_username).whc_RightSpace(15).whc_TopSpaceToView(0,btn_open).whc_HeightAuto();
    else stack_imageview.whc_LeftSpaceEqualView(lab_username).whc_RightSpace(15).whc_TopSpaceToView(15,btn_open).whc_HeightAuto();
    
    NSInteger oldCount = stack_imageview.subviews.count;
    NSInteger countDiff = newCount - oldCount;
    
    for (int i =0; i<countDiff; i++) {
        
        UIImageView * imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = oldCount + i;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.backgroundColor = UIColorFromHex(0xE5E5E5);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,resmodel.images[i]]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        [stack_imageview addSubview:imageView];
    }
    [stack_imageview whc_StartLayout];

}

-(void)btn_share_click{

    MYLOG(@"分享")
}
-(void)btn_del_click:(UIButton *)btn{

    MYLOG(@"删除")
    if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"delete",
                                                             @"value":[NSNumber numberWithInteger:btn.tag]}];
    
}
- (void)tapImageGesture:(UITapGestureRecognizer *)tapGesture {
    
    
    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    for (int i=0; i<momdel_comment.images.count; i++) {
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = [NSString stringWithFormat:@"%@%@",ADDRESS_IMG,momdel_comment.images[i]];// 加载网络图片大图地址
        browseItem.smallImageView = stack_imageview.subviews[i];// 小图
        [arr_image_view addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tapGesture.view.tag];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];
    
}
//展开评论
-(void)open_click:(UIButton *)sender{

    //回调到主页面刷新
    if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"open",
                                                             @"value":[NSString stringWithFormat:@"%ld",(long)sender.tag]}];
}
@end
