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
        
        _image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.level]];
        _image_v.image = model.vip ? [UIImage imageNamed:@"iconVRed"] : nil;
        
        
        
        
        
        
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
@end
