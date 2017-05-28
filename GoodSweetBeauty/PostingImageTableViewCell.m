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
        
        stack_imageview = [WHC_StackView new];
        
        [self.contentView addSubview:stack_imageview];
        
        stack_imageview.whc_LeftSpace(15).whc_TopSpace(15).whc_RightSpace(15).whc_HeightAuto();
        stack_imageview.whc_Column = 4;               // 最大3列
        stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
        stack_imageview.whc_HSpace = 3;                // 图片之间的空隙为4
        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
        stack_imageview.whc_Orientation = All;        // 横竖混合布局
        self.whc_CellBottomOffset = 20;
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
        
        PHImageRequestOptions*options = [[PHImageRequestOptions alloc]init];
        options.deliveryMode=PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [[PHImageManager defaultManager]requestImageForAsset:arr_image[i] targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            imageView.image = result;
        }];
        
//        imageView.image = arr_image[i];
        [stack_imageview addSubview:imageView];
    }
    [stack_imageview whc_StartLayout];

    
}
- (void)tapImageGesture:(UITapGestureRecognizer *)tapGesture {
    
    
    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    for (int i=0; i<Arr_image.count; i++) {
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageLocalPath = Arr_image[i];
        [arr_image_view addObject:browseItem];
    }
    //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tapGesture.view.tag];
    [bvc showBrowseViewController];
}

@end
