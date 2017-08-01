//
//  YouAnBusinessCardModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/28.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusinessProfile :NSObject
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

@interface YouAnBusinessCardModel :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              member_id;
@property (nonatomic , strong) BusinessProfile              * profile;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * brief;
@property (nonatomic , copy) NSString              * if_follow;
@property (nonatomic , copy) NSString              * company;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , copy) NSString              * qq;
@property (nonatomic , copy) NSString              * website;
@property (nonatomic , copy) NSString              * video;

@end

