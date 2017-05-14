//
//  HttpEngine.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpEngine : NSObject
//+(instancetype)

//测试网络请求
+(void)TestNetWorkcomplete:(void(^)(id responseObject))complete;

//提交注册
+(void)RegistrationInput:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;

//登录
+(void)UserLogin:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
@end
