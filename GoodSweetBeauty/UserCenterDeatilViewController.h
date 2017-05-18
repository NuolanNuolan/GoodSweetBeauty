//
//  UserCenterDeatilViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/18.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"

@interface UserCenterDeatilViewController : HJViewController
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL allowPullToRefresh;
@property (nonatomic, assign) CGFloat pullOffset;
@property (nonatomic, assign) CGFloat fillHight;  //segmentButtons + segmentTopSpace
@end
