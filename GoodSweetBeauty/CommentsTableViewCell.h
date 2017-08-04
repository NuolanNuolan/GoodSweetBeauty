//
//  CommentsTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/31.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouAnMyCommentModel.h"

@interface CommentsTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;


-(void)SetModel:(commentsresults *)resmodel withsection:(NSInteger )section;

@end
