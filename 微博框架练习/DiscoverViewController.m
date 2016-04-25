//
//  DiscoverViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/3/30.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MapViewController.h"
@interface DiscoverViewController ()<UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *search;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSMutableArray *newwArray;
@property (nonatomic, assign) NSUInteger discoverLine;
//@property (nonatomic, strong) UIAlertController *alert;

@end

@implementation DiscoverViewController

- (NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] init];
//        _cellArray=[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888", nil];
        
        NSString*path=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
        _cellArray=[NSMutableArray arrayWithContentsOfFile:path];
//        [self.tableView reloadData];
    }
    return _cellArray;
}

//- (NSMutableArray *)newwArray
//{
//    if (!_newwArray) {
//        _newwArray = [[NSMutableArray alloc] init];
//        //        _cellArray=[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888", nil];
//        
////        NSString*path=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
////        self.newwArray=[NSMutableArray arrayWithContentsOfFile:path];
//        //        [self.tableView reloadData];
//    }
//    return _newwArray;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(mapViewClick)];
//    _cellArray = [[NSMutableArray alloc] init];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
//    self.tableView.backgroundColor = [UIColor redColor];
    UISearchBar *search = [[UISearchBar alloc] init];
//    search.width = 300;
//    search.height = 30;
//    self.navigationItem.titleView = search;
//    search.keyboardAppearance = UIKeyboardAppearanceLight;
//    search.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [search becomeFirstResponder];
//    search.delegate = self;
//    self.search = search;
//    self.search.returnKeyType = UIReturnKeyGo;
////    self.search.keyboardAppearance = UIKeyboardAppearanceLight;
//    self.search.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    self.navigationController.navigationBar.translucent=NO;
//    _search=[[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    search.placeholder=@"请输入要检索的内容";
    search.delegate=self;
    search.showsCancelButton=YES;
    self.tableView.tableHeaderView = search;
    self.search = search;

}

- (void)mapViewClick
{
    MapViewController *map = [[MapViewController alloc] init];
    //push过去隐藏tabber
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:map animated:YES];
    //push后要设为no,不然pop回来就不会再显示tabber
    self.hidesBottomBarWhenPushed=NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;
{
    NSLog(@"取消");
//    _cellArray=[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888", nil];
//    NSString*path=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
//    self.cellArray=[NSMutableArray arrayWithContentsOfFile:path];
    [self.newwArray removeAllObjects];
    [self.tableView reloadData];
    [self.search resignFirstResponder];
}


