//
//  ViewController.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/16.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "YFPageViewController.h"

#import "YFIndexIndicatorView.h"
#import "UIView+Extension.h"

#define indicatorViewH 40

#define RandomColor [UIColor colorWithRed:(arc4random()%256 /255.0) green:(arc4random()%256 /255.0) blue:(arc4random()%256/255.0) alpha:1.0]

#define isIPhoneX ([UIScreen mainScreen].bounds.size.width>= 375.0f && [UIScreen mainScreen].bounds.size.height >= 812.0f)
//状态栏高度
#define STATUS_HEIGHT (isIPhoneX ? 44 : 20)
//导航栏高
#define NAVI_HEIGHT (44 + STATUS_HEIGHT)

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT (isIPhoneX ? ([UIScreen mainScreen].bounds.size.height -13 ) :[UIScreen mainScreen].bounds.size.height)

@interface YFPageViewController ()<YFIndexIndicatorViewDelegate,UIScrollViewDelegate>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray<YFBasePageVC *> *subVCArr;
@property(nonatomic,weak)YFIndexIndicatorView *indicatorView;
@property(nonatomic,weak)UIScrollView *contentScrollView;
@end

@implementation YFPageViewController

-(instancetype)initWith:(NSArray *)titleArr vcArr:(NSArray<YFBasePageVC *> *)vcArr{
    if (self = [super init]) {
        self.titleArr = titleArr;
        self.subVCArr = vcArr;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    YFIndexIndicatorView *indicatorView = [[YFIndexIndicatorView alloc] init];
    [self.view addSubview:indicatorView];
    [indicatorView mas_constraint:^(UIView *make) {
        make.mas_top = 23;
        make.mas_left = 0;
        make.mas_right = 0;
        make.mas_height = indicatorViewH;
    }];
    indicatorView.index_arr = self.titleArr;
    indicatorView.delegate = self;
    indicatorView.scrollEnabled = YES;
    indicatorView.showAnmation = NO;
    self.indicatorView = indicatorView;
    self.indicatorView.scrollToIndex = 0;
    
    UIScrollView *contentScrollView = [UIScrollView new];
    [self.view addSubview:contentScrollView];
    [contentScrollView addLayoutConstraint:UIEdgeInsetsMake(64, 0, 0, 0 )];
    contentScrollView.delegate = self;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.contentSize = CGSizeMake(WIDTH * self.subVCArr.count, HEIGHT - NAVI_HEIGHT);
    self.contentScrollView = contentScrollView;

    for (NSInteger i=0; i<_subVCArr.count; i++) {
        YFBasePageVC *vc = _subVCArr[i];
        vc.index = i;
        vc.superVC = self;
    }
    YFBasePageVC *vc = self.subVCArr.firstObject;
    
    [self.contentScrollView addSubview:vc.view];
    vc.view.backgroundColor = RandomColor;
    vc.view.frame = CGRectZero;
    
}

- (void)indexIndicatorView :(YFIndexIndicatorView *)indexIndicatorView didSelectItemAtIndex:(NSInteger)index{

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

@end

