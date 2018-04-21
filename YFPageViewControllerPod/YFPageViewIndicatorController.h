//
//  YFPageViewIndicatorController.h
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2018/4/21.
//  Copyright © 2018年 jianghu3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBasePageVC.h"

typedef NS_ENUM(NSUInteger, VCTransformType) {
    VCTransformType_Scroll,     // 滚动
    VCTransformType_Overlay     // 叠加
};
@interface YFPageViewIndicatorController : UIViewController

/**
 初始化PageVC
 
 @param titleArr    inicatorView的titles
 @param vcArr       控制器数组
 @return            返回PageVC控制器
 */
-(instancetype)initWith:(NSArray *)titleArr vcArr:(NSArray <YFBasePageVC *>*)vcArr;
// 默认NO,YES时顶部的item可以滑动
@property(nonatomic,assign)BOOL indicator_scrollEnable;
// 默认NO,YES时顶部的item选中时有缩放的动画效果
@property(nonatomic,assign)BOOL indicator_scrollAnimation;
// 默认VCHierarchy_Scroll,控制器是以滚动的方式切换的
@property(nonatomic,assign)VCTransformType vcTransformType;

@end
