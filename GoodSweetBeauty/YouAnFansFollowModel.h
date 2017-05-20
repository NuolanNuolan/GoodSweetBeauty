//
//  YouAnFansFollowModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/20.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouAnFansFollowModel : NSObject


@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * my_message_count;
@property (nonatomic , assign) BOOL                    New_follow;
@property (nonatomic , copy) NSString              * reply_me_count;
@property (nonatomic , copy) NSString              * coins;
@property (nonatomic , assign) BOOL                  New_reply;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * my_fans_count;
@property (nonatomic , assign) BOOL                  if_vip;
@property (nonatomic , copy) NSString              * at_me_count;
@property (nonatomic , assign) BOOL                  if_each_fan;
@property (nonatomic , copy) NSString              * posts_collect_count;
@property (nonatomic , copy) NSString              * username;
//自定义一个字段来判断自己的关注
@property (nonatomic , assign) BOOL                  isfocus;

@end
