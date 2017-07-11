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
    XXLinkLabel *lab_deatil;
    
    
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
    
    lab_deatil = [XXLinkLabel new];
    lab_deatil.linkTextColor = GETMAINCOLOR;
    lab_deatil.regularType = XXLinkLabelRegularTypeAboat;
    lab_deatil.selectedBackgroudColor = [UIColor whiteColor];
//    | XXLinkLabelRegularTypeTopic | XXLinkLabelRegularTypeUrl;
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
        
        lab_title.text = [model.master_posts.subject stringByReplacingEmojiCheatCodesToUnicode];
        
        //判断是否有@的人
//        if (model.master_posts.ats.count>0) {
            
//            NSString  * str_at = [NSString stringWithFormat:@" @%@ ",model.master_posts.ats.uname];
//            lab_deatil.text = [NSString stringWithFormat:@"%@%@",[model.master_posts.stripd_content stringByReplacingEmojiCheatCodesToUnicode],str_at];
//            lab_deatil.regularLinkClickBlock = ^(NSString *clickedString) {
////                self.showClickTextLabel.text = [NSString stringWithFormat:@"----点击了文字----\n%@",clickedString];
//                MYLOG(@"----block点击了文字----\n%@",clickedString);
//            };
            
//        }else{
        
            lab_deatil.text = [model.master_posts.stripd_content stringByReplacingEmojiCheatCodesToUnicode];
//        }
        
        
        CGSize size =[self sizeWithString:lab_title.text font:[UIFont boldSystemFontOfSize:22] maxSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
        CGSize sizeone =[self sizeWithString:lab_deatil.text font:[UIFont boldSystemFontOfSize:22] maxSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
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
