//
//  ConisTwoTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ConisTwoTableViewCell.h"

@implementation ConisTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn_buy.layer.masksToBounds =YES;
    self.btn_buy.layer.cornerRadius = 20.0f;
    self.btn_buy.layer.borderWidth = 0.5f;
    self.btn_buy.layer.borderColor = RGB(250, 111, 42).CGColor;
    self.btn_buy.adjustsImageWhenHighlighted = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btn_buy_click:(UIButton *)sender {
    
    if (self.delegateSignal) [self.delegateSignal sendNext:nil];
}
@end
