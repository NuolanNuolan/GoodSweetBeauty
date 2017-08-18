//
//  ExceptionalTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/18.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExceptionalTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)SetRewardsModel:(Rewards *)model withrow:(NSInteger )row;

@end
