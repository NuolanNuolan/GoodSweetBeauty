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
+(void)uploadfile:(UIImage *)image comlete:(void(^)(BOOL susccess , id responseObjecct))complete{

    
    NSString*str=[NSString stringWithFormat:@"%@/storage/",ADDRESS_API];
    NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
    NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
    [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    NSArray *Arrimage = [NSArray arrayWithObjects:image, nil];
    [PPNetworkHelper uploadImagesWithURL:str parameters:nil name:@"file" images:Arrimage fileNames:nil imageScale:1 imageType:@"jpeg" progress:^(NSProgress *progress) {
        
        MYLOG(@"%f",progress.fractionCompleted);
        
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
            url = [NSString stringWithFormat:@"%@/posts/threads/latest/",ADDRESS_API];
            break;
    }
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject[@"results"]);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
    }];
}
//发帖
+(void)UserPostting:(NSMutableDictionary *)dic witharrimage:(NSMutableArray *)Arrimage complete:(void(^)(BOOL success ,id responseObject))complete{

    if (Arrimage.count>0) {
        
        NSMutableArray *arr_image_url = [NSMutableArray arrayWithCapacity:0];
        dispatch_group_t group = dispatch_group_create();
        for (int i =0; i<Arrimage.count; i++) {
            dispatch_group_enter(group);
            @weakify(self);
            [HttpEngine uploadfile:Arrimage[i] comlete:^(BOOL susccess, id responseObjecct) {
                @strongify(self);
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
            NSString *url = [NSString stringWithFormat:@"%@/posts/threads/",ADDRESS_API];
            NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
            NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
            [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
            
            [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
                
                MYLOG(@"%@",responseObject);
                
                
            } failure:^(NSError *error) {
               
                
            }];
            
        });
    }else{
    
        NSString *url = [NSString stringWithFormat:@"%@/posts/threads/",ADDRESS_API];
        NSString*token=[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN_KEY"];
        NSString*tokenStr=[NSString stringWithFormat:@"JWT %@",token];
        [PPNetworkHelper setValue:tokenStr forHTTPHeaderField:@"Authorization"];
        
        [PPNetworkHelper POST:url parameters:dic success:^(id responseObject) {
            
            MYLOG(@"%@",responseObject);
            
            
        } failure:^(NSError *error) {
            
        }];
    }

}
//帖子详情
+(void)PostingDeatil:(NSInteger )postintID withpage:(NSInteger )page withpige_size:(NSInteger )page_size complete:(void(^)(BOOL success ,id responseObject))complete{

    NSString *url = [NSString stringWithFormat:@"%@/posts/threads/%@/",ADDRESS_API,[NSNumber numberWithInteger:postintID]];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page]};
    
    [PPNetworkHelper GET:url parameters:dic success:^(id responseObject) {
        
        complete(YES,responseObject);
        
    } failure:^(NSError *error) {
        
        complete(NO,nil);
    }];
}
@end
