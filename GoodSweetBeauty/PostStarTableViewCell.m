//
//  PostStarTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/7/30.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "PostStarTableViewCell.h"
#import "XHStarRateView.h"

@interface PostStarTableViewCell()<XHStarRateViewDelegate>{

    UILabel *lab_title_quality ;
    XHStarRateView *starview_quality;
    UILabel *lab_results_quality;
    
    UILabel *lab_title_service ;
    XHStarRateView *starview_service;
    UILabel *lab_results_service;
    
    
}
@property(nonatomic,copy)NSArray * arr_score;
@end

@implementation PostStarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self InitFrame];
        [self layout];
    }
    return self;
}
-(void)InitFrame{

    lab_title_quality = [UILabel new];
    [lab_title_quality setFont:[UIFont systemFontOfSize:14]];
    [lab_title_quality setText:@"质量"];
    [lab_title_quality setTextColor:GETFONTCOLOR];
    [lab_title_quality sizeToFit];
    
    starview_quality = [[XHStarRateView alloc]initWithFrame:CGMAKE((ScreenWidth/2)-85, 20, 170, 17)];
    starview_quality.isAnimation = YES;
    starview_quality.rateStyle = WholeStar;
    starview_quality.tag = 1;
    starview_quality.delegate = self;
    
    lab_results_quality = [UILabel new];
    [lab_results_quality setFont:[UIFont systemFontOfSize:12]];
    [lab_results_quality setTextColor:RGB(153, 153, 153)];
    [lab_results_quality sizeToFit];
    
    
    lab_title_service = [UILabel new];
    [lab_title_service setFont:[UIFont systemFontOfSize:14]];
    [lab_title_service setText:@"服务"];
    [lab_title_service setTextColor:GETFONTCOLOR];
    [lab_title_service sizeToFit];
    
    starview_service = [[XHStarRateView alloc]initWithFrame:CGMAKE((ScreenWidth/2)-85, 59, 170, 17)];
    starview_service.isAnimation = YES;
    starview_service.rateStyle = WholeStar;
    starview_service.tag = 2;
    starview_service.delegate = self;
    
    lab_results_service = [UILabel new];
    [lab_results_service setFont:[UIFont systemFontOfSize:12]];
    [lab_results_service setTextColor:RGB(153, 153, 153)];
    [lab_results_service sizeToFit];
    
    [self.contentView addSubview:lab_results_service];
    [self.contentView addSubview:starview_service];
    [self.contentView addSubview:starview_quality];
    [self.contentView addSubview:lab_title_service];
    [self.contentView addSubview:lab_title_quality];
    [self.contentView addSubview:lab_results_quality];
    
}
-(void)layout{

    lab_title_quality.whc_LeftSpace(15).whc_TopSpace(20);
    
    
    starview_quality.whc_Width(170).whc_Height(17).whc_CenterYToView(0,lab_title_quality).whc_LeftSpaceToView(38,lab_title_quality);
    
    lab_results_quality.whc_LeftSpaceToView(20,starview_quality).whc_CenterYToView(0,lab_title_quality);
    
    lab_title_service.whc_LeftSpaceEqualView(lab_title_quality).whc_TopSpaceToView(23.5,lab_title_quality);
    
    starview_service.whc_CenterYToView(0,lab_title_service);
    
    starview_service.whc_WidthEqualView(starview_quality).whc_HeightEqualView(starview_quality).whc_CenterYToView(0,lab_title_service).whc_LeftSpaceToView(38,lab_title_service);
    
    lab_results_service.whc_LeftSpaceToView(20,starview_service).whc_CenterYToView(0,lab_title_service);
}

-(void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    
    switch (starRateView.tag) {
        case 1:{
            
            MYLOG(@"质量评分%f",currentScore)
            
            lab_results_quality.text = [self.arr_score objectAtIndex:currentScore-1];
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"product_score":[NSString stringWithFormat:@"%f",currentScore],
                                                                    @"type":@"product_score"}];
            
        }
            
            break;
        case 2:{
            
            MYLOG(@"服务评分%f",currentScore)
            lab_results_service.text = [self.arr_score objectAtIndex:currentScore-1];
            if (self.delegateSignal) [self.delegateSignal sendNext:@{@"service_score":[NSString stringWithFormat:@"%f",currentScore],
                                                                     @"type":@"service_score"}];
        }
            
            break;
    }
}


-(NSArray *)arr_score{

    if (!_arr_score) {
        
        _arr_score = [NSArray arrayWithObjects:@"非常差",@"差",@"一般",@"好",@"非常好", nil];
    }
    return _arr_score;
}

@end
