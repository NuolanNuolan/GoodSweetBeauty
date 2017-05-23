//
//  BBSPostTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSPostTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)SetSection:(NSInteger )sention withmodel:(YouAnBBSModel *)model;

@end
