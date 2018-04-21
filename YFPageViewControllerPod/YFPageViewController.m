//
//  ViewController.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/16.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "YFPageViewController.h"

@interface YFPageViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *contentScrollView;
@end

@implementation YFPageViewController

#pragma mark ====== Initialize =======
-(instancetype)initWithTransformType:(VCTransformType)vcTransformType vcArr:(NSArray <YFBasePageVC *>*)vcArr{
    if (self = [super init]) {
        self.subVCArr = vcArr;
        self.vcTransformType = vcTransformType;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

//    YFBasePageVC *vc = self.subVCArr.firstObject;
//    [self addChildViewController:vc];
    for (NSInteger i=0; i<_subVCArr.count; i++) {
        YFBasePageVC *vc = _subVCArr[i];
        [self addChildViewController:vc];
    }

    CGFloat VC_WIDTH = self.view.bounds.size.width;
    CGFloat VC_HEIGHT = self.view.bounds.size.height;
    if (self.vcTransformType == VCTransformType_Scroll) {
        UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VC_WIDTH, VC_HEIGHT)];
        [self.view addSubview:contentScrollView];
        contentScrollView.delegate = self;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        contentScrollView.showsVerticalScrollIndicator = NO;
        contentScrollView.pagingEnabled = YES;
        contentScrollView.contentSize = CGSizeMake(VC_WIDTH * self.subVCArr.count, VC_HEIGHT);
        self.contentScrollView = contentScrollView;

//       vc.view.frame = CGRectMake(0, 0, VC_WIDTH, VC_HEIGHT );
//        [self.contentScrollView addSubview:vc.view];

    }else{
//        vc.view.frame = CGRectMake(0, 0, VC_WIDTH, VC_HEIGHT);
//        [self.view addSubview:vc.view];
    }
}

#pragma mark ====== UIScrollViewDelegate =======
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat VC_WIDTH = self.view.bounds.size.width;
    CGFloat VC_HEIGHT = self.view.bounds.size.height;
    
    NSInteger index = scrollView.contentOffset.x/VC_WIDTH;
    YFBasePageVC *vc = self.subVCArr[index];
    if (![vc isViewLoaded]) {
        vc.view.frame = CGRectMake(VC_WIDTH * index, 0, VC_WIDTH, VC_HEIGHT);
        [self.contentScrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:showNextViewController:showNextVC:)]) {
        [self.delegate pageViewController:self showNextViewController:vc showNextVC:index];
    }else{
        [vc viewAppearToDoThing];
    }
    _current_index = index;
}

-(void)setCurrent_index:(NSUInteger)current_index{
    _current_index = current_index;
    
    CGFloat VC_WIDTH = self.view.bounds.size.width;
    CGFloat VC_HEIGHT = self.view.bounds.size.height;
    YFBasePageVC *vc = self.subVCArr[current_index];
    if (![vc isViewLoaded]) {
        vc.view.frame = CGRectMake(VC_WIDTH * current_index, 0, VC_WIDTH, VC_HEIGHT);
        [self.contentScrollView addSubview:vc.view];
        [vc viewAppearToDoThing];
    }

    [self.contentScrollView setContentOffset:CGPointMake(VC_WIDTH * current_index, 0) animated:NO];
}

@end
