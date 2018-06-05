//
//  SAWetChatWebViewController.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/10.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SAWetChatWebViewController.h"
#import <WebKit/WebKit.h>

@interface SAWetChatWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end


@implementation SAWetChatWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [MBManager showWaitingWithTitle:@"请稍后.."];
    // 创建WKWebView
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.clf_y = -kTopHeight;
//    self.webView.clf_height = LFscreenH-kTopHeight;
//    [self wr_setNavBarBackgroundAlpha:0];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.payResultUrl]];
    // 3.加载网页
    [self.webView loadRequest:request];
  self.navigationItem.title = @"支付";
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.payVerification();
}

/// 是否允许加载网页，也可获取js要打开的url，通过截取此url可与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    NSLog(@"urlString=%@---urlComps=%@",urlString,urlComps);
    return YES;
}
/// 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSLog(@"webViewDidStartLoad-url=%@--%@",[request URL],[request HTTPBody]);
}
/// 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBManager hideAlert];
    NSURLRequest *request = webView.request;
    NSURL *url = [request URL];
    if ([url.path isEqualToString:@"/normal.html"]) {
        NSLog(@"isEqualToString");
    }
    NSLog(@"webViewDidFinishLoad-url=%@--%@",[request URL],[request HTTPBody]);
    NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}
/// 网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSURLRequest *request = webView.request;
    NSLog(@"didFailLoadWithError-url=%@--%@",[request URL],[request HTTPBody]);
    
}
// 在收到响应开始加载后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //返回支付宝的信息字符串，alipays:// 以后的为支付信息，这个信息后台是经过 URLEncode 后的，前端需要进行解码后才能跳转支付宝支付（坑点）
    
    //https://ds.alipay.com/?from=mobilecodec&scheme=alipays://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%253A%252F%252Fqr.alipay.com%252Fbax041244dd0qf8n6ras805b%253F_s%253Dweb-other
    
    NSString *urlStr = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlStr containsString:@"alipays://"]) {
        
        NSRange range = [urlStr rangeOfString:@"alipays://"]; //截取的字符串起始位置
        NSString * resultStr = [urlStr substringFromIndex:range.location]; //截取字符串
        
        NSURL *alipayURL = [NSURL URLWithString:resultStr];
        
        [[UIApplication sharedApplication] openURL:alipayURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
            
        }];
    }
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}

@end
