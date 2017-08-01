//
//  BBSPostTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSPostTableViewCell.h"
#import "MSSBrowseDefine.h"

@interface BBSPostTableViewCell(){

    
    //头像
    UIImageView *image_head;
    //用户名
    UILabel *lab_username;
    //用户是否加V
    UIImageView *image_v;
    //用户等级
    UIImageView *image_level;
    //详情
    UILabel *lab_deatil;
    //图片容器
    WHC_StackView          * stack_imageview;
    //时间
    UILabel *lab_time;
    //回复数 阅读数
    UILabel *lab_read_back;
    //model
    YouAnBBSModel *model_bbs;
    //图片imagearr
    NSArray *Arr_image_main;
    
}

@end
@implementation BBSPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setLayout];
        


        
    }
    return self;
}

-(void)setLayout{

    image_head = [[UIImageView alloc]initWithRoundingRectImageView];
    
    image_head.userInteractionEnabled =YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userdetail:)];
    [image_head addGestureRecognizer:tap];
    
    lab_username = [UILabel new];
    [lab_username setTextColor:RGB(51, 51, 51)];
    [lab_username setFont:[UIFont systemFontOfSize:15]];
    [lab_username sizeToFit];
    
    image_v = [UIImageView new];
    
    image_level = [UIImageView new];
    
    lab_deatil = [UILabel new];
    [lab_deatil setTextColor:RGB(51, 51, 51)];
    [lab_deatil setFont:[UIFont systemFontOfSize:17]];
    lab_deatil.numberOfLines = 2;
    [lab_deatil sizeToFit];
    
    stack_imageview = [WHC_StackView new];
    
    lab_time = [UILabel new];
    [lab_time setTextColor:RGB(153, 153, 153)];
    [lab_time setFont:[UIFont systemFontOfSize:11]];
    [lab_time sizeToFit];
    
    lab_read_back = [UILabel new];
    [lab_read_back setTextColor:RGB(153, 153, 153)];
    [lab_read_back setFont:[UIFont systemFontOfSize:11]];
    [lab_read_back sizeToFit];
    
    
    [self.contentView addSubview:image_head];
    [self.contentView addSubview:lab_username];
    [self.contentView addSubview:image_v];
    [self.contentView addSubview:image_level];
    [self.contentView addSubview:lab_deatil];
    [self.contentView addSubview:stack_imageview];
    [self.contentView addSubview:lab_time];
    [self.contentView addSubview:lab_read_back];
    
    image_head.whc_LeftSpace(15).whc_TopSpace(10).whc_Size(40,40);
    
    lab_username.whc_LeftSpaceToView(10,image_head).whc_CenterYToView(0,image_head);
    
    image_v.whc_LeftSpaceToView(5,lab_username).whc_Size(11,9).whc_CenterYToView(0,lab_username);
    
    image_level.whc_Size(12,11).whc_CenterYToView(0,lab_username).whc_LeftSpaceToView(5,image_v);
    
    lab_deatil.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,image_head).whc_RightSpace(20);
    
    stack_imageview.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,lab_deatil).whc_RightSpace(15).whc_HeightAuto();
    stack_imageview.whc_Column = 3;               // 最大3列
    stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    stack_imageview.whc_HSpace = 3;                // 图片之间的空隙为3
    stack_imageview.whc_Orientation = Horizontal;        // 横竖混合布局
    stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;// 图片高宽比
    
    lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(20,stack_imageview);
    lab_read_back.whc_RightSpace(15).whc_TopSpaceEqualView(lab_time);
    
    /// 设置cell底部间隙
    self.whc_CellBottomView = lab_time;
    self.whc_CellBottomOffset = 20;
    self.whc_TableViewWidth = self.whc_sw;
    
}
-(void)SetSection:(NSInteger )sention withmodel:(YouAnBBSModel *)model{

    image_head.tag = sention;
    [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.author_profile.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
    
    //判断等级
    if (model.author_profile.vip == 0) {
        image_v.whc_LeftSpaceToView(5,lab_username).whc_Size(0,0).whc_CenterYToView(0,lab_username);

    }else{

        image_v.whc_LeftSpaceToView(5,lab_username).whc_Size(11,9).whc_CenterYToView(0,lab_username);
        //这里根据判断显示哪张图片
        image_v.image = [UIImage imageNamed:@"iconVRed"];
        
    }
    if (model.author_profile.level == 0) {
        image_level.whc_Size(0,0).whc_CenterYToView(0,lab_username).whc_LeftSpaceToView(5,image_v);
        
    }else{
        
        image_level.whc_Size(12,11).whc_CenterYToView(0,lab_username).whc_LeftSpaceToView(5,image_v);
        image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.author_profile.level]];
    }
    
    lab_username.text = model.author;
    lab_deatil.attributedText = [BWCommon textWithStatus:model.subject Atarr:nil font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:RGB(51, 51, 51) screenPadding:ScreenWidth-35];
    lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];
    lab_time.text = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"]];

    NSArray * arr_image = [NSArray arrayWithArray:model.images];
    
    if (arr_image.count==0) {
        
        lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(5,stack_imageview);
        
    }
