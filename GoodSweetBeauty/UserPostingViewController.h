//
//  UserPostingViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
typedef NS_ENUM(NSUInteger, YouAnStatusComposeViewType) {
    
    YouAnStatusComposeViewTypeStatus,  ///< 回复楼主
    YouAnStatusComposeViewTypeComment, ///< 回复评论
    YouAnStatusComposeViewTypePostTing, ///< 发帖
    YouAnStatusComposeViewTypePostKouBei, ///< 发口碑
};
@interface UserPostingViewController : HJViewController

@property (nonatomic, assign) YouAnStatusComposeViewType type;
//需要传入帖子ID 或者回复的楼层ID
@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, assign) NSInteger father_id;

@end
