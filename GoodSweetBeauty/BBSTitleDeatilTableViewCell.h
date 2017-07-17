//
//  BBSTitleDeatilTableViewCell.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellTextHighlightColor GETMAINCOLOR // Link 文本色

@interface BBSTitleDeatilTableViewCell : UITableViewCell


-(void)setmodel:(YouAnBBSDeatilModel *)model;


@end
/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;
@end


