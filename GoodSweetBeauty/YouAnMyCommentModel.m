//
//  YouAnMyCommentModel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "YouAnMyCommentModel.h"
@implementation commentsresults

@end
@implementation YouAnMyCommentModel


/// 模型数组/字典元素对象可自定义类<替换实际属性名,实际类>
+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    
    return @{@"results":[commentsresults class]};
}

@end
