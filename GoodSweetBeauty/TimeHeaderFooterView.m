//
//  TimeHeaderFooterView.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/11.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "TimeHeaderFooterView.h"
@interface TimeHeaderFooterView(){

    UILabel *lab_title;
    
}
@end

@implementation TimeHeaderFooterView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetFrame_At];
    }
    return self;
}
-(void)SetFrame_At{
    
    lab_title = [[UILabel alloc]initWithFrame:CGMAKE(15, 7.5, 80, 13.5)];
    [lab_title setTextColor:RGB(102, 102, 102)];
    [lab_title setFont:[UIFont systemFontOfSize:14]];
    self.contentView.backgroundColor = RGB(247, 247, 247);
    [self.contentView addSubview:lab_title];
    
    
    
}
-(void)Settitle:(NSString *)title{
    
    [lab_title setText:title];
}

@end
