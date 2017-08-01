//
//  MesPaddingLabel.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/28.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MesPaddingLabel.h"

@implementation MesPaddingLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{

    UIEdgeInsets insets = self.edgeInsets; CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                                                           limitedToNumberOfLines:numberOfLines]; rect.origin.x -= insets.left;
    rect.origin.y -= insets.top;
    rect.size.width += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
    

}

- (void)drawTextInRect:(CGRect)rect{

    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
