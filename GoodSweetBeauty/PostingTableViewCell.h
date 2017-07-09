//
//  PostingTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostingTableViewCell : UITableViewCell
//@property (nonatomic, strong) RACSubject *delegateSignal;
@property (nonatomic, strong) YYTextView *textView;

-(void)settype:(YouAnStatusComposeViewType )type;

@end
