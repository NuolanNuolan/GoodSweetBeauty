//
//  BBSDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSDeatilTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)setmodel:(YouAnBBSDeatilModel *)model;

@end
