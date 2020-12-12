//
//  ViewController.m
//  Test_webview
//
//  Created by 王少帅 on 2020/12/11.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkwebview;

@property (nonatomic, strong) UIButton *button1;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    [self configWebView];
    [self configButttons];
}


- (void)configWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    WKUserContentController *userContent = config.userContentController;
    
    // 注册js要调用的方法名
    [userContent addScriptMessageHandler:self name:@"JS_OCAction"];
    [userContent addScriptMessageHandler:self name:@"JS_OCActionAndMessage"];
    
    _wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.7) configuration:config];
    [self.view addSubview:_wkwebview];
    _wkwebview.UIDelegate = self;
    _wkwebview.navigationDelegate = self;
    
    // 显示html
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"OC_THML" ofType:@"html"];
    NSURL *baseUrl = [NSBundle mainBundle].bundleURL;
    [_wkwebview loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseUrl];
}


- (void)configButttons
{
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, _wkwebview.frame.size.height, self.view.frame.size.width, 40)];
    [self.view addSubview:_button1];
    [_button1 setTitle:@"oc调js" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click1
{
//    [_wkwebview evaluateJavaScript:@"transferJSAction()" completionHandler:nil]; // 无参
    
    NSString *mes = [NSString stringWithFormat:@"transferJSActionAndMessage('%@')", @"wss"];
    [_wkwebview evaluateJavaScript:mes completionHandler:nil]; // 有参
}



#pragma mark - userContentController 回调
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"JS_OCAction"]) {
        NSLog(@"收到js端的消息 方法:%@, body:%@", message.name, message.body);
    }
    else if ([message.name isEqualToString:@"JS_OCActionAndMessage"]) {
        NSLog(@"收到js端的消息 方法:%@, body:%@", message.name, message.body);
    }
}


#pragma mark - uidelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

@end
