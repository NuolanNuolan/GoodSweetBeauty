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
-(void)SetSection:(NSInteger )seciton{

    switch (seciton) {
        case 0:{
            
            lab_day.text = @"09";
            lab_month.text = @"3月";
            lab_title.text = @"关羽坐骑“赤兔马”的故事关羽坐骑“赤兔马”的故事关羽坐骑“赤兔马”的故事关羽坐骑“赤兔马”的故事关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。";
            lab_read_back.text = @"阅读 2393  回复 2323";
        }
            break;
        case 1:{
            
            lab_day.text = @"09";
            lab_month.text = @"3月";
            lab_title.text = @"领英中国推出新应用“赤兔”,它挺像一个职场版的微信";
            lab_detail.text = @"领英中国今天推出了一款面向本土市场的职场社交应用“赤兔”。赤兔有即时聊天、群聊、个sadsdsdadas";
            lab_read_back.text = @"阅读 2393  回复 2323";
        }
            break;
        case 2:{
            
            lab_day.text = @"09";
            lab_month.text = @"3月";
            lab_title.text = @"关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。领英中国今天推出了一款面向本土市场的职场社交应用“赤兔”。赤兔有即时聊天、群聊、个sadsdsdadas";
            lab_read_back.text = @"阅读 2393  回复 2323";
        }
            break;
        case 3:{
            
            lab_day.text = @"09";
            lab_month.text = @"3月";
            lab_title.text = @"关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。";
            lab_read_back.text = @"阅读 2393  回复 2323";
        }
            break;
        case 4:{
            
            lab_day.text = @"09";
            lab_month.text = @"3月";
            lab_title.text = @"关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。";
            lab_read_back.text = @"阅读 2393  回复 2323";
        }
            break;
    }
}
@end
