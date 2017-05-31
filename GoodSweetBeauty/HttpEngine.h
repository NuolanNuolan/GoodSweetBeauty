//
//  HttpEngine.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpEngine : NSObject
+(void)Login_Success:(NSDictionary *)responseObjecct;
//图片上传统一接口
+(void)uploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete;
//提交注册
+(void)RegistrationInput:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
//登录
+(void)UserLogin:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
//会员资料
+(void)UserDetailcomplete:(void(^)(BOOL success ,id responseObject))complete;
//我的粉丝
+(void)UserFanspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
//我的关注
+(void)Userfollowupspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
//关注
+(void)UserFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete;
//取消关注
+(void)UserCancelFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete;
//请求帖子
+(void)BBSGetPost:(NSInteger )type withpage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
//发帖
+(void)UserPostting:(NSMutableDictionary *)dic witharrimage:(NSMutableArray *)Arrimage complete:(void(^)(BOOL success ,id responseObject))complete;

@end
