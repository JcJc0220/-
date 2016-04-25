//
//  WebViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/6.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "WebViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "RightBtnDropDownView.h"
#import "HomeViewController.h"
@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSError *error;
@end

@implementation WebViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *a = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItems = @[b, a];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;

}
- (void)leftBarButtonItemClick
{
    NSLog(@"返回");
    [self.webView goBack];
}
- (void)rightBarButtonItemClick
{
    NSLog(@"前进");
    [self.webView goForward];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
    NSLog(@"===%@===",error);
   
    NSString*path=[[NSBundle mainBundle]pathForResource:@"bbb" ofType:@"html"];
    NSString*htmlStr=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载网页
    [self.webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"/Users/wangshaoshuai/Desktop/07-代码/微博框架练习/微博框架练习"]];
    //以上加载我们会看到一个变形的网页，使用下面属性自动适配
    self.webView.scalesPageToFit=YES;
    
    //    NSLog(@"%@",webView.scalesPageToFit?@"YES":@"NO");

    
//    [self.webView reload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
