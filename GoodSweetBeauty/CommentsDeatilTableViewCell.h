//
//  CommentsDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/5.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CommentsDeatilTableViewCell : UITableViewCell
@property (nonatomic, strong) RACSubject *delegateSignal;

/**
 热门评论具体model 行数是否需要? 是否展开? 是否有father评论?
 */
-(void)SetHotPotsModel:(Posts *)postsmodel withisopen:(BOOL )isopen withrow:(NSInteger )row;
/**
 全部评论具体model 行数是否需要? 是否展开? 是否有father评论? 总行数
 */
-(void)SetAllPotsModel:(Posts *)postsmodel withisopen:(BOOL )isopen withrow:(NSInteger )row isfather:(BOOL )isfather withAllrow:(NSInteger )AllRow;

@end
