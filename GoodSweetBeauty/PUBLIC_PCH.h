//
//  PUBLIC_PCH.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/15.
//  Copyright © 2017年 YLL. All rights reserved.
//

#ifndef PUBLIC_PCH_h
#define PUBLIC_PCH_h

//Model
#import "YouAnUserModel.h"
#import "YouAnBBSModel.h"
#import "YouAnBBSDeatilModel.h"
#import "YouAnMessageModel.h"
#import "YouAnBusinessCardModel.h"

#import<QuartzCore/QuartzCore.h>
#import "LPActionSheet.h"
#import "PPNetworkHelper.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"
#import "IQKeyboardManager.h"
#import "MBProgressHUD+HM.h"
#import "NSObject+WHC_Model.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "PYSearch.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "TZImagePickerController.h"
#import "PYPhotoBrowser.h"
#import "HttpEngine.h"
#import "BWCommon.h"
#import "GCDAsyncSocket.h"
#import "WHC_AutoLayout.h"
#import "HJViewController.h"
#import "MainTabbarController.h"
#import "SDCycleScrollView.h"
#import "LoginViewController.h"
#import "JYPagingView.h"
#import "ZFPlayer.h"
#import "ZHNTempStatusMan.h"
#import "YNPageScrollViewController.h"
#import "JX_GCDTimerManager.h"
#import "WHC_ModelSqlite.h"
#import "AppShareView.h"
#import <WebKit/WebKit.h>
#import "WebViewController.h"

#import "YYKit.h"
#import "MSSBrowseDefine.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UserPostingViewController.h"
#import "UIButton+Badge.h"

#import "ZFCWaveActivityIndicatorView.h"
#import "NSString+TYHEmoji.h"
#import "WBStatusComposeTextParser.h"
#import "WBStatusHelper.h"
#import "XXLinkLabel.h"
#import "UIImageView+CornerRadius.h"
#import "UIImage+MSSScale.h"


//延时执行
#define GCD_AFTER(time,Block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{Block})
//主线程
#define GCD_MAIN(Block) dispatch_async(dispatch_get_main_queue(),^{Block})
//子线程
#define GCD_GETGLOBAL_QUEUE(Block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{Block})
//判断系统版本号
#define SYSTEMVERSION [[UIDevice currentDevice] systemVersion]
#define GETAPPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
///得到沙盒路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//颜色处理
#define RGBVALUE(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(r,g,b)                  [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]
#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define CGMAKE(x,y,w,h)             CGRectMake(x, y, w, h)
#define iphone4_height 480.0f
#define iphone5_height 568.0f
#define iphone6_height 667.0f
#define iphone6p_height 736.0f
#define iphone4_width 320.0f
#define iphone5_width 320.0f
#define iphone6_width 375.0f
#define iphone6p_width 414.0f
#ifdef DEBUG
#define MYLOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define MYLOG(...);
#define LOG_METHOD;
#endif


#define KQQAPPID @"1106165573"
#define KQQKEY @"Q0xKEgeNZAAismsU"
#define KWXAPPID @"wx5dd1ae2ac598f207"
#define KWXSECRET @"9d53596d37eaa1e0635d3155e5808e42"




//私信通知key
#define NLETTERNAME @"NLETTERNAME"
//私信时间的key
#define NLETTTERTIMENAME @"NLETTTERTIMENAME"


//测试接口地址
#define ADDRESS_API @"http://121.40.52.49:8010"
//正式接口地址
//#define ADDRESS_API
//图片测试接口地址
#define ADDRESS_IMG @"http://121.40.52.49/media/"

//主色调
#define GETMAINCOLOR [UIColor colorWithRed:64/255.0f green:121/255.0f blue:186/255.0f alpha:1]
//默认字体颜色
#define GETFONTCOLOR RGB(51, 51, 51)
//弹出框默认按钮颜色
#define SheetDefaultColor [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f]







/**
 设置网络请求参数的格式:默认为二进制格式
 PPRequestSerializerJSON(JSON格式),
 PPRequestSerializerHTTP(二进制格式)
 
 设置方式 : [PPNetworkHelper setRequestSerializer:PPRequestSerializerHTTP];
 */

/**
 设置服务器响应数据格式:默认为JSON格式
 PPResponseSerializerJSON(JSON格式),
 PPResponseSerializerHTTP(二进制格式)
 
 设置方式 : [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
 */

/**
 设置请求头 : [PPNetworkHelper setValue:@"value" forHTTPHeaderField:@"header"];
 */
//    // 开启日志打印
//[PPNetworkHelper openLog];
// 获取网络缓存大小
//PPLog(@"网络缓存大小cache = %fKB",[PPNetworkCache getAllHttpCacheSize]/1024.f);
//
//// 清理缓存 [PPNetworkCache removeAllHttpCache];
//
//// 实时监测网络状态
//[self monitorNetworkStatus];
///*
// * 一次性获取当前网络状态
// 这里延时0.1s再执行是因为程序刚刚启动,可能相关的网络服务还没有初始化完成(也有可能是AFN的BUG),
// 导致此demo检测的网络状态不正确,这仅仅只是为了演示demo的功能性, 在实际使用中可直接使用一次性网络判断,不用延时
// */
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [self getCurrentNetworkStatus];
//});
// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.
#endif /* PUBLIC_PCH_h */
