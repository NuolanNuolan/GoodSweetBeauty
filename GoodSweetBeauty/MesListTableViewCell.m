//
//  MesListTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MesListTableViewCell.h"
@interface MesListTableViewCell(){

    UIImageView *image_head;
    UILabel *lab_username;
    UILabel *lab_time;
    UILabel *lab_lastmes;
    UILabel *lab_mes_count;
    UIImageView * image_auth;
    UIImageView * image_level;
}

@end
@implementation MesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self InitFrame];
        
    }
    return self;
}
-(void)InitFrame{

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    
    lab_username = [UILabel new];
    [lab_username setTextColor:GETFONTCOLOR];
    [lab_username setFont:[UIFont systemFontOfSize:15]];
    [lab_username sizeToFit];
    lab_username.numberOfLines = 1;
    
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    [lab_time setTextAlignment:NSTextAlignmentRight];
    lab_time.numberOfLines = 1;
    
    lab_lastmes = [UILabel new];
    [lab_lastmes setTextColor:RGB(153, 153, 153)];
    [lab_lastmes setFont:[UIFont systemFontOfSize:11]];
    [lab_lastmes sizeToFit];
    lab_lastmes.numberOfLines = 1;
    
    lab_mes_count = [UILabel new];
    [lab_mes_count setTextColor:[UIColor whiteColor]];
//    lab_mes_count.backgroundColor = [UIColor redColor];
    lab_mes_count.layer.masksToBounds =YES;
    lab_mes_count.layer.cornerRadius = 4;
//    [lab_mes_count sizeToFit];
//    [lab_mes_count setTextAlignment:NSTextAlignmentCenter];
//    [lab_mes_count setFont:[UIFont systemFontOfSize:10]];
    
    image_auth = [UIImageView new];
    
    image_level = [UIImageView new];
    
    
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:lab_lastmes];
    [self.contentView addSubview:lab_mes_count];
    [self.contentView addSubview:image_auth];
    [self.contentView addSubview:image_level];
    
    
    image_head.whc_Size(40,40).whc_LeftSpace(15).whc_TopSpace(10);
    lab_username.whc_LeftSpaceToView(10,image_head).whc_TopSpaceEqualView(image_head);
    lab_time.whc_RightSpace(15).whc_TopSpace(15);
    lab_lastmes.whc_LeftSpaceEqualView(lab_username).whc_TopSpaceToView(10,lab_username).whc_RightSpaceEqualView(lab_username);
    lab_mes_count.whc_BottomSpace(10).whc_RightSpaceEqualView(lab_time).whc_Size(8,8);
    image_auth.whc_Size(11,9).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
    image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(12,11).whc_CenterYToView(0,lab_username).whc_RightSpaceToView(10,lab_time);
    
    
    self.whc_CellBottomOffset = 10;
    self.whc_TableViewWidth = SCREEN_WIDTH;
    
}
-(void)cellformodel:(Results *)model{

    [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
    lab_username.text = model.from_member_name;
    lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm"];
    lab_lastmes.text = [model.content stringByReplacingEmojiCheatCodesToUnicode];
    
    if (model.new_mes) lab_mes_count.backgroundColor = [UIColor redColor];
    else lab_mes_count.backgroundColor = [UIColor whiteColor];
    
    if (model.from_member.vip ==0) {
        image_auth.whc_Size(0,0).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
        
    }else{
        image_auth.whc_Size(11,9).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
        //这里根据判断显示哪张图片
        image_auth.image = [UIImage imageNamed:@"iconVRed"];
        
    }
    if (model.from_member.level==0) {
        image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(0,0).whc_CenterYToView(0,lab_username).whc_RightSpaceToView(10,lab_time);
    }else{
    
        image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(12,11).whc_CenterYToView(0,lab_username).whc_RightSpaceToView(10,lab_time);
        image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.from_member.level]];
    }
    
    
}

@end
