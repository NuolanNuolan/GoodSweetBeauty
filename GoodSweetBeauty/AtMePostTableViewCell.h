//
//  AtMePostTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnAtMeModel.h"
@interface AtMePostTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)SetModel:(YouAnAtMeModel *)model withrow:(NSInteger )row;

@end
