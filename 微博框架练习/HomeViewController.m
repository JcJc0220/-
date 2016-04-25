//
//  HomeViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "HomeViewController.h"
#import "DropDownView.h"
#import "TitleBtnContentViewController.h"
#import "LeftBtnDropDownView.h"
#import "RightBtnDropDownView.h"
#import "SliderViewController.h"
#import "MessageViewController.h"
#import "WebViewController.h"
@interface HomeViewController() <DropDownViewDelegate,TitleBtnContentViewControllerDelegate>

@property (nonatomic, strong) UIButton *titleBtn;


@end
@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.rowHeight = 200;
//       self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBarButtonItemClick) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarButtonItemClick) image:@"navigationbar_pop"highImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.height = 30;
    titleBtn.width = 150;
//    titleBtn.backgroundColor = [UIColor redColor];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleBtn.titleLabel.font = [UIFont italicSystemFontOfSize:60];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"]  forState:UIControlStateSelected];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 85, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
//    titleBtn.enabled = YES;
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(titleBtnClick)forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = titleBtn;
  
    
    
    
}

- (void)pushWebView:(TitleBtnContentViewController *)titleBtnContent
{
     WebViewController *webView = [[WebViewController alloc] init];
    NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void)titleBtnClick
{
    
//    self.titleBtn.selected = !self.titleBtn.selected;
//    //输出bool值得方法
//    NSLog(@"%@",self.titleBtn.selected?@"YES":@"NO");
   
    DropDownView *menu = [[DropDownView alloc] init];
    menu.delegate = self;
    
    TitleBtnContentViewController *vc = [[TitleBtnContentViewController alloc] init];
    vc.view.width = 150;
    vc.view.height = 150;
    menu.contentController = vc;
    [menu showFrom:self.titleBtn];
}


- (void)dropDownMenuDidShow:(DropDownView *)menu
{
    self.titleBtn.selected = YES;
}

- (void)dropDownMenuDidDismiss:(DropDownView *)menu
{
    self.titleBtn.selected = NO;
}

- (void)leftBarButtonItemClick
{
    LeftBtnDropDownView *menu = [[LeftBtnDropDownView alloc] init];
//    menu.delegate = self;
    
    TitleBtnContentViewController *vc = [[TitleBtnContentViewController alloc] init];
    
    vc.view.width = 150;
    vc.view.height = 150;
    menu.contentController = vc;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20 , 30, 27, 27)];
    
    [menu showFrom:view];
    
    NSLog(@"leftBarButtonItemClick");
}

- (void)rightBarButtonItemClick
{
    RightBtnDropDownView *menu = [[RightBtnDropDownView alloc] init];
    //    menu.delegate = self;
    
    TitleBtnContentViewController *vc = [[TitleBtnContentViewController alloc] init];
    vc.delegate = self;
    vc.view.width = 150;
    vc.view.height = 150;
    menu.contentController = vc;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 47 , 30, 27, 27)];
    
    [menu showFrom:view];
    NSLog(@"rightBarButtonItemClick");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        WebViewController *webView = [[WebViewController alloc] init];
//        [self.navigationController pushViewController:webView animated:YES];
//    }
    
    NSLog(@"点击了首页第%ld行",indexPath.row);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    cell.textLabel.numberOfLines = 0;
    
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"百度";
//    }else{
//        cell.textLabel.text = [NSString stringWithFormat:@"首页-%ld", indexPath.row];
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"首页-%ld", indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
