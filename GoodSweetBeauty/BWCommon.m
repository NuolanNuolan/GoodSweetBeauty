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
@interface BWCommon(){

    UIImageView * image_head;
    YouAnBusinessCardModel *BusinessCardModel;
    
}
@end

@implementation BWCommon
+ (instancetype)sharebwcommn {
    static BWCommon *v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [self new];
    });
    return v;
}
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
                                    textColor:(UIColor *)textColor
                                screenPadding:(CGFloat )padding{

    NSMutableString *string = [[str_centent stringByReplacingEmojiCheatCodesToUnicode]mutableCopy];
    //判断是否有@的 添加在最后面
    if (ats_arr.count>0&&ats_arr) {
        NSString *str_at = @"";
        for (Ats *at_model in ats_arr) {
            
            str_at = [str_at stringByAppendingString:[NSString stringWithFormat:@"@%@ ",at_model.uname]];
        }
        [string appendString:str_at];
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    // 计算一行文本的高度
    CGFloat oneHeight = [@"测试Test" boundingRectWithSize:CGSizeMake(padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    CGFloat rowHeight = [string boundingRectWithSize:CGSizeMake(padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    if (rowHeight>oneHeight) {
        
        [paragraphStyle setLineSpacing:LineSpacing];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    }
    return text;
}
/**
 设置AT文本 返回高度
 */
+ (NSDictionary *)textWithStatusRowHeight:(NSString *)str_centent
                                        Atarr:(NSArray <Ats *> *)ats_arr
                                         font:(UIFont *)font
                                  LineSpacing:(CGFloat)LineSpacing
                                    textColor:(UIColor *)textColor
                                screenPadding:(CGFloat )padding{
    
    NSMutableString *string = [[str_centent stringByReplacingEmojiCheatCodesToUnicode]mutableCopy];
    //判断是否有@的 添加在最后面
    if (ats_arr.count>0&&ats_arr) {
        NSString *str_at = @"";
        for (Ats *at_model in ats_arr) {
            
            str_at = [str_at stringByAppendingString:[NSString stringWithFormat:@"@%@ ",at_model.uname]];
        }
        [string appendString:str_at];
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    // 计算一行文本的高度
    CGFloat oneHeight = [@"测试Test" boundingRectWithSize:CGSizeMake(padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    CGFloat rowHeight = [string boundingRectWithSize:CGSizeMake(padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    if (rowHeight>oneHeight) {
        
        [paragraphStyle setLineSpacing:LineSpacing];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    }
    return @{@"height":[NSString stringWithFormat:@"%f",rowHeight],
             @"text":text};
}

/**
 跳转到登录页面然后返回
 */
+(void)PushTo_Login:(UIViewController *)viewcontroller{
    
    LoginViewController *view = [LoginViewController new];
    view.hidesBottomBarWhenPushed =YES;
    [viewcontroller.navigationController pushViewController:view animated:YES];
    
}
+ (CGSize)neededSizeForPhoto:(CGSize )bubbleSize {
    //bubbleSize  原尺寸
    if (bubbleSize.width>ScreenWidth-30) {
        
    }
    
    
    
    
//    CGFloat maxWidth = ScreenWidth * 0.46;
//    //限制最大宽度或高度
//    CGFloat imageViewW = bubbleSize.width/2;
//    CGFloat imageViewH = bubbleSize.height/2;
//    CGFloat factor = 1.0f;
//    if(imageViewW > imageViewH){
//        if(imageViewW > maxWidth){
//            factor = maxWidth/imageViewW;
//            imageViewW = imageViewW*factor;
//            imageViewH = imageViewH*factor;
//        }
//    }
//    else{
//        
//        if(imageViewH > maxWidth){
//            
//            factor = maxWidth/imageViewH;
//            imageViewW = MAX(imageViewW*factor,46.0);
//            //限制宽度不能超过46.0
//            imageViewH = imageViewH*factor;
//        }
//    }
//    bubbleSize = CGSizeMake(imageViewW, imageViewH);
    return bubbleSize;
}
    
/**
 用户详情页
 */
-(UIViewController *)UserDeatil:(YouAnBusinessCardModel *)model{

    
    CenterOneViewController *one = [CenterOneViewController new];
    one.model = model;
    CenterTwoViewController *two = [CenterTwoViewController new];
    two.model = model;
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    configration.normalItemColor = RGB(51, 51, 51);
    configration.selectedItemColor = GETMAINCOLOR;
    configration.lineColor = GETMAINCOLOR;
    configration.scrollMenu =NO;
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    
    CenterMainViewController *vc = [CenterMainViewController pageScrollViewControllerWithControllers:@[one,two] titles:@[@"商务名片",@"口碑评价"] Configration:configration];
    vc.dataSource = self;
    //头部headerView
    vc.headerView = [self view_userhead:model];
    
    return vc;
}
-(UIView *)view_userhead:(YouAnBusinessCardModel *)model{
    
    BusinessCardModel = nil;
    BusinessCardModel = model;
    UIView *view_userhead = [[UIView alloc] initWithFrame:CGMAKE(0, 0, SCREEN_WIDTH, 235)];
    view_userhead.backgroundColor = GETMAINCOLOR;
    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    image_head.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(amplification)];
    [image_head addGestureRecognizer:tap];
    [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,[model.profile.avatar stringByReplacingOccurrencesOfString:@"small" withString:@"middle"]]] placeholderImage:[UIImage imageNamed:@"head"]];
    
    UILabel * lab_username = [UILabel new];
    [lab_username setTextColor:[UIColor whiteColor]];
    [lab_username setFont:[UIFont boldSystemFontOfSize:16]];
    [lab_username setText:model.profile.username];
    [lab_username sizeToFit];
    
    //添加一个view 装name 和图标
    UIView *view_lab_v_level = [UIView new];
    
    UIView * view_v_level = [UIView new];
    view_v_level.backgroundColor = RGB(247, 247, 247);
    view_v_level.layer.masksToBounds =YES;
    view_v_level.layer.cornerRadius =8;
    
    UIImageView* image_v = [UIImageView new];
    
    
    UIImageView* image_level = [UIImageView new];
    
    
    UIView * view_btn_gap = [UIView new];
    view_btn_gap.backgroundColor = [UIColor clearColor];
    
    NSArray *arr = [NSArray arrayWithObjects:@"关注",@"粉丝",@"帖子", nil];
    NSArray *dataarr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)model.profile.my_follower_count],[NSString stringWithFormat:@"%ld",(long)model.profile.my_fans_count],[NSString stringWithFormat:@"%ld",(long)model.profile.my_posts_count], nil];
    for (int i =0; i<arr.count; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGMAKE(SCREEN_WIDTH/3*i, 0, SCREEN_WIDTH/3, 65)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * lab_detail = [UILabel new];
        [lab_detail setTextColor:RGB(51, 51, 51)];
        [lab_detail setFont:[UIFont systemFontOfSize:18]];
        [lab_detail sizeToFit];
        [lab_detail setText:dataarr[i]];
        
        UILabel *lab = [UILabel new];
        [lab setTextColor:RGB(102, 102, 102)];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab sizeToFit];
        [lab setText:arr[i]];
        
        
        
        [view addSubview:lab_detail];
        [view addSubview:lab];
        [view_btn_gap addSubview:view];
        
        
        lab_detail.whc_TopSpace(15).whc_CenterX(0).whc_Height(13);
        lab.whc_TopSpaceToView(10,lab_detail).whc_CenterX(0);
    }
    UIView *view_gap = [[UIView alloc]initWithFrame:CGMAKE(0, 65, SCREEN_WIDTH, 10)];
    view_gap.backgroundColor = RGB(247, 247, 247);
    [view_btn_gap addSubview:view_gap];
    
    [view_v_level addSubview:image_v];
    [view_v_level addSubview:image_level];
    [view_lab_v_level addSubview:lab_username];
    [view_lab_v_level addSubview:view_v_level];
    [view_userhead addSubview:image_head];
    [view_userhead addSubview:view_lab_v_level];
    [view_userhead addSubview:view_btn_gap];
    
    image_head.whc_Size(80,80).whc_CenterX(0).whc_TopSpace(5);
    
    view_lab_v_level.whc_TopSpaceToView(15,image_head).whc_CenterXToView(0,image_head).whc_WidthAuto().whc_HeightAuto();
    lab_username.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpaceToView(5,view_v_level);
    
    NSInteger hiddenview = YES;
    if (model.profile.vip==0) {
        
        image_v.hidden =YES;
    }else{
        
        hiddenview = NO;
        image_v.whc_Size(11,9).whc_LeftSpace(7).whc_CenterY(0).whc_RightSpaceToView(5,image_level);
        image_v.image = [UIImage imageNamed:@"iconVRed"];
    }
    if (model.profile.level==0) {
        
        image_level.hidden =YES;
        
    }else{
        
        hiddenview =NO;
        image_level.whc_Size(12,11).whc_RightSpace(7.5).whc_CenterY(0).whc_LeftSpaceToView(5,image_v);
        image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.profile.level]];
        
    }
    if (hiddenview) {
        
        view_v_level.whc_Width(0).whc_RightSpace(0).whc_Height(0).whc_CenterYToView(0,lab_username);
    }else{
        
        view_v_level.whc_WidthAuto().whc_RightSpace(0).whc_Height(16).whc_CenterYToView(0,lab_username);
    }
    
    
    view_btn_gap.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(60,view_lab_v_level).whc_Height(65);
    
    return view_userhead;
}
-(void)amplification{

    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    browseItem.bigImageUrl = [NSString stringWithFormat:@"%@%@",ADDRESS_IMG,[BusinessCardModel.profile.avatar stringByReplacingOccurrencesOfString:@"small" withString:@"big"]];// 加载网络图片大图地址
    browseItem.smallImageView = image_head;// 小图
    [arr_image_view addObject:browseItem];
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:0];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];
}
#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= (CenterBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
}
- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= (CenterBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    CenterBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}


@end
