//
//  YouAnMessageModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface From_member :NSObject<NSCoding>
@property (nonatomic , assign) NSInteger              vip;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatar;

@end

@interface Results :NSObject<NSCoding>
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * member_name;
@property (nonatomic , copy) NSString              * from_member_name;
@property (nonatomic , assign) NSInteger              member_id;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) BOOL              received;
@property (nonatomic , assign) BOOL              new_mes;
@property (nonatomic , assign) NSInteger              from_member_id;
@property (nonatomic , strong) From_member              * from_member;

@end

@interface YouAnMessageModel :NSObject<NSCoding>
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray<Results *>              * results;

@end

