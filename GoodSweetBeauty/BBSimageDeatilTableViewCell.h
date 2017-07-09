//
//  BBSimageDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSimageDeatilTableViewCell : UITableViewCell


-(void)setmodel:(YouAnBBSDeatilModel *)model isopen:(BOOL)isopen;


@property (nonatomic, strong) RACSubject *delegateSignal;

@end
