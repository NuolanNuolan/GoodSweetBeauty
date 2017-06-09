//
//  MyPostViewController.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HJViewController.h"
typedef NS_ENUM(NSUInteger, Posttingtype) {
    
    StatusMaster = 1 ,  ///< 主贴
    StatusComments = 0///< 评论
};


@interface MyPostViewController : HJViewController

@end
