//
//  ConisTwoTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConisTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;
- (IBAction)btn_buy_click:(UIButton *)sender;
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
