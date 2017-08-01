//
//  MesDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "MesDeatilTableViewCell.h"
#import "MesPaddingLabel.h"



@interface MesDeatilTableViewCell(){

    UIImageView *image_head;
    UIImageView *image_bg;
    MesPaddingLabel *lab_mes;
    UILabel *lab_time;
    
    
}

@end

@implementation MesDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGB(233, 233, 233);
        //根据res的不同来决定是哪种布局
        lab_time = [UILabel new];
        [lab_time setTextColor:RGB(153, 153, 153)];
        [lab_time setFont:[UIFont systemFontOfSize:12]];
        [lab_time sizeToFit];
        
        image_head = [[UIImageView alloc]initWithRoundingRectImageView];
        
        
//        image_bg = [[UIImageView alloc]initWithCornerRadiusAdvance:17 rectCornerType:UIRectCornerAllCorners];
        image_bg = [UIImageView new];
        image_bg.layer.masksToBounds = YES;
        image_bg.layer.cornerRadius =17.0f;
        image_bg.backgroundColor = [UIColor whiteColor];
        
        
        lab_mes = [MesPaddingLabel new];
        [lab_mes setTextColor:RGB(51, 51, 51)];
        [lab_mes setFont:[UIFont systemFontOfSize:16]];
        [lab_mes setNumberOfLines:0];
        [lab_mes sizeToFit];
        
        
        
        [self.contentView addSubview:image_head];
        [self.contentView addSubview:lab_time];
        [image_bg addSubview:lab_mes];
        [self.contentView addSubview:image_bg];

        
        
        
        if ([reuseIdentifier isEqualToString:@"mesleft"]) {
            image_bg.backgroundColor = [UIColor whiteColor];
            lab_mes.textColor = RGB(51, 51, 51);
            [self LeftFrame];
            
        }else{
            image_bg.backgroundColor = GETMAINCOLOR;
            lab_mes.textColor = [UIColor whiteColor];
//            image_bg.image = [UIImage imageNamed:@"Icon_mesbgtwo"];
            [self RightFrame];
        }
    }
    return self;
}
-(void)LeftFrame{
  
    lab_time.whc_TopSpace(15).whc_CenterX(0);
    


    
    self.whc_TableViewWidth = self.whc_sw;
    
}
-(void)RightFrame{

    lab_time.whc_TopSpace(15).whc_CenterX(0);
//    image_head.whc_Size(40,40).whc_RightSpace(10);
//    
//    lab_mes.whc_LeftSpace(13).whc_TopSpace(13).whc_RightSpace(13).whc_BottomSpace(13);
//    
////    image_bg.whc_RightSpaceToView(10,image_head).whc_TopSpaceToView(10,lab_time).whc_WidthAuto().whc_HeightAuto().whc_CenterYToView(0,image_head);
//    
//    self.whc_CellBottomOffset = 10;
    self.whc_TableViewWidth = self.whc_sw;
    
}

-(void)SetModel:(YouAnPointMessageModel *)model{

    if ([self.reuseIdentifier isEqualToString:@"mesleft"]) {
        
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm"];
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        
        // 首先计算文本宽度和高度
        CGRect rec = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-96, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil];

        image_bg.frame = CGRectMake(60, 36, rec.size.width+26, rec.size.height+26);
        
        image_head.whc_Size(40,40).whc_LeftSpace(10).whc_CenterYToView(0,image_bg);
        lab_mes.frame = CGRectMake(13, 13, rec.size.width, rec.size.height);
        
        
        lab_mes.text = model.content;
        
//        lab_mes.attributedText = [BWCommon textWithStatus:model.content Atarr:nil font:[UIFont systemFontOfSize:16] LineSpacing:6 textColor:RGB(51, 51, 51) screenPadding:SCREEN_WIDTH-96];
  
    }
    else{
    
        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm"];
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        // 首先计算文本宽度和高度
        CGRect rec = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-96, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil];
        
        image_bg.frame = CGRectMake(SCREEN_WIDTH-60-(rec.size.width+26), 36, rec.size.width+26, rec.size.height+26);
        
        image_head.whc_Size(40,40).whc_RightSpace(10).whc_CenterYToView(0,image_bg);
        lab_mes.frame = CGRectMake(13, 13, rec.size.width, rec.size.height);
        
        
        lab_mes.text = model.content;
        
        
        
        
        
//        lab_mes.attributedText = [BWCommon textWithStatus:model.content Atarr:nil font:[UIFont systemFontOfSize:16] LineSpacing:6 textColor:[UIColor whiteColor] screenPadding:SCREEN_WIDTH-96];
    }
}
@end
