//
//  HistoricalRecordViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
typedef NS_ENUM(NSUInteger, Historyrecord) {
    
    Statushiscoins = 1 ,  ///< 历史记录
    Statustopinrecord = 0///< 充值记录
};
@interface HistoricalRecordViewController : HJViewController


//判断是充值记录还是历史记录
-(instancetype)initWithtype:(Historyrecord )type;



@end
