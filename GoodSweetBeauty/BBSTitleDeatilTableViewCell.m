//
//  BBSTitleDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSTitleDeatilTableViewCell.h"


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
    
    lab_title.numberOfLines = 0;
//    [lab_title sizeToFit];
    
    lab_deatil = [XXLinkLabel new];
    lab_deatil.linkTextColor = GETMAINCOLOR;
    lab_deatil.regularType = XXLinkLabelRegularTypeAboat;
    lab_deatil.selectedBackgroudColor = [UIColor whiteColor];
    lab_deatil.numberOfLines = 0;
//    [lab_deatil sizeToFit];
    
    [self.contentView addSubview:lab_title];
    [self.contentView addSubview:lab_deatil];
    
    lab_title.whc_LeftSpace(15).whc_RightSpace(15).whc_TopSpace(20);
    lab_deatil.whc_LeftSpaceEqualView(lab_title).whc_RightSpaceEqualView(lab_title).whc_TopSpaceToView(20,lab_title);
    self.whc_TableViewWidth = self.whc_sw;
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    if (model) {
        
        lab_title.attributedText = [BWCommon textWithStatus:model.master_posts.subject Atarr:nil font:[UIFont boldSystemFontOfSize:22] LineSpacing:11 textColor:GETFONTCOLOR screenPadding:SCREEN_WIDTH-30];
        
        NSMutableAttributedString *text  = [BWCommon textWithStatus:model.master_posts.stripd_content Atarr:model.master_posts.ats font:[UIFont systemFontOfSize:18] LineSpacing:11 textColor:GETFONTCOLOR screenPadding:SCREEN_WIDTH-30];
        lab_deatil.attributedText = text;
        @weakify(self);
        lab_deatil.regularLinkClickBlock = ^(NSString *clickedString) {
            @strongify(self);
            //正则提取出来的内容 包含@和空格
            NSString *str_result =  [clickedString substringFromIndex:1];

            str_result = [str_result substringToIndex:str_result.length-1];
            
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"type":@"master",
                                                                     @"name":str_result}];
            
            };
    }
}



@end
