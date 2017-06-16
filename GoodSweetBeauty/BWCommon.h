//
//  BWCommon.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWCommon : NSObject
//是否手机号
+ (BOOL)checkInputMobile:(NSString *)_text;
//字典转JSON
+(NSString *)JsonModel:(NSDictionary *)dictModel;
//时间戳转时间
+(NSString *)TheTimeStamp:(NSString *)date withtype:(NSString *)type;
//本机ip
+ (NSString *)getIpAddresses;
//文件读写操作
//保存
+ (void)saveArrayandNSArray:(NSMutableArray *)array andByAppendingPath:(NSString *)name;
//读取
+ (NSMutableArray *)readArrayByAppendingPath:(NSString *)arrayName;
//删除
+ (void)removeNSArrayByAppendingPaht:(NSString *)arrayName;
//跳到系统某种权限
+(void)OpenSetting:(NSString *)prefs;
//判断是否包含某个字符区分大小写
+(BOOL)DoesItInclude:(NSString *)str withString:(NSString *)str1;
//判断是否包含某个字符不区分大小写
+(BOOL)DoesItIncludeBetween:(NSString *)str withString:(NSString *)str1;
//判断空字符串
+ (BOOL) isNullString:(NSString *)string;
//获取子视图父视图
+(UIViewController *)Superview:(UIView *)view;
//当前时间
+(NSString *)GetNowTimewithformat:(NSString *)format;
//当前时间戳
+(NSString *)GetNowTimestamps;
//富文本改变颜色
+(NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText collor:(UIColor *)color;
/**
 正则
 */
+(BOOL)Predicate:(NSString *)Predicate str:(NSString *)str;
//是否登录
+(BOOL)islogin;

+(id)GetNSUserDefaults:(NSString *)key;

+(void)SetNSUserDefaultsWithValue:(id )value withkey:(NSString *)key;
//UTF8转string
+(NSString *)stringByRemovingPercentEncoding:(NSString *)str;
//string转UTF8
+(NSString *)UTF8string:(NSString *)str;
//Unicode解码
+(NSString *)UnicodeDic:(NSDictionary *)dic;

@end
