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
    //id
    [[NSUserDefaults standardUserDefaults]setInteger:[[responseObjecct[@"user"]objectForKey:@"id"] integerValue] forKey:@"USERID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //发出一个通知
    NSNotification *notification = [NSNotification notificationWithName:@"LOGINSUCCNOTIFI" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}
//图片上传统一接口
+(void)uploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete{

    
    NSString*str=[NSString stringWithFormat:@"%@/storage/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSArray *Arrimage = [NSArray arrayWithObjects:image, nil];
    [PPNetworkHelper uploadImagesWithURL:str parameters:nil name:@"file" images:Arrimage fileNames:nil imageScale:0.5 imageType:@"jpeg" progress:^(NSProgress *progress) {
        
        MYLOG(@"%f",progress.fractionCompleted);
        
    } success:^(id responseObject) {
        
        
        complete(YES,responseObject[@"filename"]);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
    
}
/**
 头像上传
 */
+(void)headimageuploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete{

    NSString*str=[NSString stringWithFormat:@"%@/members/avatar/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSArray *Arrimage = [NSArray arrayWithObjects:image, nil];
    [PPNetworkHelper uploadImagesWithURL:str parameters:nil name:@"file" images:Arrimage fileNames:nil imageScale:1 imageType:@"jpeg" progress:^(NSProgress *progress) {
        
        MYLOG(@"%f",progress.fractionCompleted);
        
    } success:^(id responseObject) {
        
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
    
    [PPNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        
        if (responseCache) {
            
            complete(YES,responseCache);
        }
        
    } success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
    }];
    
    
//    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
//        
//    
//        complete(YES,responseObject);
//        
//    } failure:^(NSError *error) {
//        
//        complete(NO,nil);
//        
//    }];
    
}
//我的粉丝
+(void)UserFanspage:(NSInteger )page pagesize:(NSInteger )pagesize complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/fans/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page],
                          @"page_size":[NSNumber numberWithInteger:pagesize]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
        
    }];
    
}
//我的关注
+(void)Userfollowupspage:(NSInteger )page pagesize:(NSInteger )pagesize complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/followups/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page],
                          @"page_size":[NSNumber numberWithInteger:pagesize]};
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
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                MYLOG(@"%@",dic)
                complete(NO,dic);
            }
        }
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
            url = [NSString stringWithFormat:@"%@/posts/threads/latest/",ADDRESS_API];
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
    
//    
//    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
//        
//        complete(YES,responseObject[@"results"]);
//        
//    } failure:^(NSError *error) {
//        
//        complete(NO,nil);
//    }];
}
//发帖
+(void)UserPostting:(NSMutableDictionary *)dic witharrimage:(NSMutableArray *)Arrimage withtype:(YouAnStatusComposeViewType )type_status withpk:(NSInteger)pk complete:(void(^)(BOOL success ,id responseObject))complete{

    //构建url
    NSString * url = @"";
    switch (type_status) {
        case YouAnStatusComposeViewTypePostTing:{
            
            url = [NSString stringWithFormat:@"%@/posts/threads/",ADDRESS_API];
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            url = [NSString stringWithFormat:@"%@/posts/threads/%ld/reply/",ADDRESS_API,(long)pk];
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            url = [NSString stringWithFormat:@"%@/posts/threads/%ld/reply/",ADDRESS_API,(long)pk];
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            url = [NSString stringWithFormat:@"%@/rating/record/",ADDRESS_API];
        }
            break;
    }
    if (Arrimage.count>0) {
        
        NSMutableArray *arr_image_url = [NSMutableArray arrayWithCapacity:0];
        dispatch_group_t group = dispatch_group_create();
        for (int i =0; i<Arrimage.count; i++) {
            dispatch_group_enter(group);
//            @weakify(self);
            [HttpEngine uploadfile:Arrimage[i] comlete:^(BOOL susccess, id responseObjecct) {
//                @strongify(self);
                if (susccess) {
                    dispatch_group_leave(group);
                    @synchronized (arr_image_url) { //线程不安全 加个同步锁
                        [arr_image_url addObject:responseObjecct];
                    }
                    MYLOG(@"%@",responseObjecct);
                }
            }];
        }
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //这里来发帖
            NSString *imagestr = @"";
            if (arr_image_url.count==1) {
                
                imagestr = [NSString stringWithFormat:@"%@",[arr_image_url firstObject]];
                
            }else{
            
                for (NSString *str_image in arr_image_url) {
                    
                    imagestr = [imagestr stringByAppendingString:[NSString stringWithFormat:@"%@##",str_image]];
                }
                //删除第一个##
                imagestr = [imagestr substringToIndex:imagestr.length-2];
            }
            [dic setValue:imagestr forKey:@"images"];
            
            NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
            NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
            [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
            MYLOG(@"%@",dic)
            [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
                
                MYLOG(@"%@",responseObject);
                complete(YES,responseObject);
                
                
            } failure:^(NSError *error) {
               NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
                if (data) {
                    NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    MYLOG(@"%@",dic);
                }
                complete(NO,nil);
            }];
            
        });
    }else{
    
        NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
        [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
        [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
            
            MYLOG(@"%@",responseObject);
            complete(YES,responseObject);
            
        } failure:^(NSError *error) {
            NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (data) {
                NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                MYLOG(@"%@",dic);
            }
            complete(NO,nil);
            
        }];
    }

}
//帖子详情
+(void)PostingDeatil:(NSInteger )postintID withdic:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/posts/threads/%@/",ADDRESS_API,[NSNumber numberWithInteger:postintID]];
//    NSDictionary *dic ;
//    if (if_master) {
//        
//        dic =@{@"page":[NSNumber numberWithInteger:page],
//               @"if_master":[NSNumber numberWithInteger:1]};
//    }else{
//    
//        dic =@{@"page":[NSNumber numberWithInteger:page]};
//    }
    
    if ([BWCommon islogin]) {
        NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
        [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    }
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
        }
        complete(NO,nil);
    }];
}
/**
 打赏
 */
