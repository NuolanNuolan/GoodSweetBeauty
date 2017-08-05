//
//  AppDelegate+Sunday.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/4/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

static NSString * GETMESSAGE = @"GetMes";

#import "AppDelegate+Sunday.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@implementation AppDelegate (Sunday)

-(void)ResRelated{

    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [WXApi registerApp:KWXAPPID];
    TencentOAuth *tecentauth = [[TencentOAuth alloc]initWithAppId:KQQAPPID andDelegate:nil];
    MYLOG(@"QQ的tecentauth.accessToken%@:",tecentauth.accessToken)
    
    //添加一个登录的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login_success:) name:@"LOGINSUCCNOTIFI" object:nil];
}
-(void)GetMes:(YouAnMessageModel *)model{

    if ([BWCommon islogin]) {
        //同时启动轮询
        [[JX_GCDTimerManager sharedInstance]scheduledDispatchTimerWithName:GETMESSAGE timeInterval:5 queue:nil repeats:YES actionOption:AbandonPreviousAction action:^{

                [HttpEngine Getmessagescomplete:^(BOOL success, id responseObject) {
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        if (success) {
                            
                            if ([responseObject[@"total"] integerValue]!=0) {
                                
                                [self DealData:responseObject :model];
                            }else{
                            
                                [WHCSqlite clear:[YouAnMessageModel class]];
                            }
                        }else{
                        
                            [WHCSqlite clear:[YouAnMessageModel class]];
                        }
                    });
                }];
        }];
    }

    
}
//处理数据
-(void)DealData:(id )responseObject :(YouAnMessageModel *)model{

    //进入这里说明一定有数据 历史数据不一定会有
    
    model = [YouAnMessageModel whc_ModelWithJson:responseObject];
    
    
    NSArray * Arr_Model = [WHCSqlite query:[YouAnMessageModel class]];
    
    
    if (Arr_Model.count==0) {
        //第一次登录 或者是没有历史私信
        MYLOG(@"有%lu条新信息",(unsigned long)model.results.count)
        [self PostNotiBadge:model.results.count];
        //写入数据库
        for (Results *res in model.results) {
            res.new_mes =YES;
        }
        [WHCSqlite insert:model];
        
    }else{
    
        //这里要判断ID 防止是同一个手机但是是另一个用户
        YouAnMessageModel *OldModel = Arr_Model[0];
        if (OldModel.results[0].member_id==model.results[0].member_id) {
            //是同一个用户 判断时间戳来确定新消息数量
            
            NSInteger count =[self OldModel:OldModel withNewModel:model];
            
            
            [WHCSqlite clear:[YouAnMessageModel class]];
            [WHCSqlite insert:model];
            
            if (count==0) {
                
                MYLOG(@"没有新信息")
                
            }else{
            
                MYLOG(@"有%ld条新信息",(long)count)
                [self PostNotiBadge:count];
                
            }
            
            

        }else{
        
            MYLOG(@"不是同一个用户 删除数据库 重新写入")
            [WHCSqlite clear:[YouAnMessageModel class]];
            MYLOG(@"有%lu条新信息",(unsigned long)model.results.count)
            [self PostNotiBadge:model.results.count];
            for (Results *res in model.results) {
                res.new_mes =YES;
            }
            //写入数据库
            [WHCSqlite insert:model];

        }
    }
    
    NSString * path = [WHCSqlite localPathWithModel:[YouAnMessageModel class]];
    MYLOG(@"localPath = %@",path);
}
//两个model进行比较 返回新消息条数
-(NSInteger )OldModel:(YouAnMessageModel *)oldmodel withNewModel:(YouAnMessageModel *)newmodel{
    
    NSInteger newcount = newmodel.total-oldmodel.total;
    
    for (Results *res_new in newmodel.results) {
        
        for (Results *res_old in oldmodel.results) {
            if (res_new.from_member_id == res_old.from_member_id) {
                //比较时间戳
                if (res_new.created!=res_old.created) {
                    //时间不相同 不是自己发出的消息 说明是新消息
                    if (!res_new.received) {
                        res_new.new_mes =YES;
                       newcount+=1;
                    }
                }
            }
        }
    }
    return newcount;
    
}
/**
 
 有新消息  通知发送
 */
-(void)PostNotiBadge:(NSInteger)count{

    [[NSNotificationCenter defaultCenter]postNotificationName:NLETTERNAME object:nil userInfo:@{@"badge":[NSString stringWithFormat:@"%ld",(long)count]}];
    
}
-(void)login_success:(NSNotification *)notification{

    [self GetMes:[YouAnMessageModel new]];
}



@end
