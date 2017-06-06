//
//  BBSimageDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSimageDeatilTableViewCell.h"
@interface BBSimageDeatilTableViewCell(){

    WHC_StackView  * stack_imageview;
    //查看更多图片
    UIButton *btn_ToMore;
    //model
    YouAnBBSDeatilModel *Detailmodel;
    
    
}
@end

@implementation BBSimageDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
        [self SetFarme];
        
    }
    return self;
}
-(void)SetFarme{

    stack_imageview = [WHC_StackView new];
    
    btn_ToMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_ToMore setTitle:@"查看更多图片" forState:UIControlStateNormal];
    [btn_ToMore setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
    btn_ToMore.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:stack_imageview];
    [self.contentView addSubview:btn_ToMore];
    
    stack_imageview.whc_TopSpace(30).whc_LeftSpace(15).whc_RightSpace(15).whc_HeightAuto();
    btn_ToMore.whc_TopSpaceToView(18,stack_imageview).whc_Size(85,14).whc_CenterX(0);
    
    stack_imageview.whc_Column = 1;               // 最大3列
    stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    stack_imageview.whc_VSpace = 5;              // 垂直间隙
    stack_imageview.whc_Orientation = Vertical;        // 横竖混合布局
    
    self.whc_TableViewWidth = self.whc_sw;
    
}
-(void)setmodel:(YouAnBBSDeatilModel *)model{

    Detailmodel = model;
    if (![model.image isEqualToString:@""]) {
        
        if ([BWCommon DoesItInclude:model.master_posts.images withString:@"##"]) {
            btn_ToMore.whc_TopSpaceToView(18,stack_imageview).whc_Size(85,14).whc_CenterX(0);
            btn_ToMore.hidden = NO;
            
        }else{
            btn_ToMore.whc_TopSpaceToView(0,stack_imageview).whc_Size(0,0).whc_CenterX(0);
            btn_ToMore.hidden =YES;
            
        }
        UIImageView * imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.backgroundColor = UIColorFromHex(0xE5E5E5);
//        [imageView sd_setImageWithURL:[NSURL URLWithString:model.master_posts.image] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img06.tooopen.com/images/20161022/tooopen_sy_182719487645.jpg"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        stack_imageview.whc_SubViewWidth = ScreenWidth-30;
        stack_imageview.whc_SubViewHeight = (ScreenWidth-30)*166/345;
        stack_imageview.whc_Column = 1;
        [stack_imageview whc_RemoveAllSubviews];
        [stack_imageview addSubview:imageView];
        [stack_imageview whc_StartLayout];
    }
}








//第一张图片放大
-(void)tapImageGesture:(UITapGestureRecognizer *)tap{

    MYLOG(@"放大");
    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    
    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    browseItem.bigImageUrl = @"http://img06.tooopen.com/images/20161022/tooopen_sy_182719487645.jpg";// 加载网络图片大图地址
    browseItem.smallImageView = stack_imageview.subviews[0];// 小图
    [arr_image_view addObject:browseItem];
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tap.view.tag];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];
    
}

@end
