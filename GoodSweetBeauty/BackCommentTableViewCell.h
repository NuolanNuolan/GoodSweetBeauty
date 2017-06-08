//
//  BackCommentTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_username;
@property (weak, nonatomic) IBOutlet UILabel *lab_comment;


-(void)setPostsModel:(Posts *)model;

@end
