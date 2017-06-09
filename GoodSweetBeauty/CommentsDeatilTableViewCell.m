//
//  CommentsDeatilTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/6/5.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "CommentsDeatilTableViewCell.h"
static NSString *const kMycommentsCellIdentifier = @"kMycommentsCellIdentifier";
static NSString *const kMycommentsfatherCellIdentifier = @"kMycommentsfatherCellIdentifier";

@interface CommentsDeatilTableViewCell(){

    //头像
    UIImageView *image_head;
    //username
    UILabel *lab_name;
    //时间+楼层
    UILabel *lab_time_floor;
    //举报按钮
    UIButton *btn_report;
    //点赞按钮 回复按钮
    UIButton *btn_Thumb;
    UIButton *btn_back;
    
    //内容
    UILabel *lab_deatil;
    WHC_StackView *stack_imageview;
    
    //第二种情况
    //name
    UILabel *lab_father_name;
    //deatil
    UILabel *lab_father_deatil;
    //展开
    UIButton *btn_father_open;
    //回复内容
    UILabel *lab_father_back;
    //view
    UIView *view_father_line;
    
    
    //分割线
    UIView *line;
    //图片imagearr
    NSArray *Arr_image_main;

    
    
}
@end
@implementation CommentsDeatilTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self InitFarme:reuseIdentifier];
        
    }
    return self;
}
-(void)InitFarme:(NSString *)reuseIdentifier{

    
    
    image_head = [UIImageView new];
    image_head.layer.masksToBounds = YES;
    image_head.layer.cornerRadius = 20.0f;
    image_head.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(head_click:)];
    [image_head addGestureRecognizer:tap];
    
    lab_name = [UILabel new];
    lab_name.numberOfLines = 0;
    [lab_name sizeToFit];
    [lab_name setFont:[UIFont systemFontOfSize:15]];
    [lab_name setTextColor:RGB(51, 51, 51)];
    
    lab_time_floor = [UILabel new];
    [lab_time_floor sizeToFit];
    [lab_time_floor setTextColor:RGB(153, 153, 153)];
    [lab_time_floor setFont:[UIFont systemFontOfSize:11]];
    
    btn_report = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_report setEnlargeEdgeWithTop:15 right:15 bottom:0 left:15];
    [btn_report setBackgroundImage:[UIImage imageNamed:@"iconDetailMore"] forState:UIControlStateNormal];
    
    
    btn_Thumb = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Thumb setBackgroundImage:[UIImage imageNamed:@"iconZanDef"] forState:UIControlStateNormal];
    [btn_Thumb setEnlargeEdgeWithTop:10 right:10 bottom:10 left:15];
    
    btn_Thumb.badgeValue = @"0";
    btn_Thumb.badgeBGColor   = [UIColor clearColor];
    btn_Thumb.badgeTextColor = [UIColor colorWithRed:177/255.0f green:182/255.0f blue:189/255.0f alpha:1];
    btn_Thumb.badgeFont      = [UIFont systemFontOfSize:11.0];
    btn_Thumb.badgePadding   = 6;
    btn_Thumb.badgeMinSize   = 8;
    btn_Thumb.badgeOriginX   = 12;
    btn_Thumb.badgeOriginY   = -10;
    
    btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setBackgroundImage:[UIImage imageNamed:@"iconHuifu"] forState:UIControlStateNormal];
    [btn_back setEnlargeEdgeWithTop:10 right:10 bottom:10 left:15];
    [btn_back addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([reuseIdentifier isEqualToString:kMycommentsCellIdentifier] ) {
        
        lab_deatil = [UILabel new];
        [lab_deatil sizeToFit];
        lab_deatil.numberOfLines = 0;
        [lab_deatil setFont:[UIFont systemFontOfSize:17]];
        [lab_deatil setTextColor:RGB(51, 51, 51)];
        
        //图片
        stack_imageview = [WHC_StackView new];
        stack_imageview.backgroundColor = [UIColor clearColor];
        stack_imageview.whc_Column = 3;               // 最大3列
        stack_imageview.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
        stack_imageview.whc_HSpace = 5;                // 图片之间的空隙为4
        stack_imageview.whc_VSpace = 5;
        stack_imageview.whc_ElementHeightWidthRatio = 1 / 1;
        stack_imageview.whc_Orientation = All;        // 横竖混合布局
        
        
        [self.contentView addSubview:stack_imageview];
        [self.contentView addSubview:image_head];
        [self.contentView addSubview:lab_name];
        [self.contentView addSubview:lab_time_floor];
        [self.contentView addSubview:btn_Thumb];
        [self.contentView addSubview:btn_report];
        [self.contentView addSubview:btn_back];
        [self.contentView addSubview:lab_deatil];
        
        image_head.whc_Size(40,40).whc_LeftSpace(15).whc_TopSpace(15);
        lab_name.whc_TopSpace(20.5).whc_LeftSpaceToView(10,image_head).whc_RightSpaceToView(7.5,btn_report);
        lab_time_floor.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(5.5,lab_name);
        btn_report.whc_RightSpace(15).whc_Size(4,18).whc_TopSpaceEqualView(lab_name);
        lab_deatil.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(20,lab_time_floor).whc_RightSpace(20);
        stack_imageview.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(20,lab_deatil).whc_RightSpaceEqualView(lab_deatil).whc_HeightAuto();
        
        btn_back.whc_RightSpaceEqualView(btn_report).whc_Size(19,17).whc_TopSpaceToView(20,stack_imageview);
        btn_Thumb.whc_Size(16,17).whc_RightSpaceToView(45,btn_back).whc_TopSpaceEqualView(btn_back);
        
        
        
    }else{
    
        lab_father_name = [UILabel new];
        [lab_father_name sizeToFit];
//        lab_father_name.numberOfLines = 0;
        [lab_father_name setFont:[UIFont systemFontOfSize:15]];
        [lab_father_name setTextColor:RGB(51, 51, 51)];
        
        lab_father_deatil = [UILabel new];
        [lab_father_deatil sizeToFit];
        lab_father_deatil.numberOfLines =2;
        [lab_father_deatil setFont:[UIFont systemFontOfSize:15]];
        [lab_father_deatil setTextColor:RGB(136, 136, 136)];
        
        btn_father_open = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_father_open setTitle:@"展开" forState:UIControlStateNormal];
        [btn_father_open setTitleColor:GETMAINCOLOR forState:UIControlStateNormal];
        btn_father_open.titleLabel.font = [UIFont systemFontOfSize:15];
        btn_father_open.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_father_open addTarget:self action:@selector(open_click:) forControlEvents:UIControlEventTouchUpInside];
        
        view_father_line = [UIView new];
        [view_father_line setBackgroundColor:RGB(229, 229, 229)];

        
        lab_father_back = [UILabel new];
        [lab_father_back sizeToFit];
        lab_father_back.numberOfLines = 0;
        [lab_father_back setTextColor:RGB(51, 51, 51)];
        [lab_father_back setFont:[UIFont systemFontOfSize:17]];
        
        [self.contentView addSubview:image_head];
        [self.contentView addSubview:lab_name];
        [self.contentView addSubview:lab_time_floor];
        [self.contentView addSubview:btn_Thumb];
        [self.contentView addSubview:btn_report];
        [self.contentView addSubview:btn_back];
        [self.contentView addSubview:lab_father_name];
        [self.contentView addSubview:lab_father_deatil];
        [self.contentView addSubview:btn_father_open];
        [self.contentView addSubview:view_father_line];
        [self.contentView addSubview:lab_father_back];
        
        image_head.whc_Size(40,40).whc_LeftSpace(15).whc_TopSpace(15);
        lab_name.whc_TopSpace(20.5).whc_LeftSpaceToView(10,image_head).whc_RightSpaceToView(7.5,btn_report);
        lab_time_floor.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(5.5,lab_name);
        btn_report.whc_RightSpace(15).whc_Size(4,18).whc_TopSpaceEqualView(lab_name);
        view_father_line.whc_LeftSpaceEqualView(lab_name).whc_Width(4).whc_TopSpaceToView(19,lab_time_floor).whc_BottomSpaceEqualViewOffset(btn_father_open,0);
        lab_father_name.whc_TopSpaceToView(19,lab_time_floor).whc_LeftSpaceToView(10,view_father_line).whc_RightSpace(20);
        lab_father_deatil.whc_LeftSpaceEqualView(lab_father_name).whc_TopSpaceToView(10,lab_father_name).whc_RightSpaceEqualView(lab_father_name);
        btn_father_open.whc_TopSpaceToView(10,lab_father_deatil).whc_LeftSpaceEqualView(lab_father_name).whc_Size(35,15);
        lab_father_back.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(14,btn_father_open).whc_RightSpaceEqualView(lab_father_deatil);
        btn_back.whc_RightSpaceEqualView(btn_report).whc_Size(19,17).whc_TopSpaceToView(20,lab_father_back);
        btn_Thumb.whc_Size(16,17).whc_RightSpaceToView(45,btn_back).whc_TopSpaceEqualView(btn_back);
        
    }
    
    line = [UIView new];
    [line setBackgroundColor:RGB(229, 229, 229)];
    [self.contentView addSubview:line];
    line.whc_LeftSpaceEqualView(lab_name).whc_RightSpace(0).whc_TopSpaceToView(15,btn_back).whc_Height(0.5f);
    self.whc_TableViewWidth = SCREEN_WIDTH;
}
-(void)SetAllPotsModel:(Posts *)postsmodel withisopen:(BOOL )isopen withrow:(NSInteger )row isfather:(BOOL )isfather withAllrow:(NSInteger )AllRow{

    if (postsmodel) {
        
        [image_head sd_setImageWithURL:[NSURL URLWithString:postsmodel.author_avatar] placeholderImage:[UIImage imageNamed:@"head"]];
        lab_name.text = postsmodel.author;
        lab_time_floor.text = [NSString stringWithFormat:@"第%ld楼 %@",(long)row+1,[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)                                             postsmodel.created] withtype:@"MM-dd HH:mm:ss"]];
        btn_Thumb.badgeValue = [NSString stringWithFormat:@"%ld",(long)postsmodel.likes];
        btn_back.tag = 200+row;
        if (!isfather) {
           
            lab_deatil.text = postsmodel.content;
            //如果有图片 开始图片布局
            if (postsmodel.images&&![postsmodel.images isEqualToString:@""]) {

                [self imageurl:postsmodel];
                
            }else{
            
                [stack_imageview whc_RemoveAllSubviews];
                stack_imageview.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(0,lab_deatil).whc_RightSpaceEqualView(lab_deatil).whc_Height(0);
                
            }
            CGSize size =[self sizeWithString:lab_deatil.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(SCREEN_WIDTH-85, MAXFLOAT)];
            
            if(size.height>25){
        
                [UILabel changeLineSpaceForLabel:lab_deatil WithSpace:8.5];
            }
        }else{
        
            lab_father_name.text = postsmodel.father.author;
            lab_father_deatil.text = postsmodel.father.content;
            lab_father_back.text = postsmodel.content;
            btn_father_open.tag = 200+row;
            CGSize size =[self sizeWithString:lab_father_deatil.text font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH-99, MAXFLOAT)];
            
            if (size.height<70) {
             
                btn_father_open.hidden = YES;
                btn_father_open.whc_TopSpaceToView(0,lab_father_deatil).whc_LeftSpaceEqualView(lab_father_name).whc_Size(0,0);
                if (size.height<20) {
                    
                    view_father_line.whc_LeftSpaceEqualView(lab_name).whc_Width(4).whc_TopSpaceToView(19,lab_time_floor).whc_BottomSpaceEqualViewOffset(lab_father_deatil,0);
                }else{
                
                    [UILabel changeLineSpaceForLabel:lab_father_deatil WithSpace:7.5];
                }
            }else{
            
                [UILabel changeLineSpaceForLabel:lab_father_deatil WithSpace:7.5];
                if (isopen) {
                    
                    lab_father_deatil.numberOfLines = 0 ;
                    btn_father_open.hidden = YES;
                    btn_father_open.whc_TopSpaceToView(0,lab_father_deatil).whc_LeftSpaceEqualView(lab_father_name).whc_Size(0,0);
                    view_father_line.whc_LeftSpaceEqualView(lab_name).whc_Width(4).whc_TopSpaceToView(19,lab_time_floor).whc_BottomSpaceEqualViewOffset(lab_father_deatil,0);
                    
                }else{
                
                    btn_father_open.hidden = NO;
                    btn_father_open.whc_TopSpaceToView(10,lab_father_deatil).whc_LeftSpaceEqualView(lab_father_name).whc_Size(35,15);
                    view_father_line.whc_LeftSpaceEqualView(lab_name).whc_Width(4).whc_TopSpaceToView(19,lab_time_floor).whc_BottomSpaceEqualViewOffset(btn_father_open,0);
                }
            }
            //评论父评论的内容
            CGSize size_two =[self sizeWithString:lab_father_back.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(SCREEN_WIDTH-85, MAXFLOAT)];
            if(size_two.height>25){
                
                [UILabel changeLineSpaceForLabel:lab_father_back WithSpace:8.5];
            }
        }
        if (row+1 == AllRow) {
            
            line.hidden =YES;
            
        }
    }
    
}
//图片地址解析处理
-(void)imageurl:(Posts *)postsmodel{

    //有图片
    stack_imageview.whc_LeftSpaceEqualView(lab_name).whc_TopSpaceToView(20,lab_deatil).whc_RightSpaceEqualView(lab_deatil).whc_HeightAuto();
    NSArray *arr_image;
    if ([BWCommon DoesItInclude:postsmodel.images withString:@"##"]) {
        //有多张
        arr_image = [postsmodel.images componentsSeparatedByString:@"##"];
    }else{
        //只有一张
        arr_image = [NSArray arrayWithObjects:postsmodel.image, nil];
        arr_image = [NSArray arrayWithObjects:@"http://img06.tooopen.com/images/20161022/tooopen_sy_182719487645.jpg",@"http://mpic.tiankong.com/24e/8d6/24e8d6c91347f82125e85b880fcbc92a/640.jpg@360h",@"http://mpic.tiankong.com/24e/8d6/24e8d6c91347f82125e85b880fcbc92a/640.jpg@360h",@"http://www.quanjing.com/image/2016index/wlkj1.jpg", nil];
    }
    [self resetstack:postsmodel withimagearr:arr_image];
    Arr_image_main = nil;
    Arr_image_main = [NSArray arrayWithArray:arr_image];
    
}
-(void)resetstack:(Posts *)model withimagearr:(NSArray *)arr_image{

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
    }
    [stack_imageview whc_StartLayout];

}
/**
 图片放大
 */
-(void)tapImageGesture:(UITapGestureRecognizer *)tapGesture{

    NSMutableArray *arr_image_view = [NSMutableArray arrayWithCapacity:0];
    //要遍历所有的图片URL
    for (int i=0; i<Arr_image_main.count; i++) {
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = Arr_image_main[i];// 加载网络图片大图地址
        browseItem.smallImageView = stack_imageview.subviews[i];// 小图
        [arr_image_view addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:arr_image_view currentIndex:tapGesture.view.tag];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController:nil];

}
/**
 头像点击
 */
-(void)head_click:(UITapGestureRecognizer *)tap{

    
}
/**
 回复楼层
 */
-(void)back_click:(UIButton *)btn{

    NSDictionary *dic = @{@"btn":btn,
                          @"type":@"回复楼层"};
    if (self.delegateSignal) [self.delegateSignal sendNext:dic];
    
}

/**
 
 展开
 */
-(void)open_click:(UIButton *)btn{

    
    NSDictionary *dic = @{@"btn":btn,
                          @"type":@"展开评论"};
    if (self.delegateSignal) [self.delegateSignal sendNext:dic];
}



- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
