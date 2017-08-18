//
//  Exceptional_ListView.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/17.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnBBSDeatilModel.h"
@class Exceptional_ListView;

//需要回调打赏人的userid
typedef void (^exceptionalListBlock)(Exceptional_ListView *view,NSInteger userid);

@interface Exceptional_ListView : UIView

/**
 传入一个数组  人数 总金额
 
 */
+(instancetype)alertViewExceptional:(NSInteger )count_pserson
                         withAmount:(NSInteger )banlance
                       except_title:(NSMutableArray *)arr_model
              exceptionalblockclick:(exceptionalListBlock)exceptionalblock;
-(void)show;
-(void)dismiss;

@end
