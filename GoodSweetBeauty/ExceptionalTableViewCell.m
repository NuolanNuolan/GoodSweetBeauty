//
//  ExceptionalTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/18.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "ExceptionalTableViewCell.h"
@interface ExceptionalTableViewCell(){

    //排名image
    UIImageView *image_ranking;
    //
    UILabel *lab_rangking;
    //头像
    UIImageView *image_head;
    //name
    UILabel *lab_username;
    //coins
    UILabel *lab_conis;
}
@end
@implementation ExceptionalTableViewCell

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

    image_ranking = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgNumCheng"]];
    
    lab_rangking = [UILabel new];
    [lab_rangking setFont:[UIFont systemFontOfSize:11]];
    [lab_rangking setTextColor:[UIColor whiteColor]];
    [lab_rangking sizeToFit];
    
    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    image_head.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(User_Daeatil:)];
    [image_head addGestureRecognizer:tap];
    
    lab_username = [UILabel new];
    [lab_username setFont:[UIFont boldSystemFontOfSize:15]];
    [lab_username setTextColor:GETFONTCOLOR];
    [lab_username setTextAlignment:NSTextAlignmentLeft];
    lab_username.numberOfLines = 1;
    lab_username.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap_name = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(User_Daeatil:)];
    [lab_username addGestureRecognizer:tap_name];
    [lab_username sizeToFit];
    
    lab_conis = [UILabel new];
    [lab_conis setTextAlignment:NSTextAlignmentRight];
    [lab_conis setFont:[UIFont systemFontOfSize:14]];
    [lab_conis setTextColor:GETFONTCOLOR];
    [lab_conis sizeToFit];
    
    
    [image_ranking addSubview:lab_rangking];
    [self.contentView addSubview:image_ranking];
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:lab_conis];
    
    
    lab_rangking.whc_CenterX(0).whc_CenterY(0);
    image_ranking.whc_Size(15,17).whc_CenterY(0).whc_LeftSpace(15);
    image_head.whc_Size(28,28).whc_CenterY(0).whc_LeftSpaceToView(10,image_ranking);
    lab_username.whc_CenterY(0).whc_LeftSpaceToView(6,image_head);
    lab_conis.whc_RightSpace(15).whc_CenterY(0);
    
}
-(void)SetRewardsModel:(Rewards *)model withrow:(NSInteger )row{

    if (model) {
        if (row==0||row==1||row==2) {
            
            image_ranking.hidden =NO;
            [lab_rangking setText:[NSString stringWithFormat:@"%ld",(long)row+1]];
            
        }else{
        
            image_ranking.hidden =YES;
            
        }
        image_head.tag = model.uid;
        lab_username.tag  = model.uid;
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.profile.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        [lab_username setText:model.uname];
        [lab_conis setText:[NSString stringWithFormat:@"%ld有安币",(long)model.coins]];
        
        
    }
}



/**
 跳转user详情
 */
-(void)User_Daeatil:(UITapGestureRecognizer *)tap{

    MYLOG(@"hehhe")
    if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"UserDeatil",
                                                             @"value":[NSNumber numberWithInteger:tap.view.tag]}];
    
}
@end
