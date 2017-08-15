//
//  YouAnSearchThreadsModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ThreadsResults :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , copy) NSString              * last_poster;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , assign) NSInteger              favors;
@property (nonatomic , assign) NSInteger              likes;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              author_id;
@property (nonatomic , assign) NSInteger              replies;
@property (nonatomic , strong) Author_profile              * author_profile;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) NSInteger              hits;
@property (nonatomic , assign) NSInteger              last_post;
@property (nonatomic , assign) BOOL              if_feature;
@property (nonatomic , copy) NSString              * content;

@end

@interface Threads :NSObject
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray<ThreadsResults *>              * results;

@end

@interface YouAnSearchThreadsModel :NSObject
@property (nonatomic , strong) Threads              * threads;

@end

