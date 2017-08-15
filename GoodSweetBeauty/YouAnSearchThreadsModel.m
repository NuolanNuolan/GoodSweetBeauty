//
//  YouAnSearchThreadsModel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "YouAnSearchThreadsModel.h"

@implementation ThreadsResults

@end
@implementation Threads
+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    
    return @{@"results":[ThreadsResults class]};
}
@end
@implementation YouAnSearchThreadsModel

@end
