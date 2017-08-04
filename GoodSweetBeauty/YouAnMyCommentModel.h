//
//  YouAnMyCommentModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface commentsresults :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              from_member_id;
@property (nonatomic , assign) NSInteger              total_score;
@property (nonatomic , assign) NSInteger              service_score;
@property (nonatomic , copy) NSString              * product_name;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , strong) NSArray<Ats *>              * ats;
@property (nonatomic , copy) NSString              * member_name;
@property (nonatomic , assign) NSInteger              product_score;
@property (nonatomic , strong) From_member              * from_member;
@property (nonatomic , copy) NSString              * from_member_name;
@property (nonatomic , copy) NSString              * replies;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , strong) NSArray<NSString *>              * images;
@property (nonatomic , assign) NSInteger              member_id;
//添加一个评论是否展开
@property (nonatomic , assign) BOOL              isopen;

@end

@interface YouAnMyCommentModel :NSObject
@property (nonatomic , copy) NSString              * previous;
@property (nonatomic , strong) NSArray<commentsresults *>              * results;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * next;

@end
