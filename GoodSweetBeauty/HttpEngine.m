//
//  HttpEngine.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HttpEngine.h"

@implementation HttpEngine

+(void)Login_Success:(NSDictionary *)responseObjecct{

    //token
    [[NSUserDefaults standardUserDefaults]setObject:responseObjecct[@"token"] forKey:@"TOKEN_KEY"];
    //username
    [[NSUserDefaults standardUserDefaults]setObject:[responseObjecct[@"user"] objectForKey:@"username"] forKey:@"NAME"];
    //phone
    [[NSUserDefaults standardUserDefaults]setObject:[responseObjecct[@"user"] objectForKey:@"mobile"] forKey:@"PHONE"];
    
}
//图片上传统一接口
+(void)uploadfile:(NSArray *)Arrimage comlete:(void(^)(BOOL susccess , id responseObjecct))complete{

    
    NSString*str=[NSString stringWithFormat:@"%@/storage/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSMutableArray *Arr_str = [NSMutableArray arrayWithCapacity:0];
    for (int i =0; i<Arrimage.count; i++) {
        [Arr_str addObject:[NSString stringWithFormat:@"%@.jpg",[BWCommon GetNowTimewithformat:@"yyyyMMddHHmmss"]]];
    }
    [PPNetworkHelper uploadImagesWithURL:str parameters:nil name:@"file" images:Arrimage fileNames:Arr_str imageScale:1 imageType:@"jpeg" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
        
        complete(YES,responseObject[@"filename"]);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
    
}
//提交注册
+(void)RegistrationInput:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{


    NSString *url = [NSString stringWithFormat:@"%@/auth/register/",ADDRESS_API];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                
                complete(NO,dic);
                
            }else{
            
                 complete(NO,@"服务器繁忙");
            }
        }else{
        
            complete(NO,@"服务器繁忙");
        }

    }];
    
    
}
//登录
+(void)UserLogin:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/api-token-auth/",ADDRESS_API];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        //储存相关信息
        [HttpEngine Login_Success:responseObject];
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                
                MYLOG(@"%@",dic);
                complete(NO,[NSString stringWithFormat:@"账号或密码错误"]);
            }else{
            
                complete(NO,[NSString stringWithFormat:@"服务器繁忙"]);
            }
            
        }else{
        
            complete(NO,[NSString stringWithFormat:@"服务器繁忙"]);
        }
    }];
}
//会员资料
+(void)UserDetailcomplete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/profile/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        
    
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
}
//我的粉丝
+(void)UserFanspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/fans/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
}
//我的关注
+(void)Userfollowupspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/followups/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
}
//关注
+(void)UserFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/follow/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"member_id":[NSNumber numberWithInteger:userid]};
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
}
//取消关注
+(void)UserCancelFocususerid:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/unfollow/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"member_id":[NSNumber numberWithInteger:userid]};
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
}
//请求帖子
+(void)BBSGetPost:(NSInteger )type withpage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{
    NSString * url = @"";
    switch (type) {
        case 0:
            url = [NSString stringWithFormat:@"%@/posts/threads/replied/",ADDRESS_API];
            break;
        case 1:
            url = [NSString stringWithFormat:@"%@/posts/threads/featured/",ADDRESS_API];
            break;
        case 2:
            url = [NSString stringWithFormat:@"%@/members/latest/",ADDRESS_API];
            break;
    }
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic responseCache:^(id responseCache) {
        
        if (responseCache) {
            complete(YES,responseCache[@"results"]);
        }
    } success:^(id responseObject) {
        
        complete(YES,responseObject[@"results"]);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
}
@end
