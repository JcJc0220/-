//
//  MapViewController.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/11.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"卫星" style:UIBarButtonItemStylePlain target:self action:@selector(mapStyleClick)];
    
    _mapView = [[MKMapView alloc] init];
    _mapView.delegate = self;
    _mapView.frame = self.view.frame;
    [self.view addSubview:_mapView];
    
    
    //地图默认显示的是世界地图，我们需要把地图放大到指定位置，放大到中国天坛 我们就需要一个坐标39.896304, 116.410103
    
    //坐标从哪来，打开谷歌地图，右键点击这有个什么，在以前是这里是什么， 点击后会出现经纬度  我们点击后出现一个不老神🐔 40.823759, 111.711388
    //经度和纬度
    CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(40.823759, 111.711388);
    //设置放大系数
    MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
    //组成结构体
    MKCoordinateRegion region=MKCoordinateRegionMake(coord, span);
    //对mapView进行设置
    [_mapView setRegion:region];
    
    //显示自己的位置
    _mapView.showsUserLocation=YES;
    
    //如何根据自己的位置让地图跟随,开启定位
    
    //注意_manager要使用全局变量，否则会自动销毁，导致无法定位
    _manager=[[CLLocationManager alloc]init];
    _manager.delegate=self;
    //ios7和ios8的区别
    //ios8需要多2个方法才可以定位
    [_manager requestWhenInUseAuthorization];
    [_manager requestAlwaysAuthorization];
    
    //在plist中添加2个值NSLocationWhenInUseUsageDescription  NSLocationAlwaysUsageDescription  都是布尔值  YES
    
    //设置定位间距,移动1000米才会调用代理
    _manager.distanceFilter=1000.0;
    
    //开始定位
    [_manager startUpdatingLocation];
    
    //对地图添加手势
    UILongPressGestureRecognizer*_longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:_longPress];
    
    
    //逆地理编码，根据经纬度，来获得地址
    
    CLGeocoder*geo=[[CLGeocoder alloc]init];
    //设置经纬度
    CLLocation*location=[[CLLocation alloc]initWithLatitude:40.823759 longitude:111.711388];
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取到结果
        CLPlacemark*place=[placemarks firstObject];
        
        NSLog(@"===%@",place.addressDictionary);
        
        NSData*data=[NSJSONSerialization dataWithJSONObject:place.addressDictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString*str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"---%@",str);
        
    }];

    
}

- (void)mapStyleClick
{
    if (self.mapView.mapType == MKMapTypeStandard) {
        self.mapView.mapType = MKMapTypeSatellite;
        self.navigationItem.rightBarButtonItem.title = @"标准";
    }else{
        self.mapView.mapType = MKMapTypeStandard;
        self.navigationItem.rightBarButtonItem.title = @"卫星";
    }
    
}

-(void)longPress:(UILongPressGestureRecognizer*)Press{
    
    if (Press.state!=UIGestureRecognizerStateBegan) {
        return;
    }
    //根据手势点击的位置计算出中心点
    
    CGPoint point=[Press locationInView:_mapView];
    
    //根据中心点计算出地图的经纬度
    CLLocationCoordinate2D coord=[_mapView convertPoint:point toCoordinateFromView:_mapView];
    
    CLGeocoder*geo=[[CLGeocoder alloc]init];
    //设置经纬度
    CLLocation*location=[[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取到结果
        CLPlacemark*place=[placemarks firstObject];
        
        NSLog(@"===%@",place.addressDictionary);
        
        NSData*data=[NSJSONSerialization dataWithJSONObject:place.addressDictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString*str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"---%@",str);
        
        //添加大头针数据
        MKPointAnnotation*annotation=[[MKPointAnnotation alloc]init];
        //设置经纬度坐标
        annotation.coordinate=coord;
        //设置主标题
        annotation.title = place.addressDictionary[@"City"];
        //设置副标题
        annotation.subtitle = place.addressDictionary[@"Name"];
        
        //添加在地图上
        [_mapView addAnnotation:annotation];
        
    }];
    
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //读取最后定位数据
    CLLocation*newLocation=[locations lastObject];
    //让地图偏移
    
    [UIView animateWithDuration:1 animations:^{
        [_mapView setRegion:MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
        
    }];
    
}
#pragma mark MapViewDelegate
//使用原生的大头针
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
//和tableView的复用是一样

    //MKPinAnnotationView继承于MKAnnotationView的方法一个扩展
    MKPinAnnotationView*pinAnnotation=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];

    if (!pinAnnotation) {
        pinAnnotation=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    //设置大头针的颜色
    //pinAnnotation.pinColor=MKPinAnnotationColorGreen;
    pinAnnotation.pinTintColor= [UIColor orangeColor];
    //设置掉下来的动画
    pinAnnotation.animatesDrop=YES;
    //显示气泡
    pinAnnotation.canShowCallout=YES;
    //设置左边的头像
    UIImageView*leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftImageView.image=[UIImage imageNamed:@"image1.png"];
    leftImageView.layer.cornerRadius=15;
    leftImageView.layer.masksToBounds=YES;
    pinAnnotation.leftCalloutAccessoryView=leftImageView;
    //设置右边的详情
    UIButton*rightButton=[UIButton buttonWithType:UIButtonTypeInfoDark];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    pinAnnotation.rightCalloutAccessoryView=rightButton;

    return pinAnnotation;
}
-(void)rightButtonClick:(UIButton*)button{
    
    

    NSLog(@"地图大头针按钮");
}

//自定义大头针
//-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    MKAnnotationView*annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
//    if (!annotationView) {
//        annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
//    }
//    
//    //设置图片
//    annotationView.image=[UIImage imageNamed:@"4.jpg"];
//    
//    annotationView.frame=CGRectMake(0, 0, 20, 20);
//    [UIView animateWithDuration:1 animations:^{
//        annotationView.frame=CGRectMake(0, 0, 30, 30);
//    }];
//    annotationView.canShowCallout=YES;
//    
//    return annotationView;
//}



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
