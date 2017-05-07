//
//  SettingSwitchTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SettingSwitchTableViewCell.h"

@implementation SettingSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switch_change:(UISwitch *)sender {
    
    
    if (sender.on) {
        MYLOG(@"开启");
        return;
    }
    MYLOG(@"关闭");
    
    
}
@end
