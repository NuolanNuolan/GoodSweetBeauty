//
//  CoinsViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
typedef NS_ENUM(NSUInteger, LoadDatatype) {
    
    Statuscoins = 1 ,  ///< 商品兑换列表
    Statusrecord = 0///< 兑换记录
};
@interface CoinsViewController : HJViewController
-(instancetype)initWithconins:(NSInteger )conins;


//有安币
@property(nonatomic,assign)NSInteger conins;
@end
