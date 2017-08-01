//
//  ChooseProductTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/30.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ChooseProductTableViewCell.h"

@implementation ChooseProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_text_product_name becomeFirstResponder];
    //监听
    @weakify(self);
    [[self.text_product_name rac_textSignal]subscribeNext:^(id x) {
        @strongify(self);
        if (self.delegateSignal) [self.delegateSignal sendNext:@{@"productname":x,
                                                                 @"type":@"productname"}];
    }];
     
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