//    else if(arr_image.count==1){
//        
////        stack_imageview.whc_SubViewWidth = ScreenWidth-30;
////        stack_imageview.whc_SubViewHeight = (ScreenWidth-30)*166/345;
//        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
//        stack_imageview.whc_Column = 3;
//    }else{
//        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
//        stack_imageview.whc_Column = 3;
//    }
    
    [self resetstackwithimagearr:arr_image];
    Arr_image_main = nil;
    Arr_image_main = [NSArray arrayWithArray:arr_image];

    model_bbs = model;
    
}
-(void)resetstackwithimagearr:(NSArray *)arr_image{

    [stack_imageview whc_RemoveAllSubviews];
    NSInteger newCount = arr_image.count;
    NSInteger oldCount = stack_imageview.subviews.count;
    NSInteger countDiff = newCount - oldCount;
    
    for (int i =0; i<countDiff; i++) {
        
        UIImageView * imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = oldCount + i;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.backgroundColor = UIColorFromHex(0xE5E5E5);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,arr_image[i]]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        [stack_imageview addSubview:imageView];
        if (countDiff>3) {
            if (i==2) {
                UIView *view_mask = [UIView new];
                view_mask.backgroundColor = [UIColor colorWithRed:64/255.0f green:121/255.0f blue:186/255.0f alpha:0.9];
                UILabel *lab_count = [UILabel new];
                [lab_count setTextColor:[UIColor whiteColor]];
                [lab_count setText:[NSString stringWithFormat:@"+%lu",arr_image.count-2]];
                [lab_count setFont:[UIFont systemFontOfSize:17]];
                [lab_count sizeToFit];
                [view_mask addSubview:lab_count];
                [imageView addSubview:view_mask];
                lab_count.whc_CenterX(0).whc_CenterY(0);
                view_mask.whc_LeftSpace(0).whc_TopSpace(0).whc_RightSpace(0).whc_BottomSpace(0);
                break;
            }
        }
    }
    [stack_imageview whc_StartLayout];
    
    
}

- (void)tapImageGesture:(UITapGestureRecognizer *)tapGesture {
    
    
    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    for (int i=0; i<Arr_image_main.count; i++) {
    
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = [NSString stringWithFormat:@"%@%@",ADDRESS_IMG,Arr_image_main[i]];// 加载网络图片大图地址
        if (i<3) {

            browseItem.smallImageView = stack_imageview.subviews[i];// 小图
        }else{
        
            browseItem.smallImageView = stack_imageview.subviews[2];// 小图
        }
        [arr_image_view addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tapGesture.view.tag];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];
    
}
-(void)userdetail:(UITapGestureRecognizer *)tap{

    MYLOG(@"%ld",tap.view.tag);
    
    if (self.delegateSignal) [self.delegateSignal sendNext:[NSString stringWithFormat:@"%ld",tap.view.tag]];
    
}



-(void)SetRow:(NSInteger )row withmodel:(YouAnCollectionModel *)model{

    if (model) {
        
        image_head.tag = row;
        [image_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADDRESS_IMG,model.author_profile.avatar]] placeholderImage:[UIImage imageNamed:@"head"]];
        //判断等级以及是否关注等
        if (model.author_profile.vip == 0) {
            image_v.whc_LeftSpaceToView(5,lab_username).whc_Size(0,0).whc_CenterYToView(0,lab_username);
        }else{
            
            image_v.whc_LeftSpaceToView(5,lab_username).whc_Size(11,9).whc_CenterYToView(0,lab_username);
            //这里根据判断显示哪张图片
            image_v.image = [UIImage imageNamed:@"iconVRed"];
            
        }
        if (model.author_profile.level == 0) {
            image_level.whc_Size(0,0).whc_CenterYToView(0,lab_username).whc_LeftSpaceToView(5,image_v);
        }else{
            
            image_level.whc_Size(12,11).whc_CenterYToView(0,lab_username).whc_LeftSpaceToView(5,image_v);
            image_level.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconLv%ld",(long)model.author_profile.level]];
        }
        lab_username.text = model.author;
        lab_deatil.attributedText = [BWCommon textWithStatus:model.subject Atarr:nil font:[UIFont systemFontOfSize:17] LineSpacing:6 textColor:RGB(51, 51, 51) screenPadding:ScreenWidth-35];;
        lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];
        lab_time.text = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"]];
        //判断是否有多张
        NSArray * arr_image = [NSArray arrayWithArray:model.images];
        
        if (arr_image.count==0) {
            
            lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(5,stack_imageview);   
        }
        
        [self resetstackwithimagearr:arr_image];
        Arr_image_main = nil;
        Arr_image_main = [NSArray arrayWithArray:arr_image];
    }
}



@end
