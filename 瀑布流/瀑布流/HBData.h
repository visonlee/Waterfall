//
//  HBData.h
//  花瓣瀑布流
//
//  Created by 李文深 on 14-10-13.
//  Copyright (c) 2014年 liwenshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBData : NSObject

@property (copy, nonatomic) NSString *imgRUL;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *imgType;

- (id)initWithDict:(NSDictionary *)dict;

@end
