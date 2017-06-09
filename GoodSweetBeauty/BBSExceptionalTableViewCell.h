//
//  BBSExceptionalTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSExceptionalTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;
-(void)setmodel:(YouAnBBSDeatilModel *)model;

@end
