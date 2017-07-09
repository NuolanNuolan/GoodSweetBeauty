//
//  MyPost_OneTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyPost_OneTableViewCell.h"
@interface MyPost_OneTableViewCell(){

    //天
    UILabel *lab_day;
    //月
    UILabel *lab_month;
    //title
    UILabel *lab_title;
    //detail
    UILabel *lab_detail;
    //阅读回复
    UILabel *lab_read_back;
    
    
}
@end


@implementation MyPost_OneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        lab_day = [UILabel new];
        [lab_day setTextColor:RGB(51, 51, 51)];
        [lab_day setFont:[UIFont systemFontOfSize:17]];
        [lab_day sizeToFit];
        
        lab_month = [UILabel new];
        [lab_month setTextColor:RGB(136, 136, 136)];
        [lab_month setFont:[UIFont systemFontOfSize:12]];
        [lab_month sizeToFit];
        
        lab_title = [UILabel new];
        [lab_title setFont:[UIFont systemFontOfSize:17]];
        [lab_title setTextColor:RGB(51, 51, 51)];
        lab_title.numberOfLines = 2;
        [lab_title sizeToFit];
        
        lab_detail = [UILabel new];
        [lab_detail setTextColor:RGB(136, 136, 136)];
        [lab_detail setFont:[UIFont systemFontOfSize:14]];
        lab_detail.numberOfLines = 2;
        [lab_detail sizeToFit];
        
        lab_read_back = [UILabel new];
        [lab_read_back setTextColor:RGB(153, 153, 153)];
        [lab_read_back setFont:[UIFont systemFontOfSize:11]];
        [lab_read_back sizeToFit];
        
        UIView *view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 299);
        
        [self.contentView addSubview:lab_read_back];
        [self.contentView addSubview:lab_detail];
        [self.contentView addSubview:lab_title];
        [self.contentView addSubview:lab_month];
        [self.contentView addSubview:lab_day];
        [self.contentView addSubview:view_line];
        
        lab_day.whc_LeftSpace(15).whc_TopSpace(14.5);
        
        lab_month.whc_LeftSpaceEqualView(lab_day).whc_TopSpaceToView(9.5,lab_day);
        
        lab_title.whc_LeftSpace(56.6).whc_TopSpaceEqualView(lab_day).whc_RightSpace(15);
        
        lab_detail.whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_title).whc_RightSpaceEqualView(lab_title);
        
        lab_read_back.whc_RightSpaceEqualView(lab_detail).whc_TopSpaceToView(14,lab_detail);
        
        view_line.whc_Height(0.5).whc_RightSpace(0).whc_LeftSpaceEqualView(lab_day).whc_TopSpaceToView(15,lab_read_back);
        self.whc_TableViewWidth = self.whc_sw;
    }
    return self;
}
-(void)SetSection:(NSInteger )seciton withModel:(YouAnUserPosttingModel *)model{
    
    if (model) {
        
        lab_day.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"dd"];
        lab_month.text = [NSString stringWithFormat:@"%@月",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM"]];
        lab_title.text = [model.subject stringByReplacingEmojiCheatCodesToUnicode];
        lab_detail.text = [model.stripd_content stringByReplacingEmojiCheatCodesToUnicode];
        lab_read_back.text = [NSString stringWithFormat:@"阅读 %@  回复 %@",@"0",@"0"];
        CGSize size_title = [self sizeWithString:lab_title.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(SCREEN_WIDTH-71.6, MAXFLOAT)];
        CGSize size_deatil = [self sizeWithString:lab_detail.text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(SCREEN_WIDTH-71.6, MAXFLOAT)];
        if (size_title.height>25) {
            
            [UILabel changeLineSpaceForLabel:lab_title WithSpace:7];
        }
        if (size_deatil.height>18) {
            
            [UILabel changeLineSpaceForLabel:lab_detail WithSpace:7];
        }
        
        
    }

}
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
