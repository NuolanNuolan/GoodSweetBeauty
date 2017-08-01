//
//  YouAnBBSModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/23.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YouAnBBSDeatilModel.h"
/// 认证方式
typedef NS_ENUM(NSUInteger, YouAnUserVerifyType){
    YouAnUserVerifyTypeNone = 0,     ///< 没有认证
    YouAnUserVerifyTypeStandard,     ///< 个人认证，红V
    YouAnUserVerifyTypeOrganization, ///< 公司认证，蓝V
};
@interface author_profile :NSObject
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatar;

@end
@interface YouAnBBSModel : NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * subject;
@property (nonatomic , copy) NSString              * last_poster;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , assign) NSInteger              favors;
@property (nonatomic , assign) NSInteger              likes;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              author_id;
@property (nonatomic , assign) NSInteger              replies;
@property (nonatomic , strong) author_profile              * author_profile;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) NSInteger              hits;
@property (nonatomic , assign) NSInteger              last_post;
@property (nonatomic , assign) BOOL              if_feature;
@property (nonatomic , strong) NSArray<NSString *>              * images;
@property (nonatomic , copy) NSString              * content;
@end
