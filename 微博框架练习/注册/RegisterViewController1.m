//
//  RegisterViewController1.m
//  WeiChat
//
//  Created by 张诚 on 15/2/2.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "RegisterViewController1.h"
#import "RegisterViewController2.h"
@interface RegisterViewController1 ()<UITextFieldDelegate>
{
//展现账号的label
    UILabel*userNameLabel;
//备注
    UILabel*infoLabel;
//输入框 输入昵称
    UITextField*nickNameTextField;
//免责声明的说明
    UILabel*dutyLabel;
//免责声明的按钮
    UIButton*dutyButton;

//重试按钮
    UIButton*tryButton;
    
//重名提示框
    UILabel *duplicationOfNameLabel;
    NSString *nikeNameRealTime;
    
/*
需要注意的就是注册协议，注册即同意，一定要有免责声明
 
 */

}
@end

@implementation RegisterViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2@2x.png"]];
    //设置导航的左右按钮，如果后续界面是继承于当前控制器，那么以下方法，都需要重写
    [self createNav];
    //设置界面
    [self createView];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 监听输入框实时内容
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL duplicationOfName = NO;
    duplicationOfNameLabel.text = nil;
    NSLog(@"%@--%lu--%@",nickNameTextField.text,(unsigned long)range.length,string);
    //判断点击删除按钮
    if ([string  isEqual: @""]) {
        NSString *nikeNameRealTime11  = [[NSString alloc] initWithFormat:@"%@",nickNameTextField.text];
        range.length = nikeNameRealTime11.length - 1;
        range.location = 0;
        NSString *nikeNameRealTime1 = [nikeNameRealTime11 substringWithRange:range];
        NSLog(@"%@---%@",nikeNameRealTime11,nikeNameRealTime1);
        nikeNameRealTime = nikeNameRealTime1;
    }else{
        NSString *nikeNameRealTime1  = [[NSString alloc] initWithFormat:@"%@%@",nickNameTextField.text,string];
        nikeNameRealTime = nikeNameRealTime1;
    }
    
//    NSLog(@"%@",nikeNameRealTime);
    
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSLog(@"%@",docPath);
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"manager.plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    for (int i = 0; i < data.count; i++) {
        if ([[data[i] objectForKey:@"nickName"] isEqual:nikeNameRealTime]) {
//            NSLog(@"存在");
            duplicationOfName = YES;
            break;
        }
    }
    if (duplicationOfName) {
//        NSLog(@"....存在");
        duplicationOfNameLabel.text = @"用户名已存在!";
    }
    return YES;
}
//点击删除按钮后清除判断框内的内容
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    duplicationOfNameLabel.text = nil;
    NSLog(@"点击删除");
    return YES;
}

#pragma mark 界面
-(void)createView{
    userNameLabel=[ZCControl createLabelWithFrame:CGRectMake(50, 64, WIDTH-150, 40) Font:15 Text:[NSString stringWithFormat:@"您的数字账号为：%ld",DTAETIME]];
    [self.view addSubview:userNameLabel];
    infoLabel=[ZCControl createLabelWithFrame:CGRectMake(50, 100, WIDTH-50, 10) Font:5 Text:@"苍老师为您创建数字账号，不满意请点击重试来为您创建一个新的数字账号"];
    //设置文字的颜色
    infoLabel.textColor=[UIColor grayColor];
    [self.view addSubview:infoLabel];
    
    //创建输入框
    UIImageView*tempImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, 60, 40) ImageName:nil];
    UIImageView*nickNameImageView=[ZCControl createImageViewWithFrame:CGRectMake(20, 10, 20, 20) ImageName:@"icon_register_name.png"];
    [tempImageView addSubview:nickNameImageView];
    
    nickNameTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, 114, WIDTH, 40) placeholder:@"请输入昵称" passWord:NO leftImageView:tempImageView rightImageView:nil Font:10 backgRoundImageName:nil];
    nickNameTextField.delegate = self;
    nickNameTextField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:nickNameTextField];
    
    //创建重名提示
    duplicationOfNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 123, 114, 100, 40) ];
    duplicationOfNameLabel.backgroundColor = [UIColor whiteColor];
    duplicationOfNameLabel.textColor = [UIColor redColor];
    duplicationOfNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:duplicationOfNameLabel];
    
    //免责声明
    dutyLabel=[ZCControl createLabelWithFrame:CGRectMake(40, 160, 100, 10) Font:5 Text:@"注册即表示同意"];
    dutyLabel.textColor=[UIColor grayColor];
    [self.view addSubview:dutyLabel];
    
    dutyButton=[ZCControl createButtonWithFrame:CGRectMake(50, 160, 100, 10) ImageName:nil Target:self Action:@selector(dutyClick) Title:@"<微聊小圈免责声明>"];
    dutyButton.titleLabel.font=[UIFont systemFontOfSize:5];
    [dutyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:dutyButton];
    
    //重试按钮
    tryButton=[ZCControl createButtonWithFrame:CGRectMake(WIDTH-80, 70, 60, 30) ImageName:nil Target:self Action:@selector(tryClick) Title:@"重试"];
    [self.view addSubview:tryButton];
}
#pragma mark 重试按钮
-(void)tryClick{
    userNameLabel.text=[NSString stringWithFormat:@"您的数字账号为：%ld",DTAETIME];

}
#pragma mark 进入免责声明界面
-(void)dutyClick{

}
#pragma mark 设置导航左右按钮
-(void)createNav{
    //header_leftbtn_black_nor@2x.png
    UIButton*leftNavButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:@"header_leftbtn_black_nor.png" Target:self Action:@selector(backClick) Title:@"返回"];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftNavButton];
    //右按钮
    UIButton*rightNavButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:nil Target:self Action:@selector(nextClick) Title:@"下一步"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
    
    

}
#pragma mark 下一个界面
-(void)nextClick{
    if (nickNameTextField.text.length==0) {
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写用户名" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
        return;
    }else if(duplicationOfNameLabel.text.length != 0){
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名已存在" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
        return;
    }
    
    
    RegisterManager*manager=[RegisterManager shareManager];
    //获取用户名
    NSString*userName=[userNameLabel.text substringFromIndex:8];
    
    manager.userName=userName;
    //获取昵称
    manager.nickName=nickNameTextField.text;
    
    
    
    
    
    RegisterViewController2*vc=[[RegisterViewController2 alloc]init];
    vc.title=@"个人资料（2/4）";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 设置返回
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
