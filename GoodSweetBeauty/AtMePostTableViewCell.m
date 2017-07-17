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
    UILabel *lab_atme_content;
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

    image_head = [UIImageView new];
    image_head.userInteractionEnabled = YES;
    image_head.layer.masksToBounds =YES;
    image_head.layer.cornerRadius = 20.0f;
    
    lab_name = [UILabel new];
    [lab_name setTextColor:RGB(51, 51, 51)];
    [lab_name setFont:[UIFont systemFontOfSize:14]];
    lab_name.numberOfLines = 1;
    [lab_name sizeToFit];
    
    image_isvip = [UIImageView new];
    
    image_level = [UIImageView new];
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_atme_content = [UILabel new];
    [lab_atme_content setTextColor:RGB(51, 51, 51)];
    [lab_atme_content setFont:[UIFont systemFontOfSize:17]];
    lab_atme_content.numberOfLines = 2;
    [lab_atme_content sizeToFit];
    
    image_post = [UIImageView new];
    image_post.backgroundColor = RGB(233, 233, 233);
    
    lab_post_title = [UILabel new];
    [lab_post_title setTextColor:RGB(51, 51, 51)];
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
    lab_post_title.whc_LeftSpaceToView(10,image_post).whc_RightSpace(15).whc_TopSpace(10).whc_Height(14);
    lab_post_deatil.whc_LeftSpaceEqualView(lab_post_title).whc_RightSpaceEqualView(lab_post_title).whc_TopSpaceToView(6.5,lab_post_title).whc_BottomSpace(0);
    
    
    self.whc_CellBottomOffset = 15;
    self.whc_TableViewWidth = self.whc_sw;
    
    
    
}
-(void)SetModel:(YouAnAtMeModel *)model{

    if (model) {
     
        [image_head sd_setImageWithURL:[NSURL URLWithString:model.author_avatar] placeholderImage:[UIImage imageNamed:@"head"]];
        lab_name.text = model.author;
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        lab_atme_content.text = [model.stripd_content stringByReplacingEmojiCheatCodesToUnicode];
        if (![model.image isEqualToString:@""]||!model.image) {
            
            image_post.whc_LeftSpace(0).whc_TopSpace(0).whc_Size(70,70);
            [image_post sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            
        }else{
            
            image_post.whc_LeftSpace(0).whc_TopSpace(0).whc_Size(0,0);
            
            
        }
        lab_post_title.text = [model.subject stringByReplacingEmojiCheatCodesToUnicode];
        lab_post_deatil.text = [model.stripd_content stringByReplacingEmojiCheatCodesToUnicode];
        
//        CGSize size_content = [BWCommon sizeWithString:lab_atme_content.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(ScreenWidth-30, MAXFLOAT)];
        
        CGSize size_deatil = [BWCommon sizeWithString:lab_post_deatil.text font:[UIFont systemFontOfSize:17] maxSize:[model.image isEqualToString:@""]? CGSizeMake(ScreenWidth-30, 100):CGSizeMake(ScreenWidth-110, MAXFLOAT)];
//        if (size_content.height>25) {
//            
//            [UILabel changeLineSpaceForLabel:lab_atme_content WithSpace:7];
//        }
        if (size_deatil.height>22) {
            
//            [UILabel changeLineSpaceForLabel:lab_post_deatil WithSpace:6];
        }
    }
    
}
@end
