//
//  CommentsTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CommentsTableViewCell.h"
@interface CommentsTableViewCell(){
    
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
    UILabel * lab_comments;
    //评论图片
    WHC_StackView *stack_imageview;
    //展开按钮
    UIButton *btn_open;
    //分享按钮 删除按钮
    UIButton *btn_share;
    UIButton *btn_del;
    
    
    
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

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    
    lab_username = [UILabel new];
    [lab_username setTextColor:RGB(51, 51, 51)];
    [lab_username setFont:[UIFont systemFontOfSize:15]];
    [lab_username sizeToFit];
    
    lab_time  = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_star = [UILabel new];
    [lab_star setTextColor:RGB(51, 51, 51)];
    [lab_star setFont:[UIFont systemFontOfSize:11]];
    [lab_star setText:@"打分"];
    [lab_star sizeToFit];
    
//    for (int i=0; i<5; i++) {
//        
//        image_star = [UIImageView new];
//        image_star.image = [UIImage imageNamed:@"dafenDefault"];
//        image_star.tag = 100+i;
//        [self.contentView addSubview:image_star];
//        
//        image_star.whc_Size(11,11).whc_CenterYToView(0,lab_star).whc_LeftSpaceToView(5+(i*14),lab_star);
//        
//    }
    
    lab_productname = [UILabel new];
    [lab_productname setTextColor:RGB(51, 51, 51)];
    [lab_productname setFont:[UIFont systemFontOfSize:17]];
    [lab_productname sizeToFit];
    
    lab_comments = [UILabel new];
    [lab_comments sizeToFit];
    
    btn_open = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_open setTitle:@"展开" forState:UIControlStateNormal];
    [btn_open setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_open.titleLabel.font = [UIFont systemFontOfSize:14];
    
    stack_imageview = [WHC_StackView new];
    stack_imageview.whc_Column = 3;               // 最大3列
    stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    stack_imageview.whc_HSpace = 4;                // 图片之间的空隙为4
    stack_imageview.whc_VSpace = 4;
    stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
    stack_imageview.whc_Orientation = All;        // 横竖混合布局
    
    btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_share setTitle:@"分享" forState:UIControlStateNormal];
    [btn_share addTarget:self action:@selector(btn_share_click) forControlEvents:UIControlEventTouchUpInside];
    btn_share.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_share setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_share.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_share.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_share setTitleEdgeInsets:UIEdgeInsetsMake(0,7,0,0)];
    [btn_share setImage:[UIImage imageNamed:@"iconShareSm"] forState:UIControlStateNormal];
    
    [btn_del setTitle:@"删除" forState:UIControlStateNormal];
    [btn_del addTarget:self action:@selector(btn_del_click) forControlEvents:UIControlEventTouchUpInside];
    btn_del.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_del setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_del.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_del.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_del setTitleEdgeInsets:UIEdgeInsetsMake(0,7,0,0)];
    [btn_del setImage:[UIImage imageNamed:@"iconShareSm"] forState:UIControlStateNormal];
    
    self.whc_CellBottomView = btn_share;
    self.whc_CellBottomOffset = 15;
    
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
    
    for (int i=0; i<5; i++) {
        
        image_star = [UIImageView new];
        image_star.image = [UIImage imageNamed:@"dafenDefault"];
        image_star.tag = 100+i;
        [self.contentView addSubview:image_star];
        
        image_star.whc_Size(11,11).whc_CenterYToView(0,lab_star).whc_LeftSpaceToView(5+(i*14),lab_star);
        
    }
    
    image_head.whc_Size(40,40).whc_LeftSpace(15).whc_TopSpace(15);
    
    lab_username.whc_LeftSpaceToView(10,image_head).whc_TopSpace(20);
    
    lab_time.whc_RightSpace(15).whc_TopSpace(21);
    
    lab_star.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(6,lab_username);
    
    lab_productname.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(15,lab_star).whc_RightSpace(15);
    
    lab_comments.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(15,lab_productname).whc_RightSpace(15);
    
    btn_open.whc_Size(35,15).whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(10,lab_comments);
    
    stack_imageview.whc_LeftSpaceEqualView(lab_username).whc_RightSpace(15).whc_TopSpaceToView(15,btn_open).whc_HeightAuto();
    
//    btn_del.whc_RightSpace(15).whc_TopSpaceToView(15,stack_imageview).whc_Size(60,14);
    
//    btn_share.whc_RightSpaceToView(40,btn_share).whc_TopSpaceEqualView(btn_del).whc_SizeEqualView(btn_del);
    
}

-(void)SetModel:(commentsresults *)resmodel{

    if (resmodel) {
        
        [image_head sd_setImageWithURL:[NSURL URLWithString:resmodel.from_member.avatar] placeholderImage:[UIImage imageNamed:@"head"]];
        [lab_username setText:resmodel.from_member_name];
        [lab_time setText:[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)resmodel.created] withtype:@"MM-dd"]];
        [self DealStar:resmodel.total_score];
        [lab_productname setText:[NSString stringWithFormat:@"产品: %@",resmodel.product_name]];
        [self DealComment:resmodel];
        
        
    }
}

//处理打分
-(void)DealStar:(NSInteger )star{

    for (int i =0; i<star; i++) {
        UIImageView *starview = [self viewWithTag:100+i];
        starview.image = [UIImage imageNamed:@"dafenActive"];
    }
}
//处理评论以及图片
-(void)DealComment:(commentsresults *)resmodel{

//    lab_comments.attributedText = [BWCommon textWithStatus:resmodel.content Atarr:resmodel.ats font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:RGB(51, 51, 51) screenPadding:ScreenWidth-80];
    NSDictionary *dic = [BWCommon textWithStatusRowHeight:resmodel.content Atarr:resmodel.ats font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:RGB(51, 51, 51) screenPadding:ScreenWidth-80];
    lab_comments.attributedText = dic[@"text"];
    
    MYLOG(@"%@",dic[@"height"])
    
    
}

-(void)btn_share_click{

    MYLOG(@"分享")
}
-(void)btn_del_click{

    MYLOG(@"删除")
}
@end
