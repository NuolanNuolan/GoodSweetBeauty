//
//  YouAnSearchMemberModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MemberResults :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              my_message_count;
@property (nonatomic , assign) BOOL              new_follow;
@property (nonatomic , assign) NSInteger              reply_me_count;
@property (nonatomic , assign) BOOL              new_letter;
@property (nonatomic , assign) BOOL              new_favor_reply;
@property (nonatomic , assign) NSInteger              my_follower_count;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              my_posts_count;
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) BOOL              new_reply;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , assign) NSInteger              my_fans_count;
@property (nonatomic , assign) NSInteger              at_me_count;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , assign) NSInteger              posts_collect_count;
@property (nonatomic , assign) BOOL              new_message;

@end

@interface Members :NSObject
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray<MemberResults *>              * results;

@end

@interface YouAnSearchMemberModel :NSObject
@property (nonatomic , strong) Members              * members;

@end

