//
//  RevertMyTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "RevertMyTableViewCell.h"
@interface RevertMyTableViewCell(){

    UIImageView *image_head;
    UILabel *lab_username;
    XXLinkLabel *lab_deatil;
    UILabel *lab_time;
    //原贴view
    UIView *view_originally;
    
    UILabel *lab_title;
    //回复
    UIButton *btn_report;
}
@end

@implementation RevertMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self InitFarme];
        [self Layout];
        [self asdsadsa];
    }
    return self;
}
-(void)InitFarme{

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    image_head.userInteractionEnabled =YES;
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(click_head:)];
    [image_head addGestureRecognizer:tap];
    
    lab_username = [UILabel new];
    [lab_username setFont:[UIFont systemFontOfSize:15]];
    [lab_username setTextColor:RGB(51, 51, 51)];
    [lab_username sizeToFit];
    
    lab_deatil = [XXLinkLabel new];
    //    [lab_atme_content setTextColor:RGB(51, 51, 51)];
    //    [lab_atme_content setFont:[UIFont systemFontOfSize:17]];
    lab_deatil.numberOfLines = 0;
    //    [lab_atme_content sizeToFit];
    lab_deatil.linkTextColor = GETMAINCOLOR;
    lab_deatil.regularType = XXLinkLabelRegularTypeAboat;
    lab_deatil.selectedBackgroudColor = [UIColor whiteColor];
    
    lab_time = [UILabel new];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time sizeToFit];
    
    view_originally = [UIView new];
    view_originally.backgroundColor = RGB(247, 247, 247);
    
    lab_title = [UILabel new];
    [lab_title setTextColor:GETMAINCOLOR];
    [lab_title setFont:[UIFont systemFontOfSize:15]];
    lab_title.numberOfLines = 0;
    [lab_title sizeToFit];
    
    btn_report = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_report setTitle:@"回复" forState:UIControlStateNormal];
    [btn_report addTarget:self action:@selector(report_click:) forControlEvents:UIControlEventTouchUpInside];
    btn_report.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_report setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_report.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn_report.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn_report setTitleEdgeInsets:UIEdgeInsetsMake(0,10,2,0)];
    [btn_report setImage:[UIImage imageNamed:@"iconHuifuBlue"] forState:UIControlStateNormal];
    
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:lab_deatil];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:view_originally];
    [self.contentView addSubview:btn_report];
    [view_originally addSubview:lab_title];
    
}
-(void)Layout{

    image_head.whc_LeftSpace(15).whc_TopSpace(10).whc_Size(28,28);
    lab_username.whc_LeftSpaceToView(7,image_head).whc_CenterYToView(0,image_head);
    lab_deatil.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,image_head).whc_RightSpace(15);
    lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(10,lab_deatil);
    view_originally.whc_LeftSpaceEqualView(image_head).whc_RightSpace(15).whc_HeightAuto().whc_TopSpaceToView(10,lab_deatil);
    lab_title.whc_LeftSpace(10).whc_TopSpace(10).whc_RightSpace(10).whc_BottomSpace(10);
    btn_report.whc_RightSpace(15).whc_HeightAuto().whc_Width(65).whc_TopSpaceToView(15,view_originally);
    
    self.whc_CellBottomOffset = 15;
    self.whc_TableViewWidth = SCREEN_WIDTH;
    
}


-(void)asdsadsa{

    [image_head sd_setImageWithURL:[NSURL URLWithString:@"http://121.40.52.49/media/avatar/2/2/170728-rogsf_middle.jpg"]];
    lab_username.text = @"13618280790";
    lab_deatil.attributedText = [BWCommon textWithStatus:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈 @sadsadas " Atarr:nil font:[UIFont systemFontOfSize:16] LineSpacing:6 textColor:RGB(51,51,51) screenPadding:SCREEN_WIDTH-30];
    lab_time.text = @"1212-21 12:21:231";
    lab_title.attributedText = [BWCommon textWithStatus:@"原帖：领英中国推出新应用“赤兔”,它挺像一个职场版的微信" Atarr:nil font:[UIFont systemFontOfSize:15] LineSpacing:5 textColor:GETMAINCOLOR screenPadding:SCREEN_WIDTH-50];
}

/**
 
 点击头像
 */
-(void)click_head:(UIGestureRecognizer *)tap{

    
}
/**
 
 回复
 */
-(void)report_click:(UIButton *)sender{

    
}
@end
