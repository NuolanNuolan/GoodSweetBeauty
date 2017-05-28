//
//  PostingTitleTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostingTitleTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;
@property (weak, nonatomic) IBOutlet UITextField *txt_title;

@end
