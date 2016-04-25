//
//  NewFeatureViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/17.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "UIView+Extension.h"
#import "LoginViewController.h"
#define NewfeatureCount  4
@interface NewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    for (int i = 0; i < NewfeatureCount; i++ ) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollView.width;
        imageView.height = scrollView.height;
        imageView.x = scrollView.width * i;
        imageView.y = 0;
        
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d", i + 1]];
        [scrollView addSubview:imageView];
        
        if (i == NewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollView.width, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureCount;
//    pageControl.backgroundColor = [UIColor redColor];
    pageControl.centerX = scrollView.width * 0.5;
    pageControl.centerY = scrollView.height * 0.9;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
//    pageControl.width = 100;
//    pageControl.height = 30;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = page + 0.5;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    shareBtn.width = 150;
    shareBtn.height = 40;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [imageView addSubview:shareBtn];
    
    
    UIButton *comeinBtn = [[UIButton alloc] init];
    [comeinBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [comeinBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    comeinBtn.size = comeinBtn.currentBackgroundImage.size;
    [comeinBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    comeinBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    comeinBtn.width = 200;
    comeinBtn.height = 50;
    comeinBtn.centerX = imageView.width * 0.5;
    comeinBtn.centerY = imageView.height * 0.77;
    [comeinBtn addTarget:self action:@selector(comeinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:comeinBtn];
    
    
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.selected;
}

- (void)comeinBtnClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[LoginViewController alloc] init];
}
@end
