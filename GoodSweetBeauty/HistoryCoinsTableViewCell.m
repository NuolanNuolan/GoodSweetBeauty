//
//  HistoryCoinsTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/11.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "HistoryCoinsTableViewCell.h"

@implementation HistoryCoinsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)SetModel:(YouAnConisRecordModel *)model{

    if (model) {
        
        self.lab_time.text = [BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"];
        NSString * str = @"";
        if ([model.action isEqualToString:@"post"]) {
            
            str = @"发帖";
        }else if ([model.action isEqualToString:@"reply"]){
        
            str = @"回帖";
        }else if ([model.action isEqualToString:@"share"]){
        
            str = @"分享";
        }else if ([model.action isEqualToString:@"charge"]){
        
            str = @"充值";
        }else if ([model.action isEqualToString:@"gift"]){
        
            str = @"商品兑换";
        }else if ([model.action isEqualToString:@"reward"]){
            
            str = @"打赏帖子";
        }else if ([model.action isEqualToString:@"get_reward"]){
            
            str = @"收到打赏";
        }
        self.lab_type.text = str;
        NSString * str_coins = @"";
        if (model.coins>0) {
            
            str_coins = [NSString stringWithFormat:@"+%ld",(long)model.coins];
            [self.lab_banlance setTextColor:RGB(51, 51, 51)];
            
        }else{
        
            str_coins = [NSString stringWithFormat:@"%ld",(long)model.coins];
            [self.lab_banlance setTextColor:RGB(237, 67, 67)];
        }
        self.lab_banlance.text = str_coins;
    }
    
    
    
}
@end
