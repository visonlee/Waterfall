//
//  RootViewController.m
//  花瓣瀑布流
//
//  Created by 李文深 on 14-10-13.
//  Copyright (c) 2014年 liwenshen. All rights reserved.
//

#import "RootViewController.h"
#import "HBData.h"
#import "UIImage+animatedGIF.h"
#import "UICollectionViewWaterfallLayout.h"
#import "WaterfallViewCell.h"

#define CellMargin   15

@interface RootViewController ()<UICollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_dataSource;//存放模型数据的数组
    NSInteger _columnCount;
    UICollectionView *_collectionView;
    UICollectionViewWaterfallLayout *_layout;
    
}

@end

@implementation RootViewController

#pragma mark 从某个方向旋转设备
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    // 根据设备的当前方向，设定要显示的数据列数
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        _columnCount = 4;
    } else {
        _columnCount = 3;
    }
    _layout.itemWidth = self.view.bounds.size.width / _columnCount - CellMargin;
    _layout.columnCount =  _columnCount;
    // 如果发生设备旋转，重新加载数据
    [_collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化CollectView的布局类
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.delegate = self;
    _layout = layout;
    
    //初始化CollectView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor yellowColor];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    _collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    //加载模型数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"道趣儿.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        HBData *data = [[HBData alloc] initWithDict:dict];
        [tmpArr addObject:data];
    }
    _dataSource = tmpArr;
    
    //注册重用单元格
    [collectionView registerClass:[WaterfallViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //一开始就让他强制执行屏幕旋转的监听方法
    [self didRotateFromInterfaceOrientation:0];
}


#pragma mark - collectionView的数据源和代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterfallViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    HBData  *data = _dataSource[indexPath.row];        //取出模型
    
    //设置数据
    NSString *imageName = [NSString stringWithFormat:@"%d.%@",indexPath.row,data.imgType];
     NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    NSData *imgData = [NSData dataWithContentsOfFile:path];
    cell.imageView.image = [UIImage animatedImageWithAnimatedGIFData:imgData];  //uiimage的分类，实现动态图片的展示
    
    //从网络加载图片，但我已做了本地缓存，故用上面的方法实现
    //cell.imageView.image = [ UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:data.imgRUL]];
    
    cell.descLabel.text = data.desc;
    
    return cell;
}




#pragma mark collectionview布局代理方法
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
     HBData  *data = _dataSource[indexPath.row];
    
    //因为每个cell图片的描述信息的字体数量不确定，所以cell的高度需要动态计算
    CGFloat w = self.view.bounds.size.width / _columnCount - CellMargin;
    NSString *str = data.desc;
    CGSize contrainSize = CGSizeMake(w, MAXFLOAT);
    CGSize textSize = [str boundingRectWithSize:contrainSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size;
    
    return data.height * w / data.width + textSize.height;
}

@end
