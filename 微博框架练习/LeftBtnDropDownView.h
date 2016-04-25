//
//  LeftBtnDropDownView.h
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/3.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LeftBtnDropDownView;

@protocol LeftBtnDropDownViewDelegate <NSObject>

- (void)dropDownMenuDidShow:(LeftBtnDropDownView *)menu;
- (void)dropDownMenuDidDismiss:(LeftBtnDropDownView *)menu;
@end

@interface LeftBtnDropDownView : UIView

@property (nonatomic, weak) id<LeftBtnDropDownViewDelegate> delegate;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, strong) UIImageView *BgImageView;

- (void)showFrom:(UIView *)from;
- (void)dismiss;
@end

