//
//  PostingTitleTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "PostingTitleTableViewCell.h"

@implementation PostingTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_txt_title setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_title setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_txt_title setPlaceholder:@"讨论标题"];
    [_txt_title becomeFirstResponder];
    //监听
    [[self.txt_title rac_textSignal]subscribeNext:^(id x) {
       
        if (self.delegateSignal) [self.delegateSignal sendNext:x];
        
    }];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
