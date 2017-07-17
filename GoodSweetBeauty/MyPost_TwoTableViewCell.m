//
//  MyPost_TwoTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MyPost_TwoTableViewCell.h"
@interface MyPost_TwoTableViewCell(){
    
    //title
    UILabel *lab_title;
    //deatil
//    UILabel *lab_detail;
    //时间
    UILabel *lab_time;
    //阅读回复
    UILabel *lab_read_back;
    
    
    
}
@end
@implementation MyPost_TwoTableViewCell

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
    
        
        lab_title = [UILabel new];
        [lab_title setFont:[UIFont systemFontOfSize:17]];
        [lab_title setTextColor:RGB(51, 51, 51)];
        lab_title.numberOfLines = 2;
        [lab_title sizeToFit];
        
        
        lab_read_back = [UILabel new];
        [lab_read_back setTextColor:RGB(153, 153, 153)];
        [lab_read_back setFont:[UIFont systemFontOfSize:11]];
        [lab_read_back sizeToFit];
        
        lab_time = [UILabel new];
        [lab_time setTextColor:RGB(153, 153, 153)];
        [lab_time setFont:[UIFont systemFontOfSize:11]];
        [lab_time sizeToFit];
        
        UIView *view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 299);
        
        [self.contentView addSubview:lab_read_back];

        [self.contentView addSubview:lab_title];
        [self.contentView addSubview:lab_time];
        [self.contentView addSubview:view_line];
        
        
        lab_title.whc_LeftSpace(15).whc_TopSpace(15).whc_RightSpace(15);
        
        
        lab_time.whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_title);
        
        lab_read_back.whc_RightSpaceEqualView(lab_title).whc_TopSpaceEqualView(lab_time);

        view_line.whc_Height(0.5).whc_RightSpace(0).whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_read_back);
        self.whc_TableViewWidth = self.whc_sw;
    }
    return self;
}
-(void)SetSection:(NSInteger )seciton withModel:(YouAnUserPosttingModel *)model{
    
    if (model) {
        
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        
        lab_title.text = [NSString stringWithFormat:@"Re: %@",[model.stripd_content stringByReplacingEmojiCheatCodesToUnicode]];

        lab_read_back.text = [NSString stringWithFormat:@"阅读 %@  回复 %@",@"0",@"0"];
        CGSize size_title = [self sizeWithString:lab_title.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
//        MYLOG(@"%f",size_title.height);
        if (size_title.height>25) {
            
//            [UILabel changeLineSpaceForLabel:lab_title WithSpace:7];
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
