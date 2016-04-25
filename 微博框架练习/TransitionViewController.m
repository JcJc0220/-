
//
//  TransitionViewController.m
//  CALayerDemo
//
//  Created by 张诚 on 15/1/26.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "TransitionViewController.h"
#import "WhiteViewController.h"
@interface TransitionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton*button;
    UITableView*_tableView;
}
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //对一个控件添加动画
//    [self createButton];
    //对VC切换进行设置
    [self createTableView];
    //创建数据源
    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    self.dataArray=[NSMutableArray arrayWithObjects:@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"rotate",@"cameraIrisHollowOpen", @"cameraIrisHollowClose",kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal,nil];
    
    [_tableView reloadData];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text=self.dataArray[indexPath.row];
    return cell;
}
-(void)createButton{
    //创建一个button
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(100, 100, 100, 100);
    [button setTitle:@"动画" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)buttonClick{
    //添加动画
    //错误的
    //CATransaction
    CATransition*ani=[CATransition animation];
    //设置动画时间
    ani.duration=5;
    //设置动画的类型
    ani.type=@"cube";
    //设置动画的运动方式
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //设置动画从哪个方向出现
    ani.subtype=kCATransitionFromLeft;
    //加入动画  需要注意的是forKey是用于删除这个动画使用，一般是空
    [button.layer addAnimation:ani forKey:nil];
    
    
    
    //动画快慢 timingFunction
    /*
     *  kCAMediaTimingFunctionLinear            线性,即匀速
     *  kCAMediaTimingFunctionEaseIn            先慢后快
     *  kCAMediaTimingFunctionEaseOut           先快后慢
     *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
     *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
     */
    //动画的类型 type
    //@"cube"－ 立方体效果  @"suckEffect"－收缩效果，如一块布被抽走   @"oglFlip"－上下翻转效果   @"rippleEffect"－滴水效果  @"pageCurl"－向上翻一页  @"pageUnCurl"－向下翻一页 @"rotate" 旋转效果 @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
    //动画类型
    //kCATransitionFade    新视图逐渐显示在屏幕上，旧视图逐渐淡化出视野
    //kCATransitionMoveIn  新视图移动到旧视图上面，好像盖在上面
    //kCATransitionPush    新视图将旧视图退出去
    //kCATransitionReveal  将旧视图移开显示下面的新视图

    
    //支持的角度
    /*  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
     *  90cw    逆时针旋转90°
     *  90ccw   顺时针旋转90°
     *  180cw   逆时针旋转180°
     *  180ccw  顺时针旋转180°
     */
    

    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以通过行数和段数找到cell的指针
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    //读取cell上文字
    NSString*type=cell.textLabel.text;
    
    
    //创建动画
    CATransition*ani=[CATransition animation];
    //设置动画类型
    ani.type=type;
    //设置动画时间
    ani.duration=1;
    //设置动画速率
    NSArray*array=@[kCAMediaTimingFunctionLinear,kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionDefault];
    
    ani.timingFunction=[CAMediaTimingFunction functionWithName:array[arc4random()%5]];
    
    //动画出现方向
    NSArray*array1=@[kCATransitionFromLeft,kCATransitionFromRight,kCATransitionFromTop,kCATransitionFromBottom];
    /*
     *  90cw    逆时针旋转90°
     *  90ccw   顺时针旋转90°
     *  180cw   逆时针旋转180°
     *  180ccw  顺时针旋转180°
     */
    NSArray*array2=@[@"90cw",@"90ccw",@"180cw",@"180ccw"];
    
    
    if (indexPath.row==6) {
        ani.subtype=array2[arc4random()%4];
    }else{
        ani.subtype=array1[arc4random()%4];
    }
    
    WhiteViewController *vc=[[WhiteViewController alloc]init];
    
    //添加动画在导航页面上
    [self.navigationController.view.layer addAnimation:ani forKey:nil];
    //push 需要注意最后的参数为NO
    [self.navigationController pushViewController:vc animated:NO];
    

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
