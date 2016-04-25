//
//  MutableArraymanager.h
//  微博框架练习
//
//  Created by wangshaoshuai on 16/4/21.
//  Copyright © 2016年 wangshaoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutableArraymanager : NSObject

@property (nonatomic, strong) NSMutableArray *onlyArray;

+(id)sharemutableArraymanager;
@end
