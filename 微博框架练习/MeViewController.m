//
//  MeViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "MeViewController.h"
#import "TextViewController.h"
#import "SetUpTableViewController.h"
#import "TransitionViewController.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setUpClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"动画" style:UIBarButtonItemStylePlain target:self action:@selector(animationClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor orangeColor];
    
}

- (void)animationClick
{
    TransitionViewController *vc = [[TransitionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"各式动画");
}

- (void)setUpClick
{
//    TextViewController *vc = [[TextViewController alloc] init];
//    [self.navigationController presentViewController:vc animated:YES completion:^{
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        btn.frame = CGRectMake(50, 50, 100, 100);
//        btn.enabled = YES;
//        [vc.view addSubview:btn];
//        [btn addTarget:vc action:@selector(touchUpInside)  forControlEvents:UIControlEventTouchUpInside];
//        
//    }];
    SetUpTableViewController *vc = [[SetUpTableViewController alloc] init];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextViewController *vc = [[TextViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:^{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(50, 50, 100, 100);
        btn.enabled = YES;
        [vc.view addSubview:btn];
        [btn addTarget:vc action:@selector(touchUpInside)  forControlEvents:UIControlEventTouchUpInside];
        
    }];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"我-%d", indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
