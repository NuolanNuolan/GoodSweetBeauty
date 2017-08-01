//
//  YouAnUserPosttingModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/8.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>
//@interface Author_profile :NSObject
//@property (nonatomic , assign) NSInteger              vip;
//@property (nonatomic , assign) NSInteger              coins;
//@property (nonatomic , assign) NSInteger              level;
//@property (nonatomic , copy) NSString              * avatar;
//
//@end
@interface YouAnUserPosttingModel :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , assign) NSInteger              father_id;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , assign) NSInteger              favors;
@property (nonatomic , copy) NSString              * stripd_content;
@property (nonatomic , assign) NSInteger              likes;
@property (nonatomic , assign) BOOL              if_master;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              author_id;
@property (nonatomic , strong) Author_profile              * author_profile;
@property (nonatomic , copy) NSString              * user_ip;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , copy) NSString              * html_content;
@property (nonatomic , assign) NSInteger              tid;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              replies;

@end
