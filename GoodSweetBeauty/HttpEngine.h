//
//  HttpEngine.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/3/22.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpEngine : NSObject


//测试网络请求
+(void)TestNetWorkcomplete:(void(^)(id responseObject))complete;


@end
