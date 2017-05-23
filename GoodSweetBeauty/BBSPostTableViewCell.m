//
//  BBSPostTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/9.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "BBSPostTableViewCell.h"
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
//        stack_imageview.whc_ElementHeightWidthRatio = 166 / 345;// 图片高宽比
        lab_time.whc_LeftSpaceEqualView(image_head).whc_TopSpaceToView(20,stack_imageview);
        lab_read_back.whc_RightSpace(15).whc_TopSpaceEqualView(lab_time);
        self.whc_CellBottomOffset = 20;
        self.whc_TableViewWidth = self.whc_sw;
        
    }
    return self;
}
-(void)SetSection:(NSInteger )sention withmodel:(YouAnBBSModel *)model{

    image_head.tag = sention;
    
    lab_username.text = model.author;
    lab_deatil.text = model.subject;
    lab_read_back.text = [NSString stringWithFormat:@"阅读 %ld 回复 %ld",(long)model.hits,(long)model.replies];
    lab_time.text = [NSString stringWithFormat:@"%@",[BWCommon TheTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.created] withtype:@"MM-dd hh:mm:ss"]];
//    
//    
//    
//    
//    [stack_imageview whc_RemoveAllSubviews];
//    
//    NSArray *arr = [NSArray arrayWithObjects:@"1", nil];
//    
//    NSInteger newCount = arr.count;
//    NSInteger oldCount = stack_imageview.subviews.count;
//    NSInteger countDiff = newCount - oldCount;
//    stack_imageview.whc_ElementHeightWidthRatio = 166 / 345;// 图片高宽比
//    stack_imageview.whc_Column = 1;
//    for (int i =0; i<countDiff; i++) {
//        UIImageView * imageView = [UIImageView new];
//        imageView.userInteractionEnabled = YES;
//        imageView.tag = oldCount + i;
//        imageView.image = [UIImage imageNamed:arr[i]];
//        [stack_imageview addSubview:imageView];
//    }
//    [stack_imageview whc_StartLayout];
//    
    
    
//    
//    switch (sention) {
//        case 0:{
//            
//            image_head.image = [UIImage imageNamed:@"head"];
//            lab_username.text = @"我是用户名";
//            image_v.image = [UIImage imageNamed:@"iconVRed"];
//            image_level.image = [UIImage imageNamed:@"iconLv1"];
//            lab_deatil.text = @"3-0战胜韩国！中国乒乓球再夺冠！";
//            lab_time.text = @"04-12 15:05:51";
//            lab_read_back.text = @"阅读 12233 回复 45353";
//            [stack_imageview whc_RemoveAllSubviews];
//            
//            NSArray *arr = [NSArray arrayWithObjects:@"1", nil];
//            
//            NSInteger newCount = arr.count;
//            NSInteger oldCount = stack_imageview.subviews.count;
//            NSInteger countDiff = newCount - oldCount;
//            stack_imageview.whc_ElementHeightWidthRatio = 166 / 345;// 图片高宽比
//            stack_imageview.whc_Column = 1;
//            for (int i =0; i<countDiff; i++) {
//                UIImageView * imageView = [UIImageView new];
//                imageView.userInteractionEnabled = YES;
//                imageView.tag = oldCount + i;
//                imageView.image = [UIImage imageNamed:arr[i]];
//                [stack_imageview addSubview:imageView];
//            }
//            [stack_imageview whc_StartLayout];
//            
//        }
//            break;
//        case 1:{
//            image_head.image = [UIImage imageNamed:@"head"];
//            lab_username.text = @"我是用户名fdsfdsfsd";
//            image_v.image = [UIImage imageNamed:@"iconVRed"];
//            image_level.image = [UIImage imageNamed:@"iconLv1"];
//            lab_deatil.text = @"3-0战胜韩国！中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠！";
//            lab_time.text = @"04-12 15:05:51";
//            lab_read_back.text = @"阅读 12233 回复 45353";
//            [stack_imageview whc_RemoveAllSubviews];
//            
//            NSArray *arr = [NSArray arrayWithObjects:@"1",@"2", nil];
//            
//            NSInteger newCount = arr.count;
//            NSInteger oldCount = stack_imageview.subviews.count;
//            NSInteger countDiff = newCount - oldCount;
//            stack_imageview.whc_ElementHeightWidthRatio = 113 / 113;// 图片高宽比
//            stack_imageview.whc_Column = 2;
//            for (int i =0; i<countDiff; i++) {
//                UIImageView * imageView = [UIImageView new];
//                imageView.userInteractionEnabled = YES;
//                imageView.tag = oldCount + i;
//                imageView.image = [UIImage imageNamed:arr[i]];
//                [stack_imageview addSubview:imageView];
//            }
//            [stack_imageview whc_StartLayout];
//            
//        }
//            break;
//        case 2:{
//            
//            image_head.image = [UIImage imageNamed:@"head"];
//            lab_username.text = @"我是用户名";
//            image_v.image = [UIImage imageNamed:@"iconVRed"];
//            image_level.image = [UIImage imageNamed:@"iconLv1"];
//            lab_deatil.text = @"3-0战胜韩国！中国乒乓球再夺冠！";
//            lab_time.text = @"04-12 15:05:51";
//            lab_read_back.text = @"阅读 12233 回复 45353";
//            [stack_imageview whc_RemoveAllSubviews];
//            
//            NSArray *arr = [NSArray arrayWithObjects:@"1",@"1",@"1", nil];
//            
//            NSInteger newCount = arr.count;
//            NSInteger oldCount = stack_imageview.subviews.count;
//            NSInteger countDiff = newCount - oldCount;
//            stack_imageview.whc_ElementHeightWidthRatio = 113 / 113;// 图片高宽比
//            stack_imageview.whc_Column = 3;
//            for (int i =0; i<countDiff; i++) {
//                UIImageView * imageView = [UIImageView new];
//                imageView.userInteractionEnabled = YES;
//                imageView.tag = oldCount + i;
//                imageView.image = [UIImage imageNamed:arr[i]];
//                [stack_imageview addSubview:imageView];
//            }
//            [stack_imageview whc_StartLayout];
//            
//        }
//            break;
//        case 3:{
//            
//            image_head.image = [UIImage imageNamed:@"head"];
//            lab_username.text = @"我是用户名fdsfdsfsd";
//            image_v.image = [UIImage imageNamed:@"iconVRed"];
//            image_level.image = [UIImage imageNamed:@"iconLv1"];
//            lab_deatil.text = @"3-0战胜韩国！中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠中国乒乓球再夺冠";
//            lab_time.text = @"04-12 15:05:51";
//            lab_read_back.text = @"阅读 12233 回复 45353";
//            [stack_imageview whc_RemoveAllSubviews];
//            
//            NSArray *arr = [NSArray arrayWithObjects:@"1",@"2", nil];
//            
//            NSInteger newCount = arr.count;
//            NSInteger oldCount = stack_imageview.subviews.count;
//            NSInteger countDiff = newCount - oldCount;
//            stack_imageview.whc_ElementHeightWidthRatio = 113 / 113;// 图片高宽比
//            stack_imageview.whc_Column = 2;
//            for (int i =0; i<countDiff; i++) {
//                UIImageView * imageView = [UIImageView new];
//                imageView.userInteractionEnabled = YES;
//                imageView.tag = oldCount + i;
//                imageView.image = [UIImage imageNamed:arr[i]];
//                [stack_imageview addSubview:imageView];
//            }
//            [stack_imageview whc_StartLayout];
//        }
//            break;
//    }

    
}
-(void)userdetail:(UITapGestureRecognizer *)tap{

    MYLOG(@"%ld",tap.view.tag);
    
    if (self.delegateSignal) [self.delegateSignal sendNext:[NSString stringWithFormat:@"%ld",tap.view.tag]];
    
}
@end
