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
    _image_head.layer.masksToBounds = YES;
    _image_head.layer.cornerRadius = 30.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)BtnFocus:(UIButton *)sender {
}
@end
