//
//  YouAnBBSDeatilModel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "YouAnBBSDeatilModel.h"


@implementation Ats


@end
@implementation Author_profile

@end
@implementation Master_posts

@end

@implementation Profile

@end
@implementation Rewards

@end
@implementation Posts

@end
@implementation Father


@end
@implementation YouAnBBSDeatilModel

/// 模型数组/字典元素对象可自定义类<替换实际属性名,实际类>
+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    
    return @{@"hot_posts":[Posts class]};
}

@end


