//
//  RightBtnDropDownView.h
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/4.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>



@class RightBtnDropDownView;

@protocol RightBtnDropDownViewDelegate <NSObject>

- (void)dropDownMenuDidShow:(RightBtnDropDownView *)menu;
- (void)dropDownMenuDidDismiss:(RightBtnDropDownView *)menu;
@end

@interface RightBtnDropDownView : UIView

@property (nonatomic, weak) id<RightBtnDropDownViewDelegate> delegate;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, strong) UIImageView *BgImageView;

- (void)showFrom:(UIView *)from;
- (void)dismiss;
@end
