//
//  YouAnPointMessageModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/28.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface To_member :NSObject
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatar;

@end
@interface YouAnPointMessageModel : NSObject
@property (nonatomic , assign) NSInteger              to_member_id;
@property (nonatomic , copy) NSString              * to_member_name;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * from_member_name;
@property (nonatomic , assign) NSInteger              read_time;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) NSInteger              from_member_id;
@property (nonatomic , strong) From_member              * from_member;
@property (nonatomic , strong) To_member              * to_member;
@property (nonatomic , assign) BOOL              if_read;
@end
