//
//  WebViewController.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/8/10.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,copy)NSString *title_view;

@property(nonatomic,copy)NSString *url;

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@end

@implementation WebViewController
-(instancetype)initWithTitle:(NSString *)title withurl:(NSString *)url{


    self = [super init];
    if (self) {
        
        self.title_view = title;
        self.url = url;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor ]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self LoadData];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{

    self.title = self.title_view;

}
-(void)LoadData{

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
//    [request setValue:[NSString stringWithFormat:@"PHPSESSID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"SESSIONID"]] forHTTPHeaderField: @"Cookie"];
    [self.wkWebView loadRequest:request];
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"reg" ofType:@"html"];
//    if(path){
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
//            // iOS9. One year later things are OK.
//            NSURL *fileURL = [NSURL fileURLWithPath:path];
//            [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
//        }
//    }
    
}
//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

#pragma mark - 初始化wkWebView

- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        
        WKUserContentController* userContentController = [[WKUserContentController alloc] init];
        WKUserScript * cookieScript = [[WKUserScript alloc]initWithSource:[NSString stringWithFormat:@"document.cookie = 'PHPSESSID=%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"SESSIONID"]]                             injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userContentController addUserScript:cookieScript];
        
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        MYLOG(@"%f",[SYSTEMVERSION floatValue]);
        if ([SYSTEMVERSION floatValue]>=9) {
            
            _wkConfig.allowsInlineMediaPlayback = YES;
            _wkConfig.allowsPictureInPictureMediaPlayback = YES;
            
        }
        
        _wkConfig.userContentController = userContentController;
        //        [_wkConfig.userContentController addScriptMessageHandler:self name:@"Redirect"];
        
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) configuration:self.wkConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    MYLOG(@"开始加载网页");
    
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    MYLOG(@"加载完成");
    [ZFCWaveActivityIndicatorView hid:self.view];
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    MYLOG(@"加载失败");
    MYLOG(@"%@",error);
    [ZFCWaveActivityIndicatorView hid:self.view];
    
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //页面跳转URL
    [ZFCWaveActivityIndicatorView show:self.view];
    MYLOG(@"要跳转的URL-----%@",navigationAction.request.URL);
    WKNavigationActionPolicy  actionPolicy = WKNavigationActionPolicyAllow;
    // 必须这样执行，不然会崩
    decisionHandler(actionPolicy);
    
}
#pragma mark - Tool bar item action

- (void)goBackAction {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }
}

- (void)goForwardAction {
    if ([self.wkWebView canGoForward]) {
        [self.wkWebView goForward];
    }
}

- (void)refreshAction {
    [self.wkWebView reload];
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    MYLOG(@"%s", __FUNCTION__);
}


@end
