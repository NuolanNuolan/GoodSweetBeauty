//
//  YouAnBBSDeatilModel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "YouAnBBSDeatilModel.h"

@implementation YouAnBBSDeatilModel

@end
@implementation Ats

@end
@implementation Images

@end
@implementation Master_posts
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self whc_Decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self whc_Encode:encoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self whc_Copy];
}

@end

@implementation Hot_posts

@end
@implementation Rewards

@end
@implementation Father
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self whc_Decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [self whc_Encode:encoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self whc_Copy];
}

@end

@implementation Posts

@end


