//
//  MesDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnPointMessageModel.h"

@interface MesDeatilTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)SetModel:(YouAnPointMessageModel *)model ;

@end
