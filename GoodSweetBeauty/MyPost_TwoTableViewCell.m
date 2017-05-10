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
    UILabel *lab_detail;
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
        
        lab_detail = [UILabel new];
        [lab_detail setTextColor:RGB(136, 136, 136)];
        [lab_detail setFont:[UIFont systemFontOfSize:14]];
        lab_detail.numberOfLines = 2;
        [lab_detail sizeToFit];
        
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
        [self.contentView addSubview:lab_detail];
        [self.contentView addSubview:lab_title];
        [self.contentView addSubview:lab_time];
        [self.contentView addSubview:view_line];
        
        
        lab_title.whc_LeftSpace(15).whc_TopSpace(15).whc_RightSpace(15);
        
        lab_detail.whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_title).whc_RightSpaceEqualView(lab_title);
        
        lab_time.whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_detail);
        
        lab_read_back.whc_RightSpaceEqualView(lab_detail).whc_TopSpaceEqualView(lab_time);

        view_line.whc_Height(0.5).whc_RightSpace(0).whc_LeftSpaceEqualView(lab_title).whc_TopSpaceToView(15,lab_read_back);
        self.whc_TableViewWidth = self.whc_sw;
    }
    return self;
}
-(void)SetSection:(NSInteger )seciton{

    switch (seciton) {
        case 0:{
            lab_title.text = @"Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事";
            [UILabel changeLineSpaceForLabel:lab_title WithSpace:7];
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。";
            [UILabel changeLineSpaceForLabel:lab_detail WithSpace:7];
            lab_time.text = @"04-16 16:34:27";
            lab_read_back.text = @"阅读 2393  回复 234";
        }
            break;
        case 1:{
            
            lab_title.text = @"Re：关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事";
            lab_time.text = @"04-16 16:34:27";
            lab_read_back.text = @"阅读 2393  回复 234";
        }

            
            break;
        case 2:{
            
            lab_title.text = @"Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。";
            lab_time.text = @"04-16 16:34:27";
            lab_read_back.text = @"阅读 2393  回复 234";
        }

            
            break;
        case 3:{
         
            lab_title.text = @"Re：关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。";
            lab_time.text = @"04-16 16:34:27";
            lab_read_back.text = @"阅读 2393  回复 234";
        }
            break;
        case 4:{
            
            lab_title.text = @"Re：关羽坐骑“赤兔马”的故事Re：关羽坐骑“赤兔马”的故事";
            lab_detail.text = @"在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。在今郑东新区白沙镇,有一个叫赤兔马的自然村,位于郑州市区东22公里。村名原叫小马庄,后改为现名。";
            lab_time.text = @"04-16 16:34:27";
            lab_read_back.text = @"阅读 2393  回复 234";
        }
            break;
    }
}
@end
