//
//  HistoryCoinsTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/11.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnConisRecordModel.h"

@interface HistoryCoinsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_banlance;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;


-(void)SetModel:(YouAnConisRecordModel *)model;
@end
