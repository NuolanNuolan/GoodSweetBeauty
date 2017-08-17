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
    XXLinkLabel *lab_mes;
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
        image_head.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userdetail:)];
        [image_head addGestureRecognizer:tap];
        
        image_bg = [UIImageView new];
        image_bg.userInteractionEnabled = YES;
        image_bg.layer.masksToBounds = YES;
        image_bg.layer.cornerRadius =17.0f;
        image_bg.backgroundColor = [UIColor whiteColor];
        
        
        lab_mes = [XXLinkLabel new];
        [lab_mes setTextColor:GETFONTCOLOR];
        [lab_mes setFont:[UIFont systemFontOfSize:16]];
        [lab_mes setNumberOfLines:0];
        [lab_mes sizeToFit];
        
        
        
        [self.contentView addSubview:image_head];
        [self.contentView addSubview:lab_time];
        [image_bg addSubview:lab_mes];
        [self.contentView addSubview:image_bg];

        if ([reuseIdentifier isEqualToString:@"mesleft"]) {
            image_bg.backgroundColor = [UIColor whiteColor];
            lab_mes.textColor = GETFONTCOLOR;
            
        }else{
            image_bg.backgroundColor = GETMAINCOLOR;
            lab_mes.textColor = [UIColor whiteColor];
            
        }
        [self RightFrame];
    }
    return self;
}
-(void)RightFrame{

    lab_time.whc_TopSpace(15).whc_CenterX(0);

    self.whc_TableViewWidth = self.whc_sw;
    
}

-(void)SetModel:(YouAnPointMessageModel *)model{

    if (model) {

        lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm"];
        
        // 首先计算文本宽度和高度
        CGRect rec = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-146, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil];
        
        if ([self.reuseIdentifier isEqualToString:@"mesleft"]) {
            
            
            [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
            image_head.tag = model.from_member_id;
            
            image_bg.frame = CGRectMake(60, 36, rec.size.width+26, rec.size.height+26);
            
            image_head.whc_Size(40,40).whc_LeftSpace(10).whc_CenterYToView(0,image_bg);
            
            
        }
        else{
            
            [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.from_member.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
            image_bg.frame = CGRectMake(SCREEN_WIDTH-60-(rec.size.width+26), 36, rec.size.width+26, rec.size.height+26);
            image_head.whc_Size(40,40).whc_RightSpace(10).whc_CenterYToView(0,image_bg);
            
            
            
            
        }
        lab_mes.frame = CGRectMake(13, 13, rec.size.width, rec.size.height);
        lab_mes.text = model.content;

    }
}
-(void)userdetail:(UITapGestureRecognizer *)tap{
    
    MYLOG(@"%ld",tap.view.tag);
    
    if (tap.view.tag!=0) {
     
        if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"UserDeatil",
                                                                 @"value":[NSNumber numberWithInteger:tap.view.tag]}];
    }
    
}
@end
