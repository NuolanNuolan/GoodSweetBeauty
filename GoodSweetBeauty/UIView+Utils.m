//
//  UIView+Utils.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)
- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
@end
