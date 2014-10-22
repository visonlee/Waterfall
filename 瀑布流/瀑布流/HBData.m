//
//  HBData.m
//  花瓣瀑布流
//
//  Created by 李文深 on 14-10-13.
//  Copyright (c) 2014年 liwenshen. All rights reserved.
//

#import "HBData.h"

@implementation HBData


- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.imgRUL = dict[@"imgURL"];
        self.width = [dict[@"width"] integerValue];
        self.height = [dict[@"height"] integerValue];
        self.desc = dict[@"desc"];
        self.imgType = dict[@"imgType"];
    }
    return self;
}


@end
