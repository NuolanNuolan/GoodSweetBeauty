//
//  AppDelegate+Sunday.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/4/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "AppDelegate+Sunday.h"

@implementation AppDelegate (Sunday)

-(void)ResRelated{

    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}



@end
