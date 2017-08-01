//
//  ChooseProductTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/30.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseProductTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;
@property (weak, nonatomic) IBOutlet UITextField *text_product_name;
@end
