//
//  DropDownView.h
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/3.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownView;

@protocol DropDownViewDelegate <NSObject>

- (void)dropDownMenuDidShow:(DropDownView *)menu;
- (void)dropDownMenuDidDismiss:(DropDownView *)menu;
@end

@interface DropDownView : UIView

@property (nonatomic, weak) id<DropDownViewDelegate> delegate;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, strong) UIImageView *BgImageView;

- (void)showFrom:(UIView *)from;
- (void)dismiss;
@end
