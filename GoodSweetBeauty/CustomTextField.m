//
//  CustomTextField.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

// 返回placeholderLabel的bounds，改变返回值，是调整placeholderLabel的位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(28, 2 , self.bounds.size.width, self.bounds.size.height);
}
// 这个函数是调整placeholder在placeholderLabel中绘制的位置以及范围
- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height)];
}
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.origin.y = 6;
    originalRect.size.height = 18.5;
    
    return originalRect;
}
@end
