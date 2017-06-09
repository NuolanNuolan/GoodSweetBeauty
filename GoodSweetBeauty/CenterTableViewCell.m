//
//  CenterTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/6.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CenterTableViewCell.h"
@interface CenterTableViewCell(){
    //image
    UIImageView *image_main;
    //lable
    UILabel *lab_title;
    //小红点
    UIImageView *image_red_unread;
    //箭头
    UIImageView *image_arrow;
    //line
    UIView *view_line;
    //有安币数量
    UILabel *lab_count;
    
}

@end

@implementation CenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        image_main = [UIImageView new];
        
        lab_title = [UILabel new];
        [lab_title setFont: [UIFont systemFontOfSize:16]];
        [lab_title setTextColor:RGB(51, 51, 51)];
        [lab_title sizeToFit];
        
        image_red_unread = [UIImageView new];
        image_red_unread.backgroundColor = [UIColor clearColor];
        image_red_unread.layer.masksToBounds =YES;
        image_red_unread.layer.cornerRadius = 4.0f;
        
        image_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconArowRight"]];
        
        lab_count = [UILabel new];
        [lab_count setTextColor:RGB(153, 153, 153)];
        [lab_count setFont:[UIFont systemFontOfSize:14]];
        [lab_count sizeToFit];
        
        view_line = [UIView new];
        view_line.backgroundColor = RGB(229, 229, 229);
        
        [self.contentView addSubview:lab_title];
        [self.contentView addSubview:image_main];
        [self.contentView addSubview:image_red_unread];
        [self.contentView addSubview:image_arrow];
        [self.contentView addSubview:lab_count];
        [self.contentView addSubview:view_line];
        
//        image_main.whc_LeftSpace(20.5).whc_TopSpace()
        lab_title.whc_LeftSpace(50.5).whc_CenterY(0);
        image_red_unread.whc_Size(8,8).whc_LeftSpaceToView(5,lab_title).whc_TopSpace(13.5);
        image_arrow.whc_RightSpace(15).whc_Size(7,13).whc_CenterY(0);
        lab_count.whc_RightSpaceToView(10,image_arrow).whc_CenterY(0);
        view_line.whc_RightSpace(0).whc_LeftSpaceEqualView(lab_title).whc_Height(0.5).whc_BottomSpace(0.5);
    }
    return self;
}

-(void)SetSection:(NSInteger )sention withmodel:(YouAnUserModel *)model{

    switch (sention) {
        case 0:
            image_main.image = [UIImage imageNamed:@"iconMeTiezi"];
            image_main.whc_Size(16,17).whc_LeftSpace(21).whc_CenterY(0);
            lab_title.text = @"我的帖子";
            break;
        case 1:
            image_main.image = [UIImage imageNamed:@"iconMe"];
            image_main.whc_Size(17,17).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"@我的";
            if (model.at_me_count >1) {
                
                image_red_unread.backgroundColor = [UIColor redColor];
            }else{
            
                image_red_unread.backgroundColor = [UIColor clearColor];
            }
            
            
            break;
        case 2:
            image_main.image = [UIImage imageNamed:@"iconMeHuifu"];
            image_main.whc_Size(16.5,15).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"回复我的";
            if (model.new_reply) {
                
                image_red_unread.backgroundColor = [UIColor redColor];
            }else{
            
                image_red_unread.backgroundColor = [UIColor clearColor];
            }
            break;
        case 3:
            image_main.image = [UIImage imageNamed:@"iconMeEmail"];
            image_main.whc_Size(16.5,12.5).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"我的私信";
            if (model.my_message_count >1) {
                
                image_red_unread.backgroundColor = [UIColor redColor];
            }else{
            
                image_red_unread.backgroundColor = [UIColor clearColor];
            }
            break;
        case 4:
            image_main.image = [UIImage imageNamed:@"iconMeShoucang"];
            image_main.whc_Size(17,16.5).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"我的收藏";
            break;
        case 5:
            image_main.image = [UIImage imageNamed:@"iconMePingjia"];
            image_main.whc_Size(16.5,15).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"我发出的评价";
            break;
        case 6:
            image_main.image = [UIImage imageNamed:@"iconMeBi"];
            image_main.whc_Size(17,14).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"我的有安币";
            if (model) {
                
                lab_count.text = [NSString stringWithFormat:@"%ld",(long)model.coins];
            }else{
            
                [lab_count setText:@"0"];
            }
            break;
        case 7:
            image_main.image = [UIImage imageNamed:@"iconMeGuanzhu"];
            image_main.whc_Size(26,22).whc_LeftSpace(16).whc_CenterY(3);
            lab_title.text = @"我的关注";
            break;
        case 8:
            image_main.image = [UIImage imageNamed:@"iconMeFensi"];
            image_main.whc_Size(17,15.6).whc_LeftSpace(20.5).whc_CenterY(0);
            lab_title.text = @"我的粉丝";
            if (model.new_follow) image_red_unread.backgroundColor = [UIColor redColor];
            else image_red_unread.backgroundColor = [UIColor clearColor];
            
            break;
        case 9:
            image_main.image = [UIImage imageNamed:@"iconMeRenzheng"];
            image_main.whc_Size(16.5,15.3).whc_LeftSpace(20.5).whc_CenterY(0);
            view_line.hidden =YES;
            lab_title.text = @"我要认证";
            break;
    }
}


@end
