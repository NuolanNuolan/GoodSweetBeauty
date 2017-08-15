//
//  AtMePostTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AtMePostTableViewCell.h"
@interface AtMePostTableViewCell(){

    //头像
    UIImageView *image_head;
    //name
    UILabel *lab_name;
    //vip level
    UIImageView *image_isvip;
    UIImageView *image_level;
    //time
    UILabel *lab_time;
    //@内容
    XXLinkLabel *lab_atme_content;
    //帖子图片
    UIImageView *image_post;
    //帖子标题
    UILabel *lab_post_title;
    //主题内容
    UILabel *lab_post_deatil;
    //view
    UIView *view_back;
}

@end


@implementation AtMePostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self SetFrameCell];
    }
    return self;
}
-(void)SetFrameCell{

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];;
    image_head.userInteractionEnabled = YES;
    
    lab_name = [UILabel new];
    [lab_name setTextColor:GETFONTCOLOR];
    [lab_name setFont:[UIFont systemFontOfSize:14]];
    lab_name.numberOfLines = 1;
    [lab_name sizeToFit];
    
    image_isvip = [UIImageView new];
    
    image_level = [UIImageView new];
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_atme_content = [XXLinkLabel new];
    
//    [lab_atme_content setTextColor:GETFONTCOLOR];
//    [lab_atme_content setFont:[UIFont systemFontOfSize:17]];
    lab_atme_content.numberOfLines = 0;
//    [lab_atme_content sizeToFit];
    lab_atme_content.linkTextColor = GETMAINCOLOR;
    lab_atme_content.regularType = XXLinkLabelRegularTypeAboat;
    lab_atme_content.selectedBackgroudColor = [UIColor whiteColor];
    
    image_post = [UIImageView new];
    image_post.backgroundColor = RGB(233, 233, 233);
    
    lab_post_title = [UILabel new];
    [lab_post_title setTextColor:GETFONTCOLOR];
    lab_post_title.numberOfLines = 1;
    [lab_post_title sizeToFit];
    [lab_post_title setFont:[UIFont systemFontOfSize:15]];
    
    lab_post_deatil = [UILabel new];
    [lab_post_deatil setTextColor:RGB(136, 136, 136)];
    lab_post_deatil.numberOfLines = 2;
    [lab_post_deatil sizeToFit];
    [lab_post_deatil setFont:[UIFont systemFontOfSize:12]];
    
    view_back = [UIView new];
    view_back.backgroundColor = RGB(247, 247, 247);
    
    [view_back addSubview:image_post];
    [view_back addSubview:lab_post_deatil];
    [view_back addSubview:lab_post_title];
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:image_isvip];
    [self.contentView addSubview:image_level];
    [self.contentView addSubview:lab_name];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:lab_atme_content];
    [self.contentView addSubview:view_back];
    
    image_head.whc_LeftSpace(15).whc_TopSpace(14).whc_Size(40,40);
    lab_name.whc_LeftSpaceToView(10,image_head).whc_TopSpace(20).whc_Height(14);
    image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(11,9).whc_CenterYToView(0,lab_name);
    image_level.whc_Size(12,11).whc_CenterYToView(0,lab_name).whc_LeftSpaceToView(5,image_isvip);
    lab_time.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(7,lab_name).whc_Height(8.5);
    
    lab_atme_content.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,image_head).whc_RightSpace(15);
    
    view_back.whc_LeftSpaceEqualView(image_head).whc_RightSpace(15).whc_Height(70).whc_TopSpaceToView(15,lab_atme_content);
    
    image_post.whc_LeftSpace(0).whc_TopSpace(0).whc_Size(70,70);
    
    lab_post_title.whc_LeftSpaceToView(10,image_post).whc_RightSpace(15).whc_TopSpace(0).whc_Height(30.5);
    
    lab_post_deatil.whc_LeftSpaceEqualView(lab_post_title).whc_RightSpaceEqualView(lab_post_title).whc_TopSpace(30.5).whc_Height(39.5);
    
    self.whc_CellBottomOffset = 15;
    self.whc_TableViewWidth = self.whc_sw;
    
    
    
}
-(void)SetModel:(YouAnAtMeModel *)model withrow:(NSInteger )row{

    if (model) {
     
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.author_profile.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        lab_name.text = model.author;
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        if (model.author_profile.vip==0) {
            
            image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(0,0).whc_CenterYToView(0,lab_name);
            
            
        }else{
            image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(11,9).whc_CenterYToView(0,lab_name);
            //这里根据判断显示哪张图片
            image_isvip.image = [UIImage imageNamed:@"iconVRed"];
            
        }
        if (model.author_profile.level==0) {
            
            image_level.whc_Size(0,0).whc_CenterYToView(0,lab_name).whc_LeftSpaceToView(5,image_isvip);
        }else{
        
            image_level.whc_Size(12,11).whc_CenterYToView(0,lab_name).whc_LeftSpaceToView(5,image_isvip);
            image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.author_profile.level]];
        }
        
        lab_atme_content.attributedText = [BWCommon textWithStatus:model.stripd_content Atarr:model.ats font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:GETFONTCOLOR screenPadding:ScreenWidth-30];
        @weakify(self);
        lab_atme_content.regularLinkClickBlock = ^(NSString *clickedString) {
            @strongify(self);
            //正则提取出来的内容 包含@和空格
            NSString *str_result =  [clickedString substringFromIndex:1];
            
            str_result = [str_result substringToIndex:str_result.length-1];
            
            
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"name": str_result,
                                                                     @"row":[NSString stringWithFormat:@"%ld",(long)row],
                                                                     @"type":@"AT"}];
            
        };
        lab_atme_content.labelClickedBlock = ^(id extend){
            @strongify(self);
            //如果没有数据的话 要通知到view  跳转到下个页面
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"PUSH",@"row":[NSString stringWithFormat:@"%ld",(long)row]}];
            
        };
        if (![model.image isEqualToString:@""]||!model.image) {
            
            image_post.whc_LeftSpace(0).whc_TopSpace(0).whc_Size(70,70);
            [image_post sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.image]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            
        }else{
            
            image_post.whc_LeftSpace(0).whc_TopSpace(0).whc_Size(0,0);
            
            
        }
        lab_post_title.text = [model.father.subject stringByReplacingEmojiCheatCodesToUnicode];
        lab_post_deatil.attributedText = [BWCommon textWithStatus:model.father.content Atarr:nil font:[UIFont systemFontOfSize:12] LineSpacing:3 textColor:RGB(132, 132, 132) screenPadding:ScreenWidth-110];

    }
    
}
@end
