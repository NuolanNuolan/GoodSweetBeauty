//
//  MyFansTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyFansTableViewCell.h"

@implementation MyFansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btn_Focus.layer.masksToBounds = YES;
    _btn_Focus.layer.cornerRadius = 14.0f;
    _btn_Focus.layer.borderWidth = 0.5f;
//    _image_head.layer.masksToBounds = YES;
//    _image_head.layer.cornerRadius = 30.0f;
    [_image_head zy_cornerRadiusAdvance:30.0f rectCornerType:UIRectCornerAllCorners];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)BtnFocus:(UIButton *)sender {
    
    
    if (self.delegateSignal) [self.delegateSignal sendNext:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}

-(void)SetModel:(YouAnFansFollowModel *)model withtype:(NSString *)type withrow:(NSInteger) row{

    if (model) {
        
        _btn_Focus.tag = row;
        _lab_username.text = model.username;
        _lab_count.text = [NSString stringWithFormat:@"粉丝 %ld",(long)model.my_fans_count];
        [_image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];

        //判断等级
        if (model.vip == 0) {
            
            _image_v.whc_LeftSpaceToView(5,_lab_username).whc_Size(0,0).whc_CenterYToView(0,_lab_username);
            
        }else{
            
            _image_v.whc_LeftSpaceToView(5,_lab_username).whc_Size(11,9).whc_CenterYToView(0,_lab_username);
            //这里根据判断显示哪张图片
            _image_v.image = [UIImage imageNamed:@"iconVRed"];
            
        }
        if (model.level == 0) {
            
            _image_level.whc_Size(0,0).whc_CenterYToView(0,_lab_username).whc_LeftSpaceToView(5,_image_v);
            
        }else{
            
            _image_level.whc_Size(12,11).whc_CenterYToView(0,_lab_username).whc_LeftSpaceToView(5,_image_v);
            _image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.level]];
        }
        
        BOOL isFocus = [type isEqualToString:@"粉丝"]? model.if_each_fan :model.isfocus;
            if (isFocus) {
                
                _btn_Focus.layer.borderColor = RGB(136, 136, 136).CGColor;
                [_btn_Focus setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
                [_btn_Focus setTitle:@"已关注" forState:UIControlStateNormal];
            }else{
            
                _btn_Focus.layer.borderColor = GETMAINCOLOR.CGColor;
                [_btn_Focus setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
                [_btn_Focus setTitle:@"关注" forState:UIControlStateNormal];
            }
    }
}
//搜索出来的用户
-(void)SetMemberResults:(MemberResults *)model withrow:(NSInteger) row withkeyword:(NSString *)keyword{

    if (model) {
     
        _btn_Focus.tag = row;
//        _lab_username.text = model.username;
        _lab_username.attributedText = [BWCommon textColorWithString:model.username Atarr:nil font:[UIFont systemFontOfSize:17] LineSpacing:0 textColor:GETFONTCOLOR screenPadding:SCREEN_WIDTH ChangeColorStr:keyword Color:RGB(237, 67, 67)];
        _lab_count.text = [NSString stringWithFormat:@"粉丝 %ld",(long)model.my_fans_count];
        [_image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        
        //判断等级
        if (model.vip == 0) {
            
            _image_v.whc_LeftSpaceToView(5,_lab_username).whc_Size(0,0).whc_CenterYToView(0,_lab_username);
            
        }else{
            
            _image_v.whc_LeftSpaceToView(5,_lab_username).whc_Size(11,9).whc_CenterYToView(0,_lab_username);
            //这里根据判断显示哪张图片
            _image_v.image = [UIImage imageNamed:@"iconVRed"];
            
        }
        if (model.level == 0) {
            
            _image_level.whc_Size(0,0).whc_CenterYToView(0,_lab_username).whc_LeftSpaceToView(5,_image_v);
            
        }else{
            
            _image_level.whc_Size(12,11).whc_CenterYToView(0,_lab_username).whc_LeftSpaceToView(5,_image_v);
            _image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.level]];
        }
        
        _btn_Focus.layer.borderColor = GETMAINCOLOR.CGColor;
        [_btn_Focus setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
        [_btn_Focus setTitle:@"关注" forState:UIControlStateNormal];
        
    }
}
@end
