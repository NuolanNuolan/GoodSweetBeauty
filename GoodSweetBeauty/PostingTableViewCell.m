//
//  PostingTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "PostingTableViewCell.h"
#import "YouAnTextLinePositionModifier.h"
@interface PostingTableViewCell()<YYTextViewDelegate>{


    
    YYTextView *textview;
    
}


@end
@implementation PostingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        textview = [YYTextView new];
        textview.delegate =self;
        textview.backgroundColor = [UIColor clearColor];
        textview.placeholderFont = [UIFont systemFontOfSize:15];
        textview.placeholderTextColor = RGB(199, 199, 199);
        textview.backgroundColor = [UIColor clearColor];
        textview.textColor = RGB(51, 51, 51);
        textview.font = [UIFont systemFontOfSize:14];
        textview.showsVerticalScrollIndicator =NO;
        textview.textContainerInset = UIEdgeInsetsMake(15, 15, 12, 15);
//        textview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        textview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        YouAnTextLinePositionModifier *modifier = [YouAnTextLinePositionModifier new];
        modifier.font = [UIFont fontWithName:@"PingFang SC" size:14];
        modifier.paddingTop = 12;
        modifier.paddingBottom = 12;
        modifier.lineHeightMultiple = 1.4;
        textview.linePositionModifier = modifier;
        [self.contentView addSubview:textview];
        
        textview.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
        
        
    }
    return self;
}
- (void)textViewDidChange:(YYTextView *)textView{

    if (self.delegateSignal) [self.delegateSignal sendNext:textview.text];
}
-(void)settype:(YouAnStatusComposeViewType )type{

    switch (type) {
        case YouAnStatusComposeViewTypePostTing:{
            
            textview.placeholderText = @"讨论正文";
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            textview.placeholderText = @"写评论";
            [textview becomeFirstResponder];
            
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            
        }
            break;
    }
}
@end
