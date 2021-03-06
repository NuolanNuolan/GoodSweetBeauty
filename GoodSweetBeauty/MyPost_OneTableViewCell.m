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
        [lab_day setTextColor:GETFONTCOLOR];
        [lab_day setFont:[UIFont systemFontOfSize:17]];
        [lab_day sizeToFit];
        
        lab_month = [UILabel new];
        [lab_month setTextColor:RGB(136, 136, 136)];
        [lab_month setFont:[UIFont systemFontOfSize:12]];
        [lab_month sizeToFit];
        
        lab_title = [UILabel new];
        [lab_title setFont:[UIFont systemFontOfSize:17]];
        [lab_title setTextColor:GETFONTCOLOR];
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
        lab_title.attributedText = [BWCommon textWithStatus:model.subject Atarr:nil font:[UIFont systemFontOfSize:17] LineSpacing:7 textColor:GETFONTCOLOR screenPadding:SCREEN_WIDTH-71.6];
        lab_detail.attributedText = [BWCommon textWithStatus:model.stripd_content Atarr:nil font:[UIFont systemFontOfSize:14] LineSpacing:7 textColor:RGB(136, 136, 136) screenPadding:SCREEN_WIDTH-71.6];
        lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld  回复 %ld",(long)model.favors,(long)model.replies];
    }

}

@end
