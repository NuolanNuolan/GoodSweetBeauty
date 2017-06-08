//
//  BBSExceptionalTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSExceptionalTableViewCell.h"
#import "Exceptional_view.h"
@interface BBSExceptionalTableViewCell(){

    //打赏安妮
    UIButton *btn_exceptional;
    //打赏人数 金额
    UILabel *lab_count_amount;
    //打赏人头像
    WHC_StackView  * stack_imageview;
    
    
}
@end

@implementation BBSExceptionalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        btn_exceptional = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_exceptional setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_exceptional setTitle:@"打赏" forState:UIControlStateNormal];
        btn_exceptional.titleLabel.font = [UIFont systemFontOfSize:14];
        btn_exceptional.layer.masksToBounds =YES;
        btn_exceptional.layer.cornerRadius = 14.0f;
        [btn_exceptional setBackgroundColor:GETMAINCOLOR];
        [btn_exceptional addTarget:self action:@selector(exceptional_click) forControlEvents:UIControlEventTouchUpInside];
        
        lab_count_amount = [UILabel new];
        [lab_count_amount setFont:[UIFont systemFontOfSize:14]];
        [lab_count_amount setTextColor:RGB(102, 102, 102)];
        [lab_count_amount sizeToFit];
        
        stack_imageview = [WHC_StackView new];
        stack_imageview.whc_Column = 1;               // 最大3列
        stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
        stack_imageview.whc_VSpace = 5;              // 垂直间隙
        stack_imageview.whc_HSpace = -5;              // 垂直间隙
        stack_imageview.whc_Orientation = All;        // 横竖混合布局
        
        [self.contentView addSubview:btn_exceptional];
        [self.contentView addSubview:lab_count_amount];
        [self.contentView addSubview:stack_imageview];
        
        btn_exceptional.whc_TopSpace(30).whc_Size(70,28).whc_CenterX(0);
        lab_count_amount.whc_TopSpaceToView(15,btn_exceptional).whc_CenterX(0);
        stack_imageview.whc_CenterX(0).whc_WidthAuto().whc_HeightAuto().whc_TopSpaceToView(15,lab_count_amount);
        self.whc_CellBottomOffset = 27;
        self.whc_TableViewWidth = self.whc_sw;
        
        
    }
    return self;
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    if (model.rewards.count>0) {
        
        //遍历UID
        NSMutableArray *arr_uid = [NSMutableArray arrayWithCapacity:0];
        NSInteger uid_id = 0;
        NSInteger balance = 0;
        for (Rewards *rewardsmodel in model.rewards) {
            //有几个人
            if (rewardsmodel.uid !=uid_id) {
                
                uid_id =rewardsmodel.uid ;
                [arr_uid addObject:[NSString stringWithFormat:@"%ld",(long)rewardsmodel.uid]];
                
            }
            //总金额
            balance+=rewardsmodel.coins ;
            //头像
            
        }
        lab_count_amount.attributedText = [self setupAttributeString:[NSString stringWithFormat:@"%lu人打赏了%ld有安币",(unsigned long)arr_uid.count,(long)balance] highlightOneText:[NSString stringWithFormat:@"%lu",(unsigned long)arr_uid.count] highlightTwoText:[NSString stringWithFormat:@"%ld",balance] collor:GETMAINCOLOR];

        
        
    }else{
    
        
    }
}

/**
 打赏
 */
-(void)exceptional_click{

    
    Exceptional_view *view = [Exceptional_view alertViewExceptional:100 withAmount:[NSArray arrayWithObjects:@"1",@"2",@"5",@"10",@"50",@"100", nil] except_title:@"写的不错, 打赏一下" exceptionalblockclick:^(Exceptional_view *view, NSInteger Amount) {
       
        MYLOG(@"%ld",(long)Amount);
        
        
    }];
    [view show];
}
#pragma mark - 富文本部分颜色
-(NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightOneText:(NSString *)highlightText highlightTwoText:(NSString *)highlightTwoText  collor:(UIColor *)color{
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSRange hightlightTwoTextRange = [text rangeOfString:highlightTwoText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0&&hightlightTwoTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTwoTextRange];
        return attributeStr;
    }else {
        return [highlightText copy];
    }
}
@end
