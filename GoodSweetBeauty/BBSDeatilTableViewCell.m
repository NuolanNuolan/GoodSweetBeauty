//
//  BBSDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSDeatilTableViewCell.h"
@interface BBSDeatilTableViewCell(){

    //头像
    UIImageView *image_head;
    //name
    UILabel *lab_username;
    //认证 等级 楼主
    UIImageView * image_auth;
    UIImageView * image_level;
    UIImageView * image_OriginalPoster;
    //时间
    UILabel *lab_time;
    //关注按钮
    UIButton *btn_Focus;
}
@end
@implementation BBSDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetFarme];
        
        
        
    }
    return self;


}
-(void)SetFarme{

    image_head = [UIImageView new];
    image_head.layer.masksToBounds = YES;
    image_head.layer.cornerRadius = 20.0f;
    
    lab_username = [UILabel new];
    [lab_username sizeToFit];
    lab_username.numberOfLines = 0;
    [lab_username setTextColor:RGB(51, 51, 51)];
    [lab_username setFont:[UIFont boldSystemFontOfSize:15]];
    
    image_auth = [UIImageView new];
    
    image_level = [UIImageView new];
    
    image_OriginalPoster = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"labelLouzhu"]];
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time sizeToFit];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    
    btn_Focus = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Focus.layer.masksToBounds = YES;
    btn_Focus.layer.cornerRadius = 14;
    btn_Focus.layer.borderWidth = 0.5f;
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:image_auth];
    [self.contentView addSubview:image_level];
    [self.contentView addSubview:image_OriginalPoster];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:btn_Focus];
    
    image_head.whc_LeftSpace(15).whc_TopSpace(15).whc_Size(40,40);
    lab_username.whc_TopSpace(20).whc_LeftSpaceToView(10,image_head);
    image_auth.whc_Size(11,9).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
    image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(12,11).whc_CenterYToView(0,lab_username);
    image_OriginalPoster.whc_LeftSpaceToView(5,image_level).whc_Size(24,14).whc_CenterYToView(0,lab_username);
    lab_time.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(6.5,lab_username);
    btn_Focus.whc_RightSpace(15).whc_Size(70,28).whc_TopSpaceEqualView(lab_username);
    self.whc_TableViewWidth = self.whc_sw;
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    if (model) {
        
        [image_head sd_setImageWithURL:[NSURL URLWithString:model.author_avatar] placeholderImage:[UIImage imageNamed:@"head"]];
        lab_username.text = [NSString stringWithFormat:@"%@",model.author];
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        
        
        
    }
}
@end
