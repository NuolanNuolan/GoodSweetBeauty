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

    image_head = [UIImageView new];
    image_head.layer.masksToBounds =YES;
    image_head.layer.cornerRadius = 20.0f;
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
    
    lab_deatil.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,image_head).whc_RightSpace(38);
    
    stack_imageview.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,lab_deatil).whc_RightSpace(15).whc_HeightAuto();
    stack_imageview.whc_Column = 3;               // 最大3列
    stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    stack_imageview.whc_HSpace = 3;                // 图片之间的空隙为4
    stack_imageview.whc_Orientation = Horizontal;        // 横竖混合布局
    //        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;// 图片高宽比
    lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(20,stack_imageview);
    lab_read_back.whc_RightSpace(15).whc_TopSpaceEqualView(lab_time);
    self.whc_CellBottomOffset = 20;
    self.whc_TableViewWidth = self.whc_sw;
    
}
-(void)SetSection:(NSInteger )sention withmodel:(YouAnBBSModel *)model{

    image_head.tag = sention;
    lab_username.text = model.author;
    lab_deatil.text = model.subject;
    lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];
    lab_time.text = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"]];
    if (model.image&&![model.image isEqualToString:@""]) {
        stack_imageview.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(15,lab_deatil).whc_RightSpace(15).whc_HeightAuto();
        NSArray * arr_image;
        //判断是否有多张
        if ([BWCommon DoesItInclude:model.image withString:@"##"]) {
            
            arr_image = [model.image componentsSeparatedByString:@"##"];
            
        }else{
        
            arr_image = [NSArray arrayWithObjects:model.image, nil];
            arr_image = [NSArray arrayWithObjects:@"http://img06.tooopen.com/images/20161022/tooopen_sy_182719487645.jpg",@"http://mpic.tiankong.com/24e/8d6/24e8d6c91347f82125e85b880fcbc92a/640.jpg@360h",@"http://mpic.tiankong.com/24e/8d6/24e8d6c91347f82125e85b880fcbc92a/640.jpg@360h",@"http://www.quanjing.com/image/2016index/wlkj1.jpg", nil];
        }
        if (arr_image.count==1){
        
            stack_imageview.whc_SubViewWidth = ScreenWidth-30;
            stack_imageview.whc_SubViewHeight = (ScreenWidth-30)*166/345;
            stack_imageview.whc_Column = 1;
            
        }else {
            
            stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;// 图片高宽比
            stack_imageview.whc_Column = 3;
        }
        [self resetstack:model withimagearr:arr_image];
        Arr_image_main = nil;
        Arr_image_main = [NSArray arrayWithArray:arr_image];
    }else{
    
        [stack_imageview whc_RemoveAllSubviews];
        stack_imageview.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(0,lab_deatil).whc_RightSpace(15).whc_Height(0);
    }
    model_bbs = nil;
    model_bbs = model;
    
}
-(void)resetstack:(YouAnBBSModel *)model withimagearr:(NSArray *)arr_image{

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
        [imageView sd_setImageWithURL:[NSURL URLWithString:arr_image[i]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        [stack_imageview addSubview:imageView];
        if (countDiff>3) {
            if (i==2) {
                UIView *view_mask = [UIView new];
                view_mask.backgroundColor = [UIColor colorWithRed:64/255.0f green:121/255.0f blue:186/255.0f alpha:0.9];
                UILabel *lab_count = [UILabel new];
                [lab_count setTextColor:[UIColor whiteColor]];
                [lab_count setText:[NSString stringWithFormat:@"+%lu",arr_image.count-3]];
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
        browseItem.bigImageUrl = Arr_image_main[i];// 加载网络图片大图地址
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
        lab_username.text = model.author;
        lab_deatil.text = model.subject;
        lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];
        lab_time.text = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd HH:mm:ss"]];

    }
    
}




@end
