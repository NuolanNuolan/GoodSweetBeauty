//
//  PostingImageTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/27.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "PostingImageTableViewCell.h"
#import <Photos/Photos.h>
@interface PostingImageTableViewCell(){

    //图片容器
    WHC_StackView          * stack_imageview;
    //图片数组
    NSMutableArray *Arr_image;
}
@end
@implementation PostingImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        stack_imageview = [WHC_StackView new];
        stack_imageview.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:stack_imageview];
        
        stack_imageview.whc_LeftSpace(15).whc_TopSpace(15).whc_RightSpace(15).whc_HeightAuto();
        stack_imageview.whc_Column = 3;               // 最大3列
        stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
        stack_imageview.whc_HSpace = 5;                // 图片之间的空隙为4
        stack_imageview.whc_VSpace = 5;
        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
        stack_imageview.whc_Orientation = All;        // 横竖混合布局
//        self.whc_CellBottomOffset = 20;
        self.whc_TableViewWidth = self.whc_sw;
        
    }
    return self;
}
-(void)Setimage:(NSMutableArray *)arr_image{
    Arr_image = [NSMutableArray arrayWithArray:arr_image];
    [stack_imageview whc_RemoveAllSubviews];
    for (int i =0; i<arr_image.count; i++) {
        
        UIImageView * imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.backgroundColor = UIColorFromHex(0xE5E5E5);
        imageView.image = arr_image[i];
        [stack_imageview addSubview:imageView];
        UIImageView *image_delete = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_close"]];
        image_delete.userInteractionEnabled =YES;
        image_delete.tag = i;
        [imageView addSubview:image_delete];
        UITapGestureRecognizer * tapGesture_delete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture_delete:)];
        [image_delete addGestureRecognizer:tapGesture_delete];
        image_delete.whc_RightSpace(0).whc_TopSpace(0).whc_Size(20,20);
    }
    
    [stack_imageview whc_StartLayout];
    
    
}
- (void)tapImageGesture:(UITapGestureRecognizer *)tapGesture {
    
    NSDictionary *dic = @{@"imagearr":Arr_image,
                          @"imageviewarr":stack_imageview,
                          @"tag":[NSString stringWithFormat:@"%ld",tapGesture.view.tag]};
    if (self.delegateSignal) [self.delegateSignal sendNext:dic];
}
- (void)tapImageGesture_delete:(UITapGestureRecognizer *)tapGesture {
    
    [Arr_image removeObjectAtIndex:tapGesture.view.tag];
    [self Setimage:Arr_image];
    if (self.delegateSignal) [self.delegateSignal sendNext:[NSString stringWithFormat:@"%ld",tapGesture.view.tag]];
}
@end
