//
//  Exceptional_view.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/4.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Exceptional_view;

//打赏按钮回调 打赏金额
typedef void (^exceptionalBlock)(Exceptional_view *view,NSInteger Amount);

@interface Exceptional_view : UIView


//传入有安币余额 以及打赏金额列表 打赏文字
+(instancetype)alertViewExceptional:(NSInteger )balance
                           withAmount:(NSArray *)Arr_Amount
                       except_title:(NSString *)title
                           exceptionalblockclick:(exceptionalBlock)exceptionalblock;
-(void)show;
-(void)dismiss;

@end
