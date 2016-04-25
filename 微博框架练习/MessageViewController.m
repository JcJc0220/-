//
//  MessageViewControllerTableViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "MessageViewController.h"

#import "AFHTTPSessionManager.h"

@interface MessageViewController () <HorizontalTableViewDelegate>
@property (nonatomic, strong) HorizontalTableView *tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*imageArray;
@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(writeLettersClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self createTableView];
    [self downloadImage];
    [self loadData];
    
}

- (void)downloadImage
{
    // 获得网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 要下载文件的url
    NSURL *url = [NSURL URLWithString:@"http://pic.qiantucdn.com/58pic/15/14/91/36D58PICzd6_1024.jpg"];
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 声明一个进度对象
    NSProgress *progress = [[NSProgress alloc] init];
    
    // 异步
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        // 告诉服务器下载的文本保存的位置在那里
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSLog(@"file = %@",targetPath);
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"response = %@,filePath = %@",response,filePath);
        
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:[NSString stringWithFormat:@"%@",filePath]];
        
    }] ;
    [task resume];
  
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
        if([object isKindOfClass:[NSProgress class]]) {
            // 获得进度值
            NSProgress *progress = (NSProgress *)object;
            NSLog(@"下载进度----%f",progress.fractionCompleted);
            NSLog(@"localizedDescription = %@",progress.localizedDescription);
            NSLog(@"localizedAdditionalDescription = %@",progress.localizedAdditionalDescription);
   }

//    dispatch_async(dispatch_get_main_queue(), ^{
//    [_tableView refreshData];
//    });
}



-(void)createTableView{
    
    _tableView=[[HorizontalTableView alloc] init];
    _tableView.frame = CGRectMake(0,64,self.view.size.width, self.view.size.height - 108);
    _tableView.delegate=self;
//    _tableView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_tableView];
    
}
-(void)loadData{
    self.dataArray=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<10; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [_tableView refreshData];
}
#pragma mark 相关代理方法
-(NSInteger)numberOfColumnsForTableView:(HorizontalTableView *)tableView
{
    return self.dataArray.count;
}
-(UIView*)tableView:(HorizontalTableView *)tableView viewForIndex:(NSInteger)index
{
    UIView*view=[tableView dequeueColumnView];
    if (view==nil) {
        view=[[UIView alloc]initWithFrame:self.view.frame];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 50)];
        label.tag=100;
        [view addSubview:label];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100,self.view.bounds.size.width - 40, 300)];
        imageView.tag = 11;
        [view addSubview:imageView];
    }
    
    //每一页颜色不一样
    CGFloat a=arc4random()%256/255.0;
    CGFloat b=arc4random()%256/255.0;
    CGFloat c=arc4random()%256/255.0;
    view.backgroundColor=[UIColor colorWithRed:a green:b blue:c alpha:1];
    //按照tag寻找label
    UILabel*label=(UILabel*)[view viewWithTag:100];
    
    label.text=self.dataArray[index];
    
    UIImageView *imageView = (UIImageView *)[view viewWithTag:11];
    
    NSURL *imageURL = [NSURL URLWithString:self.imageArray[0]];
    NSLog(@"imageARRAY  %@ === %@", self.imageArray[0],self.dataArray[index]);
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageWithData:data];
   
  
    
//    imageView.image = [UIImage imageNamed:@"image0.png"];
    
    return view;
}
-(CGFloat)columnWidthForTableView:(HorizontalTableView *)tableView
{
    return self.view.frame.size.width;
}
- (void)writeLettersClick
{
    NSLog(@"写私信");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 20;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"消息-%d", indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
//    return cell;
//}
@end
