//
//  BBSPostTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnCollectionModel.h"

@interface BBSPostTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;
/**
 首页
 */
-(void)SetSection:(NSInteger )sention withmodel:(YouAnBBSModel *)model;
/**
 收藏页
 */
-(void)SetRow:(NSInteger )row withmodel:(YouAnCollectionModel *)model;
@end
