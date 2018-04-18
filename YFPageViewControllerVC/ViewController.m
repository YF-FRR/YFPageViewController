//
//  ViewController.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/16.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "ViewController.h"
#import "YFIndexIndicatorView.h"
#import "UIView+Extension.h"

#import "IndexIndicatorCell.h"
#import "YFCollectionViewAutoFlowLayout.h"
#import "HeaderReusableView.h"

#import "YFBasePageVC.h"

#define indicatorViewH 40

#define RandomColor [UIColor colorWithRed:(arc4random()%256 /255.0) green:(arc4random()%256 /255.0) blue:(arc4random()%256/255.0) alpha:1.0]

#define isIPhoneX ([UIScreen mainScreen].bounds.size.width>= 375.0f && [UIScreen mainScreen].bounds.size.height >= 812.0f)
//状态栏高度
#define STATUS_HEIGHT (isIPhoneX ? 44 : 20)
//导航栏高
#define NAVI_HEIGHT (44 + STATUS_HEIGHT)

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT (isIPhoneX ? ([UIScreen mainScreen].bounds.size.height -13 ) :[UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<YFIndexIndicatorViewDelegate,YFCollectionViewAutoFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *index_arr;
@property(nonatomic,strong)NSMutableArray *subVCArr;
@property(nonatomic,weak)YFIndexIndicatorView *indicatorView;
@property(nonatomic,weak)UIScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self testCollectionFlowLayout];
    NSArray *arr = @[@"第一个Item",@"第二个Item",@"第三个Item",@"第四个Item",@"第五个Item",@"第六个Item",@"第七个Item",@"第八个Item",@"第九个Item",@"第十个Item"];
    
    YFIndexIndicatorView *indicatorView = [[YFIndexIndicatorView alloc] init];
    [self.view addSubview:indicatorView];
    [indicatorView mas_constraint:^(UIView *make) {
        make.mas_top = 20;
        make.mas_left = 0;
        make.mas_right = 0;
        make.mas_height = indicatorViewH;
    }];
    indicatorView.index_arr = arr;
    indicatorView.delegate = self;
    indicatorView.scrollEnabled = YES;
    indicatorView.showAnmation = NO;
    indicatorView.backgroundColor = [UIColor orangeColor];
    self.indicatorView = indicatorView;
    
    UIScrollView *contentScrollView = [UIScrollView new];
    [self.view addSubview:contentScrollView];
    [contentScrollView addLayoutConstraint:UIEdgeInsetsMake(64, 0, 0, 0 )];
    contentScrollView.delegate = self;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.contentSize = CGSizeMake(WIDTH * arr.count, HEIGHT - NAVI_HEIGHT);
    self.contentScrollView = contentScrollView;
    
    self.subVCArr = [NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        YFBasePageVC *vc = [YFBasePageVC new];
        vc.index = i;
        [self addChildViewController:vc];
//        __weak typeof(self) weakSelf=self;
        vc.superVC = self;
        [self.subVCArr addObject:vc];
    }
    YFBasePageVC *vc = self.subVCArr.firstObject;
    
    [self.contentScrollView addSubview:vc.view];
    vc.view.backgroundColor = RandomColor;
    vc.view.frame = CGRectZero;
    
    self.indicatorView.scrollToIndex = 0;
 
}

- (void)indexIndicatorView :(YFIndexIndicatorView *)indexIndicatorView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第 %ld 个",indexIndicatorView.current_index);
    
    YFBasePageVC *vc = self.subVCArr[index];
    if (![vc isViewLoaded]) {
        vc.view.frame = CGRectMake(WIDTH * index, 0, WIDTH, HEIGHT - NAVI_HEIGHT);
        [self.contentScrollView addSubview:vc.view];
        vc.view.backgroundColor = RandomColor;
        [vc viewAppearToDoThing];
    }
    
    [self.contentScrollView setContentOffset:CGPointMake(WIDTH *index, 0) animated:YES];
}

#pragma mark ====== UIScrollViewDelegate =======
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/WIDTH;
    self.indicatorView.scrollToIndex = index;
    YFBasePageVC *vc = self.subVCArr[index];
    if (![vc isViewLoaded]) {
        vc.view.frame = CGRectMake(WIDTH * index, 0, WIDTH, HEIGHT - NAVI_HEIGHT);
        [self.contentScrollView addSubview:vc.view];
        vc.view.backgroundColor = RandomColor;
        [vc viewAppearToDoThing];
    }
}

#pragma mark ====== 测试 YFCollectionViewAutoFlowLayout =======
-(void)testCollectionFlowLayout{
    self.index_arr = @[@"第一个Item",@"第二个Item",@"第三个Item",@"第四个Item",@"第五个Item",@"第六个Item",@"第七个Item",@"第八个Item",@"第九个Item",@"第十个Item"];
    
    YFCollectionViewAutoFlowLayout * flowLayout=[[YFCollectionViewAutoFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSizeType = ItemSizeEqualHeight;
    flowLayout.numberOfLines = 1;
    flowLayout.interSpace = 0;
    flowLayout.delegate = self;
    
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    collectionView.backgroundColor = [UIColor yellowColor];
    [collectionView registerClass:[IndexIndicatorCell class] forCellWithReuseIdentifier:@"IndexIndicatorCell"];
    [collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [self.collectionView addLayoutConstraint:UIEdgeInsetsMake(100, 0, -100, 0)];

}

#pragma mark ====== YFCollectionViewAutoFlowLayoutDelegate =======
-(CGSize)collectionView:(UICollectionView *)collectionView itemSizeForIndexPath:(NSIndexPath *)indexPath{
//    CGFloat width = self.collectionView.frame.size.width / self.index_arr.count;
    return CGSizeMake(100, 30);
}

-(CGSize)collectionViewSectionHeadSizeForSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

#pragma mark ====== UICollectionViewDataSource =======
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.index_arr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IndexIndicatorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexIndicatorCell" forIndexPath:indexPath];
    [cell realoadCellWith:self.index_arr[indexPath.item] count:@""];
    cell.backgroundColor = RandomColor;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderReusableView *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
    header.titleStr = [NSString stringWithFormat:@"第%ld个区头",indexPath.section];
    return header;
}

@end
