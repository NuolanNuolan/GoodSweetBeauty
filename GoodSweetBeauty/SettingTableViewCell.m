//
//  SettingTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)SetSection:(NSInteger )section{

    switch (section) {
        case 0:
            _lab_title.text = @"账号安全";
            break;
        case 1:
            _lab_title.text = @"关于有安";
            break;
        case 3:
            _lab_title.text = @"版本信息";
            break;
        case 4:
            _lab_title.text = @"意见反馈";
            break;
    }
}
@end
