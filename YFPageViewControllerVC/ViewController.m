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
#import "YFPageViewController.h"

#define indicatorViewH 40

#define RandomColor [UIColor colorWithRed:(arc4random()%256 /255.0) green:(arc4random()%256 /255.0) blue:(arc4random()%256/255.0) alpha:1.0]

#define isIPhoneX ([UIScreen mainScreen].bounds.size.width>= 375.0f && [UIScreen mainScreen].bounds.size.height >= 812.0f)
//状态栏高度
#define STATUS_HEIGHT (isIPhoneX ? 44 : 20)
//导航栏高
#define NAVI_HEIGHT (44 + STATUS_HEIGHT)

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT (isIPhoneX ? ([UIScreen mainScreen].bounds.size.height -13 ) :[UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<YFIndexIndicatorViewDelegate,YFPageViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *subVCArr;
@property(nonatomic,weak)YFIndexIndicatorView *indicatorView;
@property(nonatomic,weak)YFPageViewController *pageViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSArray *arr = @[@{@"title":@"第一个阿斯顿发斯蒂芬Item",@"badge":@"1"},
                     @{@"title":@"第二个Item",@"badge":@"2"},
                     @{@"title":@"第三个Item",@"badge":@"3"},
                     @{@"title":@"第四发生的范德萨个Item",@"badge":@"4"},
                     @{@"title":@"第五个Item",@"badge":@"0"}];
    
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
    indicatorView.showAnmation = YES;
    indicatorView.showIndicatorLineView = YES;
    indicatorView.indicatorLineWidth = 100;
    indicatorView.indicatorLineColor = [UIColor blackColor];
    indicatorView.indicatorLineAutoWidth = NO;
    indicatorView.scrollToIndex = 0;
    self.indicatorView = indicatorView;

    self.subVCArr = [NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        YFBasePageVC *vc = [YFBasePageVC new];
        vc.index = i;
        vc.superVC = self;
        [self.subVCArr addObject:vc];
    }
    
    YFPageViewController *pageViewController = [[YFPageViewController alloc] initWithTransformType:VCTransformType_Scroll vcArr:self.subVCArr.copy];
    pageViewController.view.frame = CGRectMake(0, 60, WIDTH, HEIGHT - 62);
    pageViewController.delegate = self;
    pageViewController.superVC = self;
    [self addChildViewController:pageViewController];
    self.pageViewController = pageViewController;
    [self.view addSubview:pageViewController.view];
 
}

#pragma mark ====== YFIndexIndicatorViewDelegate =======
- (void)indexIndicatorView :(YFIndexIndicatorView *)indexIndicatorView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第 %ld 个",indexIndicatorView.current_index);
    self.pageViewController.current_index = index;
  
}

#pragma mark ====== YFPageViewControllerDelegate =======
-(void)pageViewController:(YFPageViewController *)pageViewController
   showNextViewController:(YFBasePageVC *)subVC
               showNextVC:(NSUInteger)index{
    
    self.indicatorView.scrollToIndex = index;
}

@end
