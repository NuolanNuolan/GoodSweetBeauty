//
//  AtChooseViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
#import "YouAnFansFollowModel.h"
typedef void(^PopBlcok)();
typedef void(^ModelBlock)(YouAnFansFollowModel *model) ;

@interface AtChooseViewController : HJViewController
@property(nonatomic,copy)PopBlcok popblock;
@property(nonatomic,copy)ModelBlock modelblock;
@end
