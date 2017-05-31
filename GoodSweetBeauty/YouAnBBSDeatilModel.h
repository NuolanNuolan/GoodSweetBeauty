//
//  YouAnBBSDeatilModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//
//YouAnBBSDeatilModel
#import <Foundation/Foundation.h>


@interface Ats :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * uname;

@end

@interface Master_posts :NSObject <NSCoding,NSCopying>
@property (nonatomic , strong) Ats              * ats;
@property (nonatomic , copy) NSString              * father_id;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * author_avatar;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , copy) NSString              * favors;
@property (nonatomic , copy) NSString              * stripd_content;
@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * if_master;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * author_id;
@property (nonatomic , copy) NSString              * created;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , copy) NSString              * user_ip;
@property (nonatomic , copy) NSString              * html_content;
@property (nonatomic , copy) NSString              * tid;
@property (nonatomic , copy) NSString              * content;

@end

@interface Hot_posts :NSObject

@end

@interface Rewards :NSObject

@end

@interface Posts :NSObject

@end

@interface YouAnBBSDeatilModel :NSObject
@property (nonatomic , copy) NSString              * last_post;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * if_feature;
@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * replies;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) Master_posts              * master_posts;
@property (nonatomic , strong) NSArray<Hot_posts *>              * hot_posts;
@property (nonatomic , copy) NSString              * hits;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , strong) NSArray<Rewards *>              * rewards;
@property (nonatomic , copy) NSString              * posts_count;
@property (nonatomic , copy) NSString              * last_poster;
@property (nonatomic , copy) NSString              * author_id;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * author_avatar;
@property (nonatomic , strong) NSArray<Posts *>              * posts;
@property (nonatomic , copy) NSString              * favors;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , copy) NSString              * created;

@end

