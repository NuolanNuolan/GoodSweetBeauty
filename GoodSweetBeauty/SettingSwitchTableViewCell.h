//
//  SettingSwitchTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/7.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingSwitchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UISwitch *Switch_outlet;

- (IBAction)switch_change:(UISwitch *)sender;


@end
