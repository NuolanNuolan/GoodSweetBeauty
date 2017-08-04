//
//  MyCommentsHead.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyCommentsHead.h"
@interface MyCommentsHead(){

    UIImageView *image_head;
    //装name 和 图标的view
    UIView *view_All;
    //只装图标
    UIView *view_v_level;
    //评价label
    UILabel *lab_count;
    UILabel *lab_name;
    UIImageView *image_vip;
    UIImageView *image_level;
}
@end

@implementation MyCommentsHead
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetFrameForComments];
    }
    return self;
}
-(void)SetFrameForComments{

    self.contentView.backgroundColor = GETMAINCOLOR;
    
    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    
    view_All = [UIView new];
    view_All.backgroundColor = [UIColor clearColor];
    
    lab_name = [UILabel new];
    [lab_name setTextColor:[UIColor whiteColor]];
    [lab_name setFont:[UIFont boldSystemFontOfSize:16]];
    [lab_name sizeToFit];
    
    view_v_level =[UIView new];
    view_v_level.backgroundColor = RGB(247, 247, 247);
    view_v_level.layer.masksToBounds =YES;
    view_v_level.layer.cornerRadius =8;
    
    image_vip = [UIImageView new];
    
    image_level = [UIImageView new];
    
    lab_count = [UILabel new];
    [lab_count setTextColor:RGBA(255, 255, 255, 0.8)];
    [lab_count setFont:[UIFont systemFontOfSize:12]];
    [lab_count sizeToFit];
    
    UIView *view_bot = [UIView new];
    view_bot.backgroundColor = RGB(247, 247, 247);
    
    
    [self.contentView addSubview:image_head];
    [view_v_level addSubview:image_vip];
    [view_v_level addSubview:image_level];
    [view_All addSubview:lab_name];
    [view_All addSubview:view_v_level];
    [self.contentView addSubview:view_All];
    [self.contentView addSubview:lab_count];
    [self.contentView addSubview:view_bot];
    
    image_head.whc_Size(80,80).whc_TopSpace(6).whc_CenterX(0);
    
    lab_count.whc_TopSpaceToView(40,image_head).whc_CenterX(0);
    
    view_bot.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(23,lab_count).whc_Height(10);
    

    
}
-(void)SetModel:(YouAnMyCommentModel *)model{

    if (model) {
        
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,[model.results[0].from_member.avatar stringByReplacingOccurrencesOfString:@"small" withString:@"middle"]]] placeholderImage:[UIImage imageNamed:@"head"]];
        [lab_name setText:model.results[0].from_member_name];
        [lab_count setText:[NSString stringWithFormat:@"已贡献%ld条评价",(long)model.count]];
        
        view_All.whc_TopSpaceToView(15,image_head).whc_CenterXToView(0,image_head).whc_WidthAuto().whc_HeightAuto();
        
        lab_name.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpaceToView(5,view_v_level);
        
        NSInteger hiddenview = YES;
//        model.results[0].from_member.vip=1;
        if (model.results[0].from_member.vip==0) {
            
            image_vip.hidden =YES;
            
        }else{
            
            hiddenview = NO;
            image_vip.hidden = NO;
            image_vip.whc_Size(11,9).whc_LeftSpace(7).whc_CenterY(0).whc_RightSpaceToView(5,image_level);
            image_vip.image = [UIImage imageNamed:@"iconVRed"];
        }
        if (model.results[0].from_member.level==0) {
            
            image_level.hidden =YES;
            
        }else{
            
            hiddenview =NO;
            image_level.hidden =NO;
            image_level.whc_Size(12,11).whc_RightSpace(7.5).whc_CenterY(0).whc_LeftSpaceToView(5,image_vip);
            image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.results[0].from_member.level]];
        }
        if (hiddenview) {
            
            view_v_level.whc_Width(0).whc_RightSpace(0).whc_Height(0).whc_CenterYToView(0,lab_name);
            
        }else{
            
            
            view_v_level.whc_WidthAuto().whc_RightSpace(0).whc_Height(16).whc_CenterYToView(0,lab_name);
        }
        
    }
    
}
@end
