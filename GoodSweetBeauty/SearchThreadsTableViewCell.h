//
//  SearchThreadsTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/15.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnSearchThreadsModel.h"
@interface SearchThreadsTableViewCell : UITableViewCell


//需要变颜色的文字 keyword
-(void)SetThreadsModel:(ThreadsResults *)model withrow:(NSInteger )row withkeyword:(NSString *)keyword;

@end
