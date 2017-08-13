//
//  YouAnBBSDeatilModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//
//YouAnBBSDeatilModel
#import <Foundation/Foundation.h>


@interface Ats :NSObject 
@property (nonatomic , copy) NSString              * uname;
@property (nonatomic , assign) NSInteger              uid;

@end

@interface Author_profile :NSObject
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatar;

@end
@interface Images :NSObject
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * size;

@end
@interface Master_posts :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , assign) NSInteger              father_id;
@property (nonatomic , strong) NSArray<Ats *>              * ats;
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
@property (nonatomic , strong) NSArray<Images *>              * images;
@property (nonatomic , copy) NSString              * html_content;
@property (nonatomic , assign) NSInteger              tid;
@property (nonatomic , copy) NSString              * content;

@end

@interface Profile :NSObject
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatar;

@end

@interface Rewards :NSObject
@property (nonatomic , assign) NSInteger              uid;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , copy) NSString              * uname;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , strong) Profile              * profile;
@property (nonatomic , assign) NSInteger              tid;
@property (nonatomic , assign) NSInteger              pid;
@end

@interface Father :NSObject
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
@property (nonatomic , strong) NSArray<Ats *>              * ats;

@end

@interface Posts :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , assign) NSInteger              father_id;
@property (nonatomic , strong) NSArray<Ats *>              * ats;
@property (nonatomic , strong) Father              * father;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , assign) BOOL              if_like;
@property (nonatomic , assign) NSInteger              favors;
@property (nonatomic , copy) NSString              * stripd_content;
@property (nonatomic , assign) NSInteger              likes;
@property (nonatomic , assign) BOOL              if_master;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              author_id;
@property (nonatomic , strong) Author_profile              * author_profile;
@property (nonatomic , copy) NSString              * user_ip;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , strong) NSArray<NSString *>              * images;
@property (nonatomic , copy) NSString              * html_content;
@property (nonatomic , assign) NSInteger              tid;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) BOOL                  isopen;

@end

@interface YouAnBBSDeatilModel :NSObject
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) NSInteger              last_post;
@property (nonatomic , assign) BOOL              if_feature;
@property (nonatomic , assign) NSInteger              replies;
@property (nonatomic , assign) NSInteger              likes;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) Master_posts              * master_posts;
@property (nonatomic , assign) NSInteger              hits;
@property (nonatomic , strong) NSArray<Posts *>              * hot_posts;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , copy) NSString              * if_follow;
@property (nonatomic , strong) NSArray<Rewards *>              * rewards;
@property (nonatomic , assign) NSInteger              posts_count;
@property (nonatomic , copy) NSString              * last_poster;
@property (nonatomic , assign) NSInteger              author_id;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , strong) Author_profile              * author_profile;
@property (nonatomic , strong) NSArray<Posts *>              * posts;
@property (nonatomic , assign) NSInteger              favors;
@property (nonatomic , assign) BOOL              if_favor;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , copy) NSString              * content;


@end

