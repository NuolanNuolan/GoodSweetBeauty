//
//  YouAnConisRecordModel.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouAnConisRecordModel : NSObject
@property (nonatomic , copy) NSString              * action;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * action_ip;
@property (nonatomic , copy) NSString              * action_user;
@property (nonatomic , assign) NSInteger              member_id;
@property (nonatomic , assign) NSInteger              created;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , copy) NSString              * date;

@end
