//
//  BBSTitleDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSTitleDeatilTableViewCell.h"
@interface BBSTitleDeatilTableViewCell(){

    //title
    UILabel *lab_title;
    //deatil
    UILabel *lab_deatil;
    
    
}
@end

@implementation BBSTitleDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetFrame];
        
        
    }
    return self;
}
-(void)SetFrame{

    lab_title = [UILabel new];
    [lab_title setTextColor:RGB(51, 51, 51)];
    [lab_title setFont:[UIFont boldSystemFontOfSize:22]];
    lab_title.numberOfLines = 0;
    [lab_title sizeToFit];
    
    lab_deatil = [UILabel new];
    [lab_deatil setTextColor:RGB(51, 51, 51)];
    [lab_deatil setFont:[UIFont systemFontOfSize:18]];
    lab_deatil.numberOfLines = 0;
    
    [self.contentView addSubview:lab_title];
    [self.contentView addSubview:lab_deatil];
    
    lab_title.whc_LeftSpace(15).whc_RightSpace(15).whc_TopSpace(20).whc_HeightAuto();
    lab_deatil.whc_LeftSpaceEqualView(lab_title).whc_RightSpaceEqualView(lab_title).whc_TopSpaceToView(20,lab_title).whc_HeightAuto();
    self.whc_TableViewWidth = self.whc_sw;
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    if (model) {
        
        lab_title.text = model.subject;
        lab_deatil.text = model.content;
        
        CGSize size =[self sizeWithString:model.subject font:[UIFont boldSystemFontOfSize:22] maxSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
        CGSize sizeone =[self sizeWithString:model.content font:[UIFont boldSystemFontOfSize:22] maxSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
        if (size.height>30) {
            
            [UILabel changeLineSpaceForLabel:lab_title WithSpace:11];
        }
        if (sizeone.height>30) {
            
            [UILabel changeLineSpaceForLabel:lab_deatil WithSpace:11];
        }
    }
}
//这里做一个判断行数吧..
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
