//
//  BackCommentTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BackCommentTableViewCell.h"

@implementation BackCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPostsModel:(Posts *)model{

    _lab_username.text = model.author;
    _lab_comment.text = model.content;
}
@end
