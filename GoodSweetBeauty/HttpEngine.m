//
//  HttpEngine.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HttpEngine.h"

@implementation HttpEngine


+(void)TestNetWorkcomplete:(void(^)(id responseObject))complete
{
    MYLOG(@"进入了这里");
    NSDictionary *dict = @{@"format": @"json"};
    /**
     *  上传图片文件
     *
     *  @param URL        请求地址
     *  @param parameters 请求参数
     *  @param images     图片数组
     *  @param name       文件对应服务器上的字段
     *  @param fileName   文件名
     *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
     *  @param progress   上传进度信息
     *  @param success    请求成功的回调
     *  @param failure    请求失败的回调
     *
     *  @return 返回的对象可取消请求,调用cancle方法
     */
//    PPNetworkHelper uploadImagesWithURL:<#(NSString *)#> parameters:<#(id)#> name:<#(NSString *)#> images:<#(NSArray<UIImage *> *)#> fileNames:<#(NSArray<NSString *> *)#> imageScale:<#(CGFloat)#> imageType:<#(NSString *)#> progress:<#^(NSProgress *progress)progress#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>
    
    
    
    
    
    [PPNetworkHelper GET:@"http://www.mycomments.com.my/default/app/index" parameters:dict responseCache:^(id responseCache) {
        complete(responseCache);
    } success:^(id responseObject) {
        complete(responseObject);
        
    } failure:^(NSError *error) {
        
    }];
//    
//    
//    [PPNetworkHelper GET:@"http://www.mycomments.com.my/default/app/index" parameters:dict success:^(id responseObject) {
//        complete(responseObject);
//    } failure:^(NSError *error) {
//        
//    }];
}
//提交注册
+(void)RegistrationInput:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{


    NSString *url = [NSString stringWithFormat:@"%@/auth/register/",ADDRESS_API];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        MYLOG(@"%@",dic);
        complete(NO,error);

    }];
    
    
}
//登录
+(void)UserLogin:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/api-token-auth/",ADDRESS_API];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        MYLOG(@"%@",dic);
        complete(NO,error);
        
    }];
}
@end