+(void)Exceptional:(NSInteger )conins withpk:(NSInteger )pk complete:(void(^)(BOOL success ,id responseObject))complete;{

    NSString *url = [NSString stringWithFormat:@"%@/posts/threads/%@/reward/",ADDRESS_API,[NSNumber numberWithInteger:pk]];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"coins":[NSNumber numberWithInteger:conins],
                          @"user_ip":[BWCommon getIpAddresses]};
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
        
            complete(NO,nil);
        }
        
        
    }];
    
}
/**
 
 帖子收藏/取下收藏
 */
+(void)Posttingcollection:(NSInteger )pk complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/posts/threads/%@/favor/",ADDRESS_API,[NSNumber numberWithInteger:pk]];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];

    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
        
    }];
}
/**
 我的帖子
 */
+(void)UserPostting_master_comment:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/my-posts/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
    }];
    
}
/**
 认证
 */
+(void)Vip_Application:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/vip-application/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@",responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
       
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }

    }];
    
}
/**
 收藏
 */
+(void)MyCollectionWithpage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/my-favors/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
//        GCD_AFTER(3, complete(YES,responseObject););
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 发送短信接口
 */
+(void)SendMes:(NSString *)phone Type:(NSString *)type complete:(void(^)(BOOL success ,id responseObject))complete
{

    NSString *url = [NSString stringWithFormat:@"%@/sms/send/",ADDRESS_API];
    //参数
    NSDictionary *dic = @{@"mobile":phone,
                          @"code_type":type,
                          @"time":[BWCommon GetNowTimestamps],
                          @"token":[[NSString stringWithFormat:@"%@|%@|yabbs!@#$",phone,[BWCommon GetNowTimestamps]] md5String]};
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@", responseObject);
        complete(YES,@"");
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
    }];
}
/**
 验证码校验
 */
+(void)Mescheck:(NSString *)phone Type:(NSString *)type code:(NSString *)code complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/sms/verify/",ADDRESS_API];
    //参数
    NSDictionary *dic = @{@"mobile":phone,
                          @"code_type":type,
                          @"code":code};
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@", responseObject);
        complete(YES,nil);
        
    } failure:^(NSError *error) {
        
        NSError *errort = error.userInfo[@"NSUnderlyingError"];
        NSData*data=errort.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {

            NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            MYLOG(@"%@",str);
            complete(NO,str);
        }else{
            
            complete(NO,nil);
        }
    }];
    
}

/**
 @我的
 */
+(void)AtMePosts:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/at-me-posts/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 有安币变动记录
 */
+(void)CoinsRecord:(NSInteger )page type:(NSString * )type complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/coins/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page],
                          @"action_type":type};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 帖子点赞
 */
+(void)Posetlike:(NSInteger )post_id commentid:(NSInteger )commentid complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/posts/threads/%@/like/",ADDRESS_API,[NSNumber numberWithInteger:post_id]];
    //参数
    NSDictionary *dic = @{@"pid":[NSNumber numberWithInteger:commentid]};
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        MYLOG(@"%@", responseObject);
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            
            NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            MYLOG(@"%@",str);
            complete(NO,str);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 获取私信接口
 */
+(void)Getmessagescomplete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/my-letters/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 点对点私信
 */
+(void)GetPointMessage:(NSInteger )userid page:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/%ld/my-letters/",ADDRESS_API,(long)userid];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
       
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
       
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 发私信
 */
+(void)SendPointMes:(NSInteger )userid withcontent:(NSString *)content complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/letter/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSDictionary *dic = @{@"to_member_id":[NSNumber numberWithInteger:userid],
                          @"content":content};
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
       
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
       
        complete(NO,nil);
        
    }];
    
    
    
    
}
/**
 商务名片
 */
+(void)BusinessCard:(NSInteger )userid complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/%ld/business-card/",ADDRESS_API,(long)userid];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
    
}
/**
 发表口碑评论
 */
+(void)PostRating:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/rating/record/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
    }];
}
/**
 我发表的口碑评价
 */
+(void)MyCommentspage:(NSInteger )page complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/rating/record/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 修改密码接口
 */
+(void)ModifyPas:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    
    NSString *url = [NSString stringWithFormat:@"%@/auth/password/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 忘记密码 短信找回
 */
+(void)ForGotPas_Mes:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/sms/password/",ADDRESS_API];
    
//    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
//    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
//    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            MYLOG(@"%@",dic);
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 签到
 */
+(void)UserSignincomplete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/members/coins-signin/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            complete(NO,dic);
        }else{
            
            complete(NO,nil);
        }
        
    }];
}
/**
 删除发表的口碑评价
 */
+(void)Delete_Comments:(NSInteger )cid complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/rating/record/%ld/",ADDRESS_API,(long)cid];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    /**
     这里使用第三方框架取到afhttpmanger
     */
    [PPNetworkHelper setAFHTTPSessionManagerProperty:^(AFHTTPSessionManager *sessionManager) {
        [sessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
        
        [sessionManager DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            complete(YES,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (data) {
                NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                complete(NO,dic);
            }else{
                
                complete(NO,nil);
            }
        }];
    }];
    
}
/**
 搜索内容接口
 */
+(void)Search:(NSDictionary *)dic complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/search/",ADDRESS_API];
    
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        NSData*data=error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data) {
            NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            complete(NO,dic);
            
        }else{
            
            complete(NO,nil);
        }
    }];
}
@end
