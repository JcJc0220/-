//
//  LoginViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/15.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "LoginViewController.h"
#import "TabberViewController.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "MainSliderViewController.h"
#import "NavigationController.h"
#import "RegisterViewController1.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *accountText;
@property (nonatomic, strong) UITextField *pwdText;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UILabel *account = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 50, 30)];
    account.text = @"账号:";
    account.font = [UIFont systemFontOfSize:20];
//    account.backgroundColor  = [UIColor redColor];
    UITextField *accountText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(account.frame) + 10, 150, self.view.bounds.size.width - 100 - 60, 30)];
    accountText.placeholder = @"请输入账号";
    accountText.font = [UIFont systemFontOfSize:20];
//    accountText.text = @"123";
    accountText.delegate = self;
    accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    accountText.borderStyle = UITextBorderStyleRoundedRect;
//    accountText.textAlignment = NSTextAlignmentCenter;
//    accountText.backgroundColor = [UIColor grayColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(account.frame) + 10, 181, self.view.bounds.size.width - 100 - 60, 1 )];
    line.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    UILabel *pwd = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(account.frame) + 20, 50, 30)];
    pwd.text = @"密码:";
    pwd.font = [UIFont systemFontOfSize:20];
    UITextField *pwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwd.frame) + 10, CGRectGetMaxY(account.frame) + 20, self.view.bounds.size.width - 100 - 60, 30)];
    pwdText.placeholder = @"请输入密码";
//    pwdText.text = @"123";
    pwdText.font = [UIFont systemFontOfSize:20];
//    pwdText.textAlignment = NSTextAlignmentCenter;
    pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdText.secureTextEntry = YES;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwd.frame) + 10, CGRectGetMaxY(account.frame) + 51, self.view.bounds.size.width - 100 - 60, 1)];
    line2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 40, CGRectGetMaxY(pwdText.frame) + 20, 80, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn addTarget:self action:@selector(loginBtnClinck1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 40, CGRectGetMaxY(loginBtn.frame) + 20, 80, 40)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor orangeColor];
    [registerBtn addTarget:self action:@selector(registerBtnClinck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [self.view addSubview:loginBtn];
    [self.view addSubview:account];
    [self.view addSubview:accountText];
    [self.view addSubview:pwd];
    [self.view addSubview:pwdText];
    [self.view addSubview:line];
    [self.view addSubview:line2];
    self.accountText = accountText;
    self.pwdText = pwdText;
    //初始化账号密码（测试方便）
//    [self initializePassword];
}
//textField代理方法，用来实时反馈输入内容
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@--%lu--%@",self.accountText.text,(unsigned long)range.length,string);
    NSString *nikeNameRealTime  = [[NSString alloc] initWithFormat:@"%@%@",self.accountText.text,string];
    NSLog(@"%@",nikeNameRealTime);
    return YES;
}

- (void)initializePassword
{
    
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSLog(@"%@",docPath);
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"manager.plist"];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                @"123", @"nickName",
                                @"123", @"passWord",nil];
    
    // 只有具备writeToFile:的对象才能使用plist存储，NSArray
    MutableArraymanager *mutableArraymanager = [MutableArraymanager sharemutableArraymanager];
    NSMutableArray *array = mutableArraymanager.onlyArray;
    [array addObject:dic];
    
    [array writeToFile:filePath atomically:YES];
}

- (void)registerBtnClinck
{
    RegisterViewController1*vc=[[RegisterViewController1 alloc]init];
    //默认动画是从下移动到上，修改默认动画为旋转
    vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    vc.title=@"请输入昵称（1/4）";
    
    NavigationController*nc=[[NavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)loginBtnClinck1
{
    //记录输入的账号是否存在
    BOOL userExistence = NO;
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"manager.plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    
//    NSString *nickName = [data.firstObject objectForKey:@"nickName"];
//    NSString *passWord = [data.firstObject objectForKey:@"passWord"];
//    NSLog(@"%@==%@",nickName, passWord);
    NSString *account = self.accountText.text;
    NSString *pwd = self.pwdText.text;
    
    for (int i = 0; i < data.count; i++) {
        if ([[data[i] objectForKey:@"nickName"] isEqual:account] && [[data[i] objectForKey:@"passWord"] isEqual:pwd]) {
            userExistence = YES;
            NSLog(@"%d==%@==%@",i,[data[i] objectForKey:@"nickName"], [data[i] objectForKey:@"passWord"]);
        }
    }
    if (userExistence) {
        [MBProgressHUD showMessage:@"正在登录中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            //登陆到没有侧滑效果的界面
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController= [[TabberViewController alloc] init];

        });

    }else if(account.length == 0 || pwd.length == 0){
        [MBProgressHUD showMessage:@"账号密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        NSLog(@"账号密码不能为空");
    }else{
        [MBProgressHUD showMessage:@"账号密码错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        NSLog(@"账号密码错误");
    }

    //存储账号只有一个时下面就可以（快速实现功能测试用）
//    if ([account  isEqual:nickName] && [pwd  isEqual:passWord]) {
//        [MBProgressHUD showMessage:@"正在登录中"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//            //登陆到没有侧滑效果的界面
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            window.rootViewController= [[TabberViewController alloc] init];
//            
//            //登陆到有侧滑效果的界面
//            //            MainSliderViewController *vc = [[MainSliderViewController alloc] init];
//            //            NavigationController *nc = [[NavigationController alloc] initWithRootViewController:vc];
//            //            [self presentViewController:nc animated:YES completion:nil];
//            
//            
//            
//        });
//        
//    }else if(account.length == 0 || pwd.length == 0){
//        [MBProgressHUD showMessage:@"账号密码不能为空"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//        });
//        NSLog(@"账号密码不能为空");
//    }else{
//        [MBProgressHUD showMessage:@"账号密码错误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//        });
//        NSLog(@"账号密码错误");
//    }
    }
- (void)loginBtnClinck
{
    NSString *account = self.accountText.text;
    NSString *pwd = self.pwdText.text;
    if ([account  isEqual: @"123"] && [pwd  isEqual: @"123"]) {
        [MBProgressHUD showMessage:@"正在登录中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [MBProgressHUD hideHUD];
            //登陆到没有侧滑效果的界面
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController= [[TabberViewController alloc] init];

            //登陆到有侧滑效果的界面
//            MainSliderViewController *vc = [[MainSliderViewController alloc] init];
//            NavigationController *nc = [[NavigationController alloc] initWithRootViewController:vc];
//            [self presentViewController:nc animated:YES completion:nil];
            
            
            
        });
        
    }else if(account.length == 0 || pwd.length == 0){
        [MBProgressHUD showMessage:@"账号密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        NSLog(@"账号密码不能为空");
    }else{
        [MBProgressHUD showMessage:@"账号密码错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        NSLog(@"账号密码错误");
    }
        
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
