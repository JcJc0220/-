//
//  TitleBtnContentViewController.h
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/3.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleBtnContentViewController;

@protocol TitleBtnContentViewControllerDelegate <NSObject>

- (void)pushWebView:(TitleBtnContentViewController *)titleBtnContent;

@end

@interface TitleBtnContentViewController : UITableViewController

@property (nonatomic, weak) id<TitleBtnContentViewControllerDelegate>delegate;

@end
