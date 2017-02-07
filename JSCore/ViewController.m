//
//  ViewController.m
//  JSCore
//
//  Created by 锦锋 on 17/2/7.
//  Copyright © 2017年 锦锋. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JFJSExport.h"
@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *web;
@end

@implementation ViewController
- (UIWebView *)creatWeb{
    if (!_web) {
        _web = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatWeb];
    NSURL *path =[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [self.web loadRequest:[NSURLRequest requestWithURL:path]];
    self.web.delegate = self;
    [self.view addSubview:self.web];
}
#pragma mark -- webViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self jsAllocateOc];
}
#pragma mark  -- js调用oc的方法
- (void)jsAllocateOc{
    JSContext *context =[self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSLog(@"%@",context);
    JFJSExport *model = [JFJSExport new];
    model.context = context;
    model.web = self.web;
    context[@"WebViewJavascriptBridge"] = model;
    context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (IBAction)ocAllocatejs:(id)sender {
    NSLog(@"ocAllocatejs");
     JSContext *context =[self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = context[@"ocAllocatejs"];
    [value callWithArguments:nil];
}
- (IBAction)ocAllocatejsWithCallBack:(id)sender {
    NSLog(@"ocAllocatejsWithCallBack");
    JSContext *context =[self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = context[@"ocAllocatejsWithCallBack"];
    [value callWithArguments:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
