//
//  MyAuthTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAuthTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;


-(void)SetSection:(NSInteger )section;
@end
