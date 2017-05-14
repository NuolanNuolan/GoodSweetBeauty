//
//  MyFansTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFansTableViewCell : UITableViewCell
//头像
@property (weak, nonatomic) IBOutlet UIImageView *image_head;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *lab_username;

//加v
@property (weak, nonatomic) IBOutlet UIImageView *image_v;

//等级
@property (weak, nonatomic) IBOutlet UIImageView *image_level;

//用户简介
@property (weak, nonatomic) IBOutlet UILabel *lab_user_Introduction;

//粉丝数
@property (weak, nonatomic) IBOutlet UILabel *lab_count;

//本人是否关注按钮
@property (weak, nonatomic) IBOutlet UIButton *btn_Focus;

//按钮点击事件
- (IBAction)BtnFocus:(UIButton *)sender;


@end
