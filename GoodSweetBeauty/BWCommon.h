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
+(NSString *)TheTimeStamp:(NSString *)date;
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

@end
