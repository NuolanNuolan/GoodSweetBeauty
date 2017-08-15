//
//  SetPwdViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/16.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"

@interface SetPwdViewController : HJViewController

//传入验证码
@property(nonatomic,copy)NSString *Verification_code;
//手机号
@property(nonatomic,copy)NSString *phone;

@end
