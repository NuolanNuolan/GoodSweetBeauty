//
//  BBSTitleDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSTitleDeatilTableViewCell.h"
/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end

@interface BBSTitleDeatilTableViewCell(){

    BOOL _trackingTouch;
    
    //title
    UILabel *lab_title;
    //deatil
    XXLinkLabel *lab_deatil;
    
    YYTextLayout *textLayout; //文本

    
    
}
@end

@implementation BBSTitleDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetFrame];
        
        
    }
    return self;
}
-(void)SetFrame{

    lab_title = [UILabel new];
    [lab_title setTextColor:RGB(51, 51, 51)];
    [lab_title setFont:[UIFont boldSystemFontOfSize:22]];
    lab_title.numberOfLines = 0;
    [lab_title sizeToFit];
    
    lab_deatil = [XXLinkLabel new];
    lab_deatil.linkTextColor = GETMAINCOLOR;
    lab_deatil.regularType = XXLinkLabelRegularTypeAboat;
    lab_deatil.selectedBackgroudColor = UIColorHex(bfdffe);
    lab_deatil.numberOfLines = 0;
    [lab_deatil sizeToFit];
    
    [self.contentView addSubview:lab_title];
    [self.contentView addSubview:lab_deatil];
    
    lab_title.whc_LeftSpace(15).whc_RightSpace(15).whc_TopSpace(20).whc_HeightAuto();
    lab_deatil.whc_LeftSpaceEqualView(lab_title).whc_RightSpaceEqualView(lab_title).whc_TopSpaceToView(20,lab_title).whc_HeightAuto();
    self.whc_TableViewWidth = self.whc_sw;
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    if (model) {
        
//        lab_title.text = [model.master_posts.subject stringByReplacingEmojiCheatCodesToUnicode];
        
        lab_title.attributedText = [BWCommon textWithStatus:model.master_posts.subject Atarr:nil font:[UIFont boldSystemFontOfSize:22] LineSpacing:11 textColor:GETFONTCOLOR];
        
        
        NSMutableAttributedString *text  = [BWCommon textWithStatus:model.master_posts.stripd_content Atarr:model.master_posts.ats font:[UIFont systemFontOfSize:18] LineSpacing:11 textColor:GETFONTCOLOR];
        lab_deatil.attributedText = text;
        lab_deatil.regularLinkClickBlock = ^(NSString *clickedString) {
        
                MYLOG(@"----block点击了文字----\n%@",clickedString);
            };
    }
}



@end
