//
//  AppShareView.m
//  Apache
//
//  Created by Eason on 17/5/11.
//  Copyright © 2017年 袁联林. All rights reserved.
//

#import "AppShareView.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import "TencentOpenAPI/QQApiInterface.h"
@interface AppShareView(){

    
}
@property(nonatomic,retain)NSMutableDictionary *dic_app_share;
//主view
@property(nonatomic,retain)UIView *view_share;
//取消按钮
@property(nonatomic,retain)UIButton *btn_cancel;
//title
@property(nonatomic,retain)UILabel *lab_title;
//app名
@property(nonatomic,retain)UILabel *lab_app_name;
//滑动view
@property(nonatomic,retain)UIScrollView *scr_view;
//分享渠道按钮
@property(nonatomic,retain)UIButton *btn_share;
@end

@implementation AppShareView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        
        self.lab_title = [UILabel new];
        [self.lab_title setText:@"分享到"];
        [self.lab_title setTextColor:RGB(153, 153, 153)];
        [self.lab_title setFont:[UIFont systemFontOfSize:14]];
        [self.lab_title sizeToFit];
        
        self.scr_view = [UIScrollView new];
        self.scr_view.showsHorizontalScrollIndicator=NO;
        self.scr_view.backgroundColor = [UIColor clearColor];
        self.scr_view.contentSize = CGSizeMake(396, 0);
        self.scr_view.bounces = YES;
        
        [self Addimage_lable];
        
        NSArray *arr_app_name = [NSArray arrayWithObjects:@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间",@"新浪微博", nil];
        
        for (int i=0; i<arr_app_name.count; i++) {
            self.btn_share = [UIButton buttonWithType:UIButtonTypeSystem];
            [self.btn_share setBackgroundImage:self.dic_app_share[@"image"][i] forState:UIControlStateNormal];
            self.btn_share.tag = 100+i;
            self.btn_share.adjustsImageWhenHighlighted = NO;
            self.btn_share.frame = CGMAKE(18+(i*15)+(60*i), 0, 60, 60);
            [self.btn_share addTarget:self action:@selector(btn_appshare:) forControlEvents:UIControlEventTouchUpInside];
            
            self.lab_app_name = [UILabel new];
            [self.lab_app_name setFont:[UIFont systemFontOfSize:13]];
            [self.lab_app_name setText:arr_app_name[i]];
            [self.lab_app_name setTextColor:self.dic_app_share[@"color"][i]];
            [self.lab_app_name sizeToFit];
            
            [self.scr_view addSubview:self.btn_share];
            [self.scr_view addSubview:self.lab_app_name];
            
            self.lab_app_name.whc_TopSpaceToView(10,self.btn_share).whc_CenterXToView(0,self.btn_share);
        }
        self.view_share = [UIView new];
        self.view_share.backgroundColor = RGB(248, 247, 248);
        self.view_share.layer.masksToBounds = YES;
        self.view_share.layer.cornerRadius = 15.0f;
        
        self.btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn_cancel setBackgroundImage:[UIImage imageNamed:@"btnCancel_appshare"] forState:UIControlStateNormal];
        [self.btn_cancel setBackgroundImage:[UIImage imageNamed:@"btnCancelHighlighted"] forState:UIControlStateHighlighted];
        [self.btn_cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view_share addSubview:self.scr_view];
        
        [self.view_share addSubview:self.lab_title];
        [self addSubview:self.view_share];
        [self addSubview:self.btn_cancel];
        
        
        self.scr_view.whc_LeftSpace(0).whc_RightSpace(0).whc_TopSpaceToView(15,self.lab_title).whc_BottomSpace(0);
        self.lab_title.whc_TopSpace(15).whc_CenterX(0);
        self.view_share.whc_LeftSpace(8).whc_RightSpace(8).whc_Height(135).whc_BottomSpace(76);
        self.btn_cancel.whc_LeftSpaceEqualView(self.view_share).whc_RightSpaceEqualView(self.view_share).whc_Height(56).whc_BottomSpace(10);
        
        
        
    }
    return  self;
}
-(void)Addimage_lable{

    self.dic_app_share = [NSMutableDictionary new];
    
    
    
    NSMutableArray *arr_image = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr_color = [NSMutableArray arrayWithCapacity:0];
    
    //微信
    if ([WXApi isWXAppInstalled]) {
        
        [arr_image addObject:[UIImage imageNamed:@"btnWechat"]];
        [arr_color addObject:RGB(153, 153, 153)];
        
        [arr_image addObject:[UIImage imageNamed:@"btnMoment"]];
        [arr_color addObject:RGB(153, 153, 153)];
        

        
    }else{
    
        [arr_image addObject:[UIImage imageNamed:@"btnWechatHighlighted"]];
        [arr_color addObject:RGB(204, 204, 204)];
        
        [arr_image addObject:[UIImage imageNamed:@"btnMomentHighlighted"]];
        [arr_color addObject:RGB(204, 204, 204)];
        

    }
    //QQ
    if ([TencentOAuth iphoneQQInstalled]) {
        
        
        [arr_image addObject:[UIImage imageNamed:@"btnQq"]];
        [arr_color addObject:RGB(153, 153, 153)];
        
        [arr_image addObject:[UIImage imageNamed:@"btnQqzone"]];
        [arr_color addObject:RGB(153, 153, 153)];
        

        
    }else{
    
        [arr_image addObject:[UIImage imageNamed:@"btnQqHighlighted"]];
        [arr_color addObject:RGB(204, 204, 204)];
        
        [arr_image addObject:[UIImage imageNamed:@"btnQqzoneHighlighted"]];
        [arr_color addObject:RGB(204, 204, 204)];
        

    }
    //微博
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"weibo://"]]) {

        [arr_image addObject:[UIImage imageNamed:@"btnWeibo"]];
        [arr_color addObject:RGB(153, 153, 153)];


        
    }else{
        
        [arr_image addObject:[UIImage imageNamed:@"btnWeiboHighlighted"]];
        [arr_color addObject:RGB(204, 204, 204)];


    }

    
    [self.dic_app_share setValue:arr_image forKey:@"image"];
    [self.dic_app_share setValue:arr_color forKey:@"color"];
    
    
    
    
}
-(void)btn_appshare:(UIButton *)sender{
    
    [self dismiss];
    switch (sender.tag) {
        case 100:{
            MYLOG(@"微信");
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"花集网——小改变，大影响";
            message.description = @"开店、接单、提现，一个APP全搞定";
            [message setThumbImage:[UIImage imageNamed:@"APPShare"]];
            WXWebpageObject *webpageobject = [WXWebpageObject object];
            webpageobject.webpageUrl = @"http://s.huaji.com/uploads/zhuanti/2017/05/appShare/";
            message.mediaObject = webpageobject;
            SendMessageToWXReq *req = [SendMessageToWXReq new];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        }
            break;
        case 101:{
            MYLOG(@"微信朋友圈");
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"花集网——小改变，大影响";
            message.description = @"开店、接单、提现，一个APP全搞定";
            [message setThumbImage:[UIImage imageNamed:@"APPShare"]];
            WXWebpageObject *webpageobject = [WXWebpageObject object];
            webpageobject.webpageUrl = @"http://s.huaji.com/uploads/zhuanti/2017/05/appShare/";
            message.mediaObject = webpageobject;
            SendMessageToWXReq *req = [SendMessageToWXReq new];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }

            
            break;
        case 102:{
            MYLOG(@"QQ");
        
            NSURL* url = [NSURL URLWithString:@"http://s.huaji.com/uploads/zhuanti/2017/05/appShare/"];
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:@"花集网——小改变，大影响" description:@"开店、接单、提现，一个APP全搞定" previewImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"APPShare"], 0.1)];
            img.shareDestType = ShareDestTypeQQ;
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
        }

            
            break;
        case 103:{
            MYLOG(@"空间");
            
            NSURL* url = [NSURL URLWithString:@"http://s.huaji.com/uploads/zhuanti/2017/05/appShare/"];
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:@"花集网——小改变，大影响" description:@"开店、接单、提现，一个APP全搞定" previewImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"APPShare"], 0.1)];
            img.shareDestType = ShareDestTypeQQ;
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
            
        }

            
            break;
        case 104:{
            MYLOG(@"微博");
        }

            
            break;
    }
}
-(void)show{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
    }];
    
}
- (void)dismiss
{
    [self removeFromSuperview];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.view_share.frame, point))
    {
        [self dismiss];
    }
}
-(void)dealloc{
    
    
    MYLOG(@"选择控件释放");
}


@end
