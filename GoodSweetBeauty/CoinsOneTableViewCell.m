//
//  CoinsOneTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CoinsOneTableViewCell.h"

@implementation CoinsOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Sign_click:(UIButton *)sender {
    
    //签到
    @weakify(self);
    [HttpEngine UserSignincomplete:^(BOOL success, id responseObject) {
        @strongify(self);
        MYLOG(@"%@",responseObject);
        if (success) {
            
            [MBProgressHUD showSuccess:responseObject[@"msg"]];
            //通知到C
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"singin"}];
            
        }else{
        
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    }];
}
@end
