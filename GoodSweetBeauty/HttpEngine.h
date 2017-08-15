//
//  HttpEngine.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserPostingViewController.h"



@interface HttpEngine : NSObject
/**
 登录成功处理
 */
+(void)Login_Success:(NSDictionary *)responseObjecct;
/**
 图片上传统一接口
 */
+(void)uploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete;

/**
 头像上传
 */
+(void)headimageuploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete;
/**
 提交注册
 */
+(void)RegistrationInput:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 登录
 */
+(void)UserLogin:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 会员资料
 */
+(void)UserDetailcomplete:(void(^)(BOOL success ,id responseObject))complete;
/**
 我的粉丝
 */
+(void)UserFanspage:(NSInteger )page pagesize:(NSInteger )pagesize complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 我的关注
 */
+(void)Userfollowupspage:(NSInteger )page pagesize:(NSInteger )pagesize complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 关注
 */
+(void)UserFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 取消关注
 */
+(void)UserCancelFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete;
/**
//请求帖子
 */
+(void)BBSGetPost:(NSInteger )type withpage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 发送接口
 @param dic 需要的数据包
 @param Arrimage 图片数组
 @param type_status type
 @param pk 有些需要帖子的ID
 @param complete 返回参数
 */
+(void)UserPostting:(NSMutableDictionary *)dic witharrimage:(NSMutableArray *)Arrimage withtype:(YouAnStatusComposeViewType )type_status withpk:(NSInteger)pk complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 //帖子详情 按时间 按热度
 */
+(void)PostingDeatil:(NSInteger )postintID withdic:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 打赏

 */
+(void)Exceptional:(NSInteger )conins withpk:(NSInteger )pk complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 
 帖子收藏/取下收藏
 */
+(void)Posttingcollection:(NSInteger )pk complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 我的帖子
 */
+(void)UserPostting_master_comment:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 认证
 */
+(void)Vip_Application:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 收藏
 */
+(void)MyCollectionWithpage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;


/**
 发送短信接口
 */
+(void)SendMes:(NSString *)phone Type:(NSString *)type complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 验证码校验
 */
+(void)Mescheck:(NSString *)phone Type:(NSString *)type code:(NSString *)code complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 @我的
 */
+(void)AtMePosts:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 有安币变动记录
 传入变动类型
 */
+(void)CoinsRecord:(NSInteger )page type:(NSString * )type complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 帖子点赞
 */
+(void)Posetlike:(NSInteger )post_id commentid:(NSInteger )commentid complete:(void(^)(BOOL success ,id responseObject))complete;

/**
 获取私信接口
 */
+(void)Getmessagescomplete:(void(^)(BOOL success ,id responseObject))complete;
/**
 点对点私信
 */
+(void)GetPointMessage:(NSInteger )userid page:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 发私信
 */
+(void)SendPointMes:(NSInteger )userid withcontent:(NSString *)content complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 商务名片
 */
+(void)BusinessCard:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 发表口碑评论
 */
+(void)PostRating:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 我发表的口碑评价
 */
+(void)MyCommentspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 修改密码接口
 */
+(void)ModifyPas:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 忘记密码 短信找回
 */
+(void)ForGotPas_Mes:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 签到
 */
+(void)UserSignincomplete:(void(^)(BOOL success ,id responseObject))complete;
/**
 删除发表的口碑评价
 */
+(void)Delete_Comments:(NSInteger )cid complete:(void(^)(BOOL success ,id responseObject))complete;
/**
 搜索内容接口
 */
+(void)Search:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete;
@end

