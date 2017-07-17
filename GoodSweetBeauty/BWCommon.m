//
//  BWCommon.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

//这是公有类

#import "BWCommon.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "YouAnFansFollowModel.h"

@implementation BWCommon
//是否手机号
+ (BOOL)checkInputMobile:(NSString *)_text
{
    
    //
    NSString *MOBILE    = @"^1\\d{10}$";
    
    //
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    BOOL res1 = [regextestmobile evaluateWithObject:_text];

    
    if (res1)
    {
        return YES;
    }
    
    return NO;
    
}
/**
 正则
 */
+(BOOL)Predicate:(NSString *)Predicate str:(NSString *)str{

    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Predicate];
    if ([regextestcm evaluateWithObject:str]) {
        
        return YES;
    }
    return NO;
}
+ (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}
//时间戳转时间
+(NSString *)TheTimeStamp:(NSString *)date withtype:(NSString *)type
{
    
    
    NSTimeInterval time=[date intValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:type];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
    
}
//保存
+ (void)saveArrayandNSArray:(NSMutableArray *)array andByAppendingPath:(NSString *)name
{
    
    //创建json文件 获取根目录
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString * fileName = [docDir stringByAppendingPathComponent:name];
    if (array) {
        //字典转二进制
        NSData *dicData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        //二进制转字符串
        NSString *dataStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
        [dataStr writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}
//读取
+ (NSMutableArray *)readArrayByAppendingPath:(NSString *)arrayName
{
    // 拼接路径
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString * fileName = [docDir stringByAppendingPathComponent:arrayName];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:fileName];
    if (jdata) {
        //反序列化
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jdata options:0 error:NULL];
        NSMutableArray *arrayDict=[NSMutableArray array];
        for (int i=0; i<array.count; i++) {
            NSDictionary *dict=array[i];
            [arrayDict addObject:dict];
        }
        return arrayDict;
    }else {
        MYLOG(@"没有数据。。。");
        return nil;
    }
}
//删除本地数组
+(void)removeNSArrayByAppendingPaht:(NSString *)arrayName {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString * fileName = [docDir stringByAppendingPathComponent:arrayName];
    NSFileManager *manager=[NSFileManager defaultManager];
    [manager removeItemAtPath:fileName error:nil];
}
//跳到系统某种权限
+(void)OpenSetting:(NSString *)prefs
{
    
    //进行版本判断
    /*
     系统大于ios10直接跳到该app设置页面
     小于ios10通过传入的prefs跳到相关页面
     */
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"请在设置中开启%@",prefs] preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //在这里判断系统版本
        NSURL *url;
        if ([SYSTEMVERSION floatValue]<10) {
            //小于10
            url= [NSURL URLWithString:[NSString stringWithFormat:@"prefs:root=%@",prefs]];
        }else{
            
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        }
        [[UIApplication sharedApplication]openURL:url];
        
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:alertControl animated:YES completion:nil];
}
//判断是否包含某个字符不缺分大小写
+(BOOL)DoesItIncludeBetween:(NSString *)str withString:(NSString *)str1
{
    if (str) {
        if([str rangeOfString:str1 options:NSCaseInsensitiveSearch].location == NSNotFound){
            
            return NO;
        }else
        {
            
            return YES;
        }
    }
    
    return NO;
}
//判断是否包含某个字符 区分大小写
+(BOOL)DoesItInclude:(NSString *)str withString:(NSString *)str1
{
    if (str) {
        if([str rangeOfString:str1].location == NSNotFound){
            
            return NO;
        }else
        {
            
            return YES;
        }
    }
    
    return NO;
}
//判断空字符串
+ (BOOL) isNullString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//获取子视图父视图
+(UIViewController *)Superview:(UIView *)view{
    
    for (UIView* next = [view superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[HJViewController class]])
        {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
//当前时间
+(NSString *)GetNowTimewithformat:(NSString *)format;{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}
//当前时间戳
+(NSString *)GetNowTimestamps{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
}
#pragma mark - 富文本部分颜色
+(NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText collor:(UIColor *)color{
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                             range:hightlightTextRange];
        return attributeStr;
    }else {
        return [highlightText copy];
    }
}
//是否登录
+(BOOL)islogin{
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"])return YES;
    return NO;
}
+(id)GetNSUserDefaults:(NSString *)key{

   id value =  [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (value) {
        
        return value;
        
    }else{
    
        return nil;
    }
}
+(void)SetNSUserDefaultsWithValue:(id )value withkey:(NSString *)key{

    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//UTF8转string
+(NSString *)stringByRemovingPercentEncoding:(NSString *)str{

    if (str&&![str isEqualToString:@""]) {
        
        return [str stringByRemovingPercentEncoding];
    }
    return @"";
}
//string转UTF8
+(NSString *)UTF8string:(NSString *)str{

    if (str&&![str isEqualToString:@""]) {
        
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return @"";
}
//Unicode解码
+(NSString *)UnicodeDic:(NSDictionary *)dic{

    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
//转拼音
+(NSString *)Pinyin:(NSString *)Chinese{

    NSMutableString *pinyin = [Chinese mutableCopy];
    NSString * pinyinstr = @"";
    
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //不去掉空格
    pinyinstr = [pinyin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pinyinstr = [pinyin stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    pinyinstr = [pinyin stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    pinyinstr = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return pinyinstr;
    
}
+ (BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i<string.length; i++)
    {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5)
        {
            return YES;
        }
    }
    return NO;
}
//取出@的人 以及 内容
+(NSDictionary *)PredicateAt:(NSString *)content Atarr:(NSMutableArray *)Arr_at{

    if (Arr_at.count==0) {
        
        NSDictionary *dic = @{@"content":[content stringByReplacingEmojiUnicodeToCheatCodes],
                              @"at":@""};
        return dic;
        
    }else{
        
        //@列表
        NSMutableArray *Arr_Deal_at = [NSMutableArray arrayWithCapacity:0];
        
        NSString *pattern = [NSString stringWithFormat:@"@(.+?) "];
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
        NSArray *results = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
        if (results.count>0) {
            
            //内容
            NSString *str_content = content;
            for (NSTextCheckingResult *result in results) {
                MYLOG(@"%@ %@", NSStringFromRange(result.range), [content substringWithRange:result.range]);
                //正则提取出来的内容 包含@和空格
                NSString *str_result =  [[content substringWithRange:result.range]substringFromIndex:1];
                //去掉开头的@
                //去掉后面的空格
                str_result = [str_result substringToIndex:str_result.length-1];
                //提取出来的用户名 与 At Model里面相对比
                for (YouAnFansFollowModel *model in Arr_at) {
                    
                    if ([model.username isEqualToString:str_result]) {
                        //如果At列表里面有这个人 @列表+1 @内容去除
                        [Arr_Deal_at addObject:model];
                        str_content = [str_content stringByReplacingOccurrencesOfString:[content substringWithRange:result.range] withString:@""];
                        
                    }
                }
            }
            
            NSString *str_Deal_at = @"";
            for (YouAnFansFollowModel *model in Arr_Deal_at) {
                
                str_Deal_at = [str_Deal_at stringByAppendingString:[NSString stringWithFormat:@"%ld##",(long)model.id]];
            }
            if (![str_Deal_at isEqualToString:@""]) {
                
                str_Deal_at = [str_Deal_at substringToIndex:str_Deal_at.length-2];
            }
            NSDictionary *dic = @{@"content":[str_content stringByReplacingEmojiUnicodeToCheatCodes],
                                  @"at":str_Deal_at};
            return dic;
        }else{
        
            NSDictionary *dic = @{@"content":[content stringByReplacingEmojiUnicodeToCheatCodes],
                                  @"at":@""};
            return dic;
        }
    }
}
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
/**
 设置AT文本
 */
+ (NSMutableAttributedString *)textWithStatus:(NSString *)str_centent
                                        Atarr:(NSArray <Ats *> *)ats_arr
                                         font:(UIFont *)font
                                  LineSpacing:(CGFloat)LineSpacing
                                    textColor:(UIColor *)textColor{

    NSMutableString *string = [[str_centent stringByReplacingEmojiCheatCodesToUnicode]mutableCopy];
    //判断是否有@的 添加在最后面
    if (ats_arr.count>0&&ats_arr) {
        NSString *str_at = @"";
        for (Ats *at_model in ats_arr) {
            
            str_at = [str_at stringByAppendingString:[NSString stringWithFormat:@"@%@ ",at_model.uname]];
        }
        [string appendString:str_at];
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSBaselineOffsetAttributeName:@(0)}];
    text.font = font;
    text.color = textColor;

    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    [text addAttribute:NSBaselineOffsetAttributeName value:@(0) range:NSMakeRange(0, [string length])];
    
    return text;

}
@end
