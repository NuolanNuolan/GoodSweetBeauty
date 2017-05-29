//
//  PostingImageTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostingImageTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *delegateSignal;
-(void)Setimage:(NSMutableArray *)arr_image;

@end
