//
//  MutableArraymanager.m
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/21.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import "MutableArraymanager.h"
static MutableArraymanager *mutableArraymanager =nil;

@implementation MutableArraymanager

+(id)sharemutableArraymanager{
    //    if (manager==nil) {
    //        manager=[[RegisterManager alloc]init];
    //    }
    //    return manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mutableArraymanager=[[MutableArraymanager alloc]init];
         mutableArraymanager.onlyArray =[[NSMutableArray alloc] init];
    });
    return mutableArraymanager;
}
@end
