//
//  BBSimageDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/1.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSimageDeatilTableViewCell.h"
@interface BBSimageDeatilTableViewCell(){

//    WHC_StackView  * stack_imageview;
    //查看更多图片
//    UIButton *btn_ToMore;
    //model
    YouAnBBSDeatilModel *Detailmodel;
    //图片URL数组
    NSMutableArray <Images*> * Arr_image;
    //图片数组参数
    Images *images_model;
    
    
    
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

//    stack_imageview = [WHC_StackView new];
    
//    btn_ToMore = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_ToMore setTitle:@"查看更多图片" forState:UIControlStateNormal];
//    [btn_ToMore setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
//    [btn_ToMore addTarget:self action:@selector(OnPicture) forControlEvents:UIControlEventTouchUpInside];
//    btn_ToMore.titleLabel.font = [UIFont systemFontOfSize:14];
    
//    [self.contentView addSubview:stack_imageview];
//    [self.contentView addSubview:btn_ToMore];
    
//    stack_imageview.whc_TopSpace(30).whc_LeftSpace(15).whc_RightSpace(15).whc_HeightAuto();
//    btn_ToMore.whc_TopSpaceToView(18,stack_imageview).whc_Size(100,14).whc_CenterX(0);
    
//    stack_imageview.whc_Column = 1;
//    stack_imageview.whc_Edge = UIEdgeInsetsZero;
//    stack_imageview.whc_VSpace = 5;
//    stack_imageview.whc_Orientation = Vertical;
    
    self.whc_TableViewWidth = self.whc_sw;
    
}
//传入是否打开展开图片
-(void)setmodel:(YouAnBBSDeatilModel *)model isopen:(BOOL)isopen{

    Detailmodel = model;
    isopen =YES;
    if (![model.master_posts.image isEqualToString:@""]||!model.master_posts.image) {
        
        if (isopen) {
            
            [self openImage];
            
        }else{
        
            
            [self closeImage];
        }
    }
}
//不展开并判断是否展示展开按钮
-(void)closeImage{
    
    //判断图片是否有多张
    if (Detailmodel.master_posts.images.count>1) {
//        btn_ToMore.whc_TopSpaceToView(18,stack_imageview).whc_Size(100,14).whc_CenterX(0);
//        btn_ToMore.hidden = NO;
        
    }else{
//        btn_ToMore.whc_TopSpaceToView(0,stack_imageview).whc_Size(0,0).whc_CenterX(0);
//        btn_ToMore.hidden =YES;
        
    }
    Arr_image = [NSMutableArray arrayWithObjects:Detailmodel.master_posts.image, nil];
    [self SetFarmeimageview:Arr_image];
}
//展开
-(void)openImage{
    
//    btn_ToMore.whc_TopSpaceToView(0,stack_imageview).whc_Size(0,0).whc_CenterX(0);
//    btn_ToMore.hidden =YES;
    //对图片地址进行处理
    Arr_image = [NSMutableArray arrayWithArray:Detailmodel.master_posts.images];
    
    [self SetFarmeimageview:Arr_image];
    
    
}

//图片布局方法
-(void)SetFarmeimageview:(NSMutableArray *)arr{

    for (int i =0; i<arr.count; i++) {
        
        images_model = arr[i];
        
        UIImageView * imageView = [UIImageView new];
        [self.contentView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.backgroundColor = UIColorFromHex(0xE5E5E5);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,images_model.image]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        //这里需要计算高度
        CGSize image_size = [self Computationssize:images_model.size];
        if (i==0) {
            
            imageView.whc_LeftSpace(15).whc_RightSpace(15).whc_TopSpace(30).whc_Height(image_size.height);
        }else{
            
            UIImageView *image_view = [self.contentView viewWithTag:i+100-1];
            
            imageView.whc_LeftSpaceEqualView(image_view).whc_RightSpaceEqualView(image_view).whc_TopSpaceToView(5,image_view).whc_Height(image_size.height);
        }
    }

}

//第一张图片放大
-(void)tapImageGesture:(UITapGestureRecognizer *)tap{

    MYLOG(@"放大");
    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    for (int i =0; i<Arr_image.count; i++) {
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = [NSString stringWithFormat:@"%@%@",ADDRESS_IMG,Arr_image[i].image];
        browseItem.smallImageView = [self.contentView viewWithTag:100+i];// 小图
        [arr_image_view addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tap.view.tag-100];
    MYLOG(@"%ld",tap.view.tag);
    bvc.isEqualRatio = YES;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];
}

/**
 展开图片
 */
-(void)OnPicture{

    MYLOG(@"展开图片");
    if(![BWCommon islogin]){
        [BWCommon PushTo_Login:[BWCommon Superview:self.contentView]];
        return;
    }
    if (self.delegateSignal) [self.delegateSignal sendNext:nil];

}
/**
 这里计算高度
 */
-(CGSize )Computationssize:(NSString *)size{

    //分割
    //判断是否存在,
    if ([BWCommon DoesItInclude:size withString:@","]) {
        
        NSArray *arr_size = [size componentsSeparatedByString:@","];
        
        return CGSizeMake(ScreenWidth-30, (ScreenWidth-30)*[arr_size[1] floatValue]/[arr_size[0] floatValue]);
    }
    return CGSizeMake(ScreenWidth-30, 166);
    
    
    
}
@end