//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//
//    NSLog(@"searchBarShouldBeginEditing");
//    return YES;
//}
//
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    NSLog(@"searchBarTextDidBeginEditing");
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    NSLog(@"searchBarShouldEndEditing");
//    return YES;
//}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    NSLog(@"searchBarTextDidEndEditing");
//}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    _cellArray=[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888", nil];
//    NSString*path=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
//    self.cellArray=[NSMutableArray arrayWithContentsOfFile:path];
    
    NSLog(@"text %@",searchBar.text);
    NSMutableArray *newwArray = [[NSMutableArray alloc] init];
    for (NSDictionary *str in self.cellArray) {
        NSString *s = str[@"Name"];
        NSRange range = [s rangeOfString:searchBar.text];
        if (range.location != NSNotFound) {
            [newwArray addObject:str];
        }
    }
    self.newwArray = newwArray;
    [self.tableView reloadData];
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    NSLog(@"-----");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"=====%ld",tableView.indexPathsForVisibleRows.count);
    [self.search resignFirstResponder];
    if (tableView.indexPathsForVisibleRows.count == self.cellArray.count) {
         NSString *titileString = [NSString stringWithFormat:@"%@",self.cellArray[indexPath.row][@"Name"]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:titileString preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            NSLog(@"确定");
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }else{
         NSString *titileString = [NSString stringWithFormat:@"%@",self.newwArray[indexPath.row][@"Name"]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:titileString preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            NSLog(@"确定");
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }
   
//    [self.navigationController presentViewController:alert animated:YES completion:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    });
}

#pragma mark 导航的右按钮
-(void)rightBarButtonItemClick{
    //编辑模式的开关
    self.tableView.editing=!self.tableView.editing;
}
-(void)loadData{
    //读取数据
    NSString*path=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    self.cellArray=[NSMutableArray arrayWithContentsOfFile:path];
    
    [self.tableView reloadData];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear%f",self.view.frame.size.height);
    
}
-(void)createTableView{
    //自适配关闭
    self.automaticallyAdjustsScrollViewInsets=NO;
    //导航不透明
    self.navigationController.navigationBar.translucent=NO;
    /*
     在适配上就需要注意当导航不透明的时候需要判断当前屏幕的高度-64才是对的，但是有一种情况是例外的，就是在界面出现以后，坐标会自动减64
     
     例子    [self createTableView];
     在viewDidLoad中创建的就需要减去64，因为这个时候self.view.frame.size.height是480
     在viewDidAppear中创建，就不需要减去64，因为这个时候self.view.frame.size.height是416
     */
    NSLog(@"createTableView%f",self.view.frame.size.height);
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.newwArray.count != 0) {
        return self.newwArray.count;
    }else{
        return self.cellArray.count;
    }
    
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    if (self.newwArray.count != 0) {
        cell.imageView.image=[UIImage imageNamed:self.newwArray[indexPath.row][@"Icon"]];
        cell.textLabel.text=self.newwArray[indexPath.row][@"Name"];
        cell.detailTextLabel.text=self.newwArray[indexPath.row][@"Price"];
       
    }else{
        cell.imageView.image=[UIImage imageNamed:self.cellArray[indexPath.row][@"Icon"]];
        cell.textLabel.text=self.cellArray[indexPath.row][@"Name"];
        cell.detailTextLabel.text=self.cellArray[indexPath.row][@"Price"];
    }
   
    return cell;
}

#pragma mark 编辑模式的相关代理
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //是否能够编辑
    //return indexPath.row%2;
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //具体到每一行是什么模式，是添加模式还是删除模式
    return indexPath.row%2 + 1;
    
}
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"开始编辑，也就是进入编辑模式");
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //执行删除操作
        [self.cellArray removeObjectAtIndex:indexPath.row];
        //操作了数据后，必须要刷新UI
        [self.tableView reloadData];
        
    }else{
        if (editingStyle==UITableViewCellEditingStyleInsert) {
            //执行添加操作 我们取最后一位插入到当前行数
            [self.cellArray insertObject:[self.cellArray lastObject] atIndex:indexPath.row];
            //操作数据后，必须要刷新UI
            [self.tableView reloadData];
            
        }
        
    }
    
    
    
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"结束编辑，也就是进入结束编辑模式");
}
//删除按钮的文字定义
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"%>_<%";
}
//是否能移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //sourceIndexPath       从哪移动
    //destinationIndexPath  移动到哪
    //拷贝出一份
    NSDictionary*dic=[self.cellArray[sourceIndexPath.row]copy];
    //删除当前位置
    [self.cellArray removeObjectAtIndex:sourceIndexPath.row];
    //插入现有位置
    [self.cellArray insertObject:dic atIndex:destinationIndexPath.row];
    
    //这里无需刷新UI，UI在移动的过程中帮你处理了
}
#pragma mark 相关出现的方法
//cell即将出现
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willDisplayCell");
}
//段尾即将出现
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSLog(@"willDisplayFooterView");
}
//段头即将出现
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSLog(@"willDisplayHeaderView");
}
//已经出现的cell
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didEndDisplayingCell");
}
//已经出现的段尾
-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSLog(@"didEndDisplayingFooterView");
}
//已经出现的段头
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSLog(@"didEndDisplayingHeaderView");
}
@end
