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


    
//    YYTextView *textview;
    
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
        _textView = [YYTextView new];
//        _textView.delegate =self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.placeholderFont = [UIFont systemFontOfSize:15];
        _textView.placeholderTextColor = RGB(199, 199, 199);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = RGB(51, 51, 51);
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.showsVerticalScrollIndicator =NO;
        _textView.textContainerInset = UIEdgeInsetsMake(15, 15, 12, 15);
        _textView.textParser = [WBStatusComposeTextParser new];
//        textview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        YouAnTextLinePositionModifier *modifier = [YouAnTextLinePositionModifier new];
        modifier.font = [UIFont fontWithName:@"PingFang SC" size:14];
        modifier.paddingTop = 12;
        modifier.paddingBottom = 12;
        modifier.lineHeightMultiple = 1.4;
        _textView.linePositionModifier = modifier;
        [self.contentView addSubview:_textView];
        
        _textView.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
        
        
    }
    return self;
}
//- (void)textViewDidChange:(YYTextView *)textView{
//
//    if (self.delegateSignal) [self.delegateSignal sendNext:_textView.text];
//}
-(void)settype:(YouAnStatusComposeViewType )type{

    switch (type) {
        case YouAnStatusComposeViewTypePostTing:{
            
            _textView.placeholderText = @"讨论正文";
        }
            break;
        case YouAnStatusComposeViewTypeStatus:{
            
            _textView.placeholderText = @"写评论";
            [_textView becomeFirstResponder];
            
        }
            break;
        case YouAnStatusComposeViewTypeComment:{
            
            _textView.placeholderText = @"写评论";
            [_textView becomeFirstResponder];
        }
            break;
        case YouAnStatusComposeViewTypePostKouBei:{
            
            
        }
            break;
    }
}
@end
