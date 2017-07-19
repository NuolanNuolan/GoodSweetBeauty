//
//  BBSTitleDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellTextHighlightColor GETMAINCOLOR // Link 文本色

@interface BBSTitleDeatilTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)setmodel:(YouAnBBSDeatilModel *)model;


@end



