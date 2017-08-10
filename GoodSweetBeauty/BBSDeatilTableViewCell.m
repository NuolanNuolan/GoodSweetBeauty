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
    
    //model
    YouAnBBSDeatilModel * model_cell;
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

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];;
    image_head.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(head_click:)];
    [image_head addGestureRecognizer:tap];
    
    lab_username = [UILabel new];
    [lab_username sizeToFit];
    lab_username.numberOfLines = 0;
    [lab_username setTextColor:RGB(51, 51, 51)];
    [lab_username setFont:[UIFont boldSystemFontOfSize:15]];
    lab_username.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap_name = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(head_click:)];
    [lab_username addGestureRecognizer:tap_name];
    
    
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
    btn_Focus.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_Focus addTarget:self action:@selector(focus_click:) forControlEvents:UIControlEventTouchUpInside];
    
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
        model_cell = model;
        image_head.tag = model.author_id;
        lab_username.tag = model.author_id;
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.author_profile.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        lab_username.text = [NSString stringWithFormat:@"%@",model.author];
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        
        //判断等级以及是否关注等
        if (model.author_profile.vip == 0) {
            image_auth.whc_Size(0,0).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
        }else{
            
            image_auth.whc_Size(11,9).whc_LeftSpaceToView(5,lab_username).whc_CenterYToView(0,lab_username);
            //这里根据判断显示哪张图片
            image_auth.image = [UIImage imageNamed:@"iconVRed"];
            
        }
        if (model.author_profile.level == 0) {
            image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(0,0).whc_CenterYToView(0,lab_username);
        }else{
            
            image_level.whc_LeftSpaceToView(5,image_auth).whc_Size(12,11).whc_CenterYToView(0,lab_username);
            image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.author_profile.level]];
        }
        if ([model.if_follow isEqualToString:@"nofollow"]||[model.if_follow isEqualToString:@"fan"]) {
            
            btn_Focus.layer.borderColor = GETMAINCOLOR.CGColor;
            [btn_Focus setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
            [btn_Focus setTitle:@"关注" forState:UIControlStateNormal];
        }else{
        
            btn_Focus.layer.borderColor = RGB(136, 136, 136).CGColor;
            [btn_Focus setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
            [btn_Focus setTitle:@"已关注" forState:UIControlStateNormal];
        }
        
    }
}

//关注非关注点击
-(void)focus_click:(UIButton *)btn{

    
    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:[BWCommon Superview:btn]];
        return;
    }
    MYLOG(@"%@",btn.titleLabel.text)
    
    if ([btn.titleLabel.text isEqualToString:@"关注"]) {
        //关注
        [HttpEngine UserFocususerid:model_cell.author_id complete:^(BOOL success, id responseObject) {

            if (success) {
                btn.layer.borderColor = RGB(136, 136, 136).CGColor;
                [btn setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
                [btn setTitle:@"已关注" forState:UIControlStateNormal];
            }else{
            
                if (responseObject[@"msg"]) {
                    
                    [MBProgressHUD showError:responseObject[@"msg"]];
                }
            }
        }];
    }else{
    
        [HttpEngine UserCancelFocususerid:model_cell.author_id complete:^(BOOL success, id responseObject) {
            
            if (success) {
                
                btn.layer.borderColor = GETMAINCOLOR.CGColor;
                [btn setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
                [btn setTitle:@"关注" forState:UIControlStateNormal];
            }
        }];
    }
}
/**
 头像点击
 */
-(void)head_click:(UITapGestureRecognizer *)tap{
    
    NSDictionary *dic = @{@"authid":[NSString stringWithFormat:@"%ld",tap.view.tag],
                          @"type":@"头像点击"};
    if (self.delegateSignal) [self.delegateSignal sendNext:dic];
}
@end
