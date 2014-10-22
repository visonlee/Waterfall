//
//  WaterfallViewCell.m
//  花瓣瀑布流
//
//  Created by 李文深 on 14-10-13.
//  Copyright (c) 2014年 liwenshen. All rights reserved.
//

// 文本字体
#define kWaterfallCellFont [UIFont systemFontOfSize:13.0]

#import "WaterfallViewCell.h"

@implementation WaterfallViewCell

#pragma mark - imageView getter方法
- (UIImageView *)imageView
{
    // 懒加载imageView
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        
        // 保证图像按比例显示
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:_imageView];
    }
    
    return _imageView;
}



#pragma mark - textLabel getter方法
- (UILabel *)descLabel
{
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        
        // 设置文本标签的其他属性
        // 1) 设置背景颜色
        [_descLabel setBackgroundColor:[UIColor whiteColor]];
        // 2) 设置对齐方式，居中对齐
        [_descLabel setTextAlignment:NSTextAlignmentLeft];
        [_descLabel setFont:kWaterfallCellFont];
        // 3) 设置文本自动换行
        [_descLabel setNumberOfLines:0];
        // 将文本标签放置在图像之上
        [self insertSubview:_descLabel aboveSubview:self.imageView];
    }
    
    return _descLabel;
}

#pragma mark - 视图重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 1. 设置imageView大小和位置
    CGFloat cellW = self.bounds.size.width;
    CGFloat imgH  = _imageView.image.size.height;
    //2.按比例伸缩图片
    [self.imageView setFrame:CGRectMake(0, 0, cellW, imgH*cellW/_imageView.image.size.width)];
    //3.设置描述label的宽高
    [self.descLabel setFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), cellW, self.bounds.size.height - _imageView.bounds.size.height)];
}


@end
