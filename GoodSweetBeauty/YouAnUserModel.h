//
//  YouAnUserModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/20.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouAnUserModel : NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              my_message_count;
@property (nonatomic , assign) BOOL              new_follow;
@property (nonatomic , assign) NSInteger              reply_me_count;
@property (nonatomic , assign) BOOL              new_letter;
@property (nonatomic , assign) BOOL              new_favor_reply;
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) BOOL              new_reply;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , assign) NSInteger              my_fans_count;
@property (nonatomic , assign) NSInteger              at_me_count;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , assign) NSInteger              posts_collect_count;
@property (nonatomic , assign) BOOL              new_message;
@end
