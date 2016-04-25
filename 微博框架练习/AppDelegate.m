//
//  AppDelegate.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "AppDelegate.h"
#import "TabberViewController.h"
#import "RealReachability.h"
#import "LoginViewController.h"
#import "NewFeatureViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置指示器的联网动画
//    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    
    //ios8本地推送通知，添加一个授权方法
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
  
    
    
    //ios8的模拟器有问题，推送是可以正常出现的，但是声音不能正常提示，但是如果是真机，就可以
    
//    [self localNotificationAppear:10 badgeNumberis:10 alertBody:@"有妹子找你" soundName:@"音效.caf"];
//    [self localNotificationAppear:20 badgeNumberis:20 alertBody:@"还是洋妞" soundName:@"音效.caf"];
//    [self localNotificationAppear:30 badgeNumberis:30 alertBody:@"快给老子上线" soundName:@"音效.caf"];
//    //如何删除一个推送通知
//    
//    //首先获取推送
//    NSArray*localArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
//    //遍历通知
//    for (UILocalNotification*notification in localArray) {
//        if ([notification.alertBody isEqualToString:@"亲，你该💊了，不要放弃治疗,志玲姐姐还未出嫁"]) {
//            //删除该通知
//            [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            
//        }
//    }
//    //删除全部通知
//    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    // 2.设置根控制器
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"上一次%@===当前%@",lastVersion,currentVersion);
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.window.rootViewController = [[LoginViewController alloc] init];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        self.window.rootViewController = [[NewFeatureViewController alloc] init];
        
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    NSLog(@"存储系统版本号为%@",[[NSUserDefaults standardUserDefaults] objectForKey:key]);
    [self.window makeKeyAndVisible];
    //网络判断
    [GLobalRealReachability startNotifier];
    

    return YES;
}



- (void)localNotificationAppear:(NSTimeInterval)secs badgeNumberis:(NSInteger)badgeNumber alertBody:(NSString *)alertBody soundName:(NSString *)soundName
{
    //创建一个本地推送
    UILocalNotification*local=[[UILocalNotification alloc]init];
    //设置推送内容
    local.alertBody=alertBody;
    //设置声音 这个因为需要是小于30秒并且你本地有这个声音
    local.soundName=soundName;
    //设置红色标示,显示为新的多少条通知
    local.applicationIconBadgeNumber=badgeNumber;
    //设置开始的时间
    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:secs];
    //把推送通知加入到推送队列中，需要注意是推送通知加入以后，程序被杀掉，推送通知依然可以运行
    //当程序在前台时候我的推送通知虽然不会显示，但是依然会运行
    
    //如果要弹出推送通知，需要你程序退出后台才可以显示，快捷键command+shift+h
    [[UIApplication sharedApplication] scheduleLocalNotification:local];
}

#pragma mark 本地推送通知的代理方法
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收到本地消息");
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    NSLog(@"进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //回到前台将消息数设置为0
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    NSLog(@"进入前台");

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
