//
//  BBSMainViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/25.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
//轮播图请求数据回调
typedef void(^CycleScrollViewBlock) (id responseObject);


@interface BBSMainViewController : YNPageScrollViewController

@property(nonatomic,copy)CycleScrollViewBlock cycleScrollViewblock;

@end
