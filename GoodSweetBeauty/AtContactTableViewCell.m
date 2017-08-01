//
//  AtContactTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AtContactTableViewCell.h"
@interface AtContactTableViewCell(){

    //头像
    UIImageView *image_head;
    //name
    UILabel *lab_name;
    //两个图标
    UIImageView *image_isvip;
    UIImageView *image_level;
    
}
@end

@implementation AtContactTableViewCell

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
        
        [self SetFarme];
        
        
        
    }
    return self;
    
    
}
-(void)SetFarme{

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    image_head.userInteractionEnabled =YES;
//    image_head.layer.masksToBounds = YES;
//    image_head.layer.cornerRadius = 20.0f;
    
    lab_name = [UILabel new];
    [lab_name setTextColor:RGB(51, 51, 51)];
    [lab_name setFont:[UIFont systemFontOfSize:15]];
    [lab_name sizeToFit];
    
    image_isvip = [UIImageView new];
    
    image_level = [UIImageView new];
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:image_isvip];
    [self.contentView addSubview:image_level];
    [self.contentView addSubview:lab_name];
    
    image_head.whc_LeftSpace(15).whc_CenterY(0).whc_Size(40,40);
    lab_name.whc_LeftSpaceToView(10,image_head).whc_CenterYToView(0,image_head);
    image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(11,9).whc_CenterYToView(0,lab_name);
    image_level.whc_LeftSpaceToView(5,image_isvip).whc_Size(12,11).whc_CenterYToView(0,lab_name);
    
}
-(void)SetModel:(YouAnFansFollowModel *)model{

    [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
    [lab_name setText:model.username];
    if (model.vip==0) {
        image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(0,0).whc_CenterYToView(0,lab_name);
    }else{
    
        image_isvip.whc_LeftSpaceToView(5,lab_name).whc_Size(11,9).whc_CenterYToView(0,lab_name);
        //这里根据判断显示哪张图片
        image_isvip.image = [UIImage imageNamed:@"iconVRed"];
    }
    if (model.level==0) {
        image_level.whc_LeftSpaceToView(5,image_isvip).whc_Size(0,0).whc_CenterYToView(0,lab_name);
    }else{
    
        image_level.whc_LeftSpaceToView(5,image_isvip).whc_Size(12,11).whc_CenterYToView(0,lab_name);
        image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.level]];
    }
    
    
    
    
    
}

@end
