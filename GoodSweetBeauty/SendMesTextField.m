//
//  SendMesTextField.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/28.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SendMesTextField.h"

@implementation SendMesTextField


- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y+2, bounds.size.width-10, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y+2, bounds.size.width-10, bounds.size.height);//更好理解些
    return inset;
}


@end
