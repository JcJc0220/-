//
//  NavigationController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "NavigationController.h"
#import "WhiteViewController.h"
@implementation NavigationController
//重写push方法，统一加一个跳转动画
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断，如果是要展示动画的页面就不能全部设置为一样的动画效果
    if (viewController.class != [[WhiteViewController alloc] init].class) {
        //创建动画
        CATransition*ani=[CATransition animation];
        //设置动画类型
        ani.type=@"rippleEffect";
        //设置动画时间
        ani.duration=1;
        
        [self.view.layer addAnimation:ani forKey:nil];
        
        NSLog(@"水滴");
    }
    [super pushViewController:viewController animated:animated];
    
}
//pop回去的时候也设定与push一样的动画，popToViewController:(UIViewController *)viewController animated:(BOOL)animated 如果有使用这个方法也要重写
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    //创建动画
    CATransition*ani=[CATransition animation];
    //设置动画类型
    ani.type=@"rippleEffect";
    //设置动画时间
    ani.duration=1;
    [self.view.layer addAnimation:ani forKey:nil];
    return [super popViewControllerAnimated:animated];
}


@end
