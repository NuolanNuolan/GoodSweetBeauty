//
//  SearchThreadsTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/15.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "SearchThreadsTableViewCell.h"
@interface SearchThreadsTableViewCell(){

    //title
    UILabel *lab_title;
    //deatilt
    UILabel *lab_deatil;
    //time
    UILabel *lab_time;
    //阅读回复
    UILabel *lab_hits_back;
}
@end

@implementation SearchThreadsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self InitFrame];
    }
    return self;
}
-(void)InitFrame{

    lab_title = [UILabel new];
    lab_title.numberOfLines = 2;
    [lab_title setTextColor:RGB(51, 51, 51)];
    [lab_title setFont:[UIFont systemFontOfSize:17]];
    [lab_title sizeToFit];
    
    lab_deatil = [UILabel new];
    lab_deatil.numberOfLines =2;
    [lab_deatil setTextColor:RGB(136, 136, 136)];
    [lab_deatil setFont:[UIFont systemFontOfSize:14]];
    [lab_deatil sizeToFit];
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_hits_back = [UILabel new];
    [lab_hits_back setTextColor:RGB(153, 153, 153)];
    [lab_hits_back setFont:[UIFont systemFontOfSize:11]];
    [lab_hits_back sizeToFit];
    
    
    [self.contentView addSubview:lab_title];
    [self.contentView addSubview:lab_deatil];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:lab_hits_back];
    
    lab_title.whc_LeftSpace(15).whc_TopSpace(15).whc_RightSpace(15);
    
    lab_deatil.whc_LeftSpaceEqualView(lab_title).whc_RightSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_title);
    lab_time.whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(14,lab_deatil);
    lab_hits_back.whc_RightSpaceEqualView(lab_title).whc_TopSpaceEqualView(lab_time);
    
    self.whc_CellBottomOffset = 14;
    self.whc_TableViewWidth = self.whc_sw;
    
}
-(void)SetThreadsModel:(ThreadsResults *)model withrow:(NSInteger )row withkeyword:(NSString *)keyword{

    if (model) {
     
        lab_title.attributedText = [BWCommon textColorWithString:model.subject Atarr:nil font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:GETFONTCOLOR screenPadding:SCREEN_WIDTH-30 ChangeColorStr:keyword Color:RGB(237, 67, 67)];
        
        lab_deatil.attributedText = [BWCommon textColorWithString:model.content Atarr:nil font:[UIFont systemFontOfSize:14] LineSpacing:5 textColor:RGB(136, 136, 136) screenPadding:SCREEN_WIDTH-30 ChangeColorStr:keyword Color:RGB(237, 67, 67)];
        
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        
        lab_hits_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];

    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
