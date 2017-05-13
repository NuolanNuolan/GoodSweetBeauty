//
//  LoginTextField.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/13.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField



//修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+33, bounds.origin.y+2, bounds.size.width-33, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+33, bounds.origin.y+2, bounds.size.width-33, bounds.size.height);//更好理解些
    return inset;
}



//- (CGRect) rightViewRectForBounds:(CGRect)bounds {
//    
//    CGRect textRect = [super rightViewRectForBounds:bounds];
//    textRect.origin.x -= 20;
//    return textRect;
//}


@end
