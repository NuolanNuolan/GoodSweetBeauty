//
//  YouAnSearchMemberModel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "YouAnSearchMemberModel.h"

@implementation MemberResults

@end
@implementation Members

+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    
    return @{@"results":[MemberResults class]};
}

@end
@implementation YouAnSearchMemberModel

@end

