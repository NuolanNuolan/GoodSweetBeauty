//
//  CenterBaseViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/26.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"

extern NSInteger viewcontroller_type;

@interface CenterBaseViewController : HJViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
