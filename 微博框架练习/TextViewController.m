//
//  TextViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/2.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "TextViewController.h"
#import "MeViewController.h"
#import "RealReachability.h"
@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    
    if (status == RealStatusNotReachable)
    {
        self.flagLabel.text = @"无网络连接!";
        self.flagLabel.textColor = [UIColor redColor];
    }
    
    if (status == RealStatusViaWiFi)
    {
        self.flagLabel.text = @"已连接WiFi!";
        self.flagLabel.textColor = [UIColor greenColor];
    }
    
    if (status == RealStatusViaWWAN)
    {
        self.flagLabel.text = @"已连接无线广域网路!请谨慎使用流量!";
        self.flagLabel.textColor = [UIColor orangeColor];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)testAction:(id)sender
{
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络状态" message:@"无网络连接!"  preferredStyle: UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                    NSLog(@"确定");
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
               
                break;
            }
                
            case RealStatusViaWiFi:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络状态" message:@"已连接WiFi!"   preferredStyle: UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                    NSLog(@"确定");
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
               
                break;
            }
                
            case RealStatusViaWWAN:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络状态" message:@"已连接无线广域网路!请谨慎使用流量!" preferredStyle: UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                    NSLog(@"确定");
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
                WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
                if (accessType == WWANType2G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus2G";
                }
                else if (accessType == WWANType3G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus3G";
                }
                else if (accessType == WWANType4G)
                {
                    self.flagLabel.text = @"RealReachabilityStatus4G";
                }
                else
                {
                    self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
                }
                
                break;
            }
                
            default:
                break;
        }
    }];
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable)
    {
        self.flagLabel.text = @"无网络连接!";
        self.flagLabel.textColor = [UIColor redColor];
    }
    
    if (status == RealStatusViaWiFi)
    {
        self.flagLabel.text = @"已连接WiFi!";
        self.flagLabel.textColor = [UIColor greenColor];
    }
    
    if (status == RealStatusViaWWAN)
    {
        self.flagLabel.text = @"已连接无线广域网路!请谨慎使用流量!";
        self.flagLabel.textColor = [UIColor orangeColor];
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
            self.flagLabel.text = @"RealReachabilityStatus2G";
            self.flagLabel.textColor = [UIColor orangeColor];
        }
        else if (accessType == WWANType3G)
        {
            self.flagLabel.text = @"RealReachabilityStatus3G";
            self.flagLabel.textColor = [UIColor orangeColor];
        }
        else if (accessType == WWANType4G)
        {
            self.flagLabel.text = @"RealReachabilityStatus4G";
            self.flagLabel.textColor = [UIColor orangeColor];
        }
        else
        {
            self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
        }
    }
    
    
}

- (void)touchUpInside
{
//    self.view.backgroundColor = [UIColor redColor];
    [self dismissViewControllerAnimated:YES completion:nil];
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
