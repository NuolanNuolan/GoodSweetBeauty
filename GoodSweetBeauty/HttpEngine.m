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
    [PPNetworkHelper GET:@"http://www.mycomments.com.my/default/app/index" parameters:dict success:^(id responseObject) {
        complete(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
@end
