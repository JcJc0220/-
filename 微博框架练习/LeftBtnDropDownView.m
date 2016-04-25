//
//  LeftBtnDropDownView.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/3.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "LeftBtnDropDownView.h"
#import "UIView+Extension.h"
@implementation LeftBtnDropDownView




- (UIImageView *)BgImageView
{
    if (!_BgImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"popover_background_left"]];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        self.BgImageView = imageView;
    }
    return _BgImageView;
}


- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    
    // 设置灰色的高度
    self.BgImageView.height = CGRectGetMaxY(content.frame) + 11;
    // 设置灰色的宽度
    self.BgImageView.width = CGRectGetMaxX(content.frame) + 10;
    [self.BgImageView addSubview:content];
}


- (void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.BgImageView.x = CGRectGetMinX(newFrame) - 13;
    self.BgImageView.y = CGRectGetMaxY(newFrame);
//    [self.delegate dropDownMenuDidShow:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)dismiss
{
    [self removeFromSuperview];
    
//    [self.delegate dropDownMenuDidDismiss:self];
}

@end



