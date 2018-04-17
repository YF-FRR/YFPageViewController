//
//  YFPageConst.h
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2018/4/2.
//  Copyright © 2018年 jianghu3. All rights reserved.
//

#ifndef YFPageConst_h
#define YFPageConst_h

#define RandomColor [UIColor colorWithRed:(arc4random()%256 /255.0) green:(arc4random()%256 /255.0) blue:(arc4random()%256/255.0) alpha:1.0]

#define isIPhoneX ([UIScreen mainScreen].bounds.size.width>= 375.0f && [UIScreen mainScreen].bounds.size.height >= 812.0f)

//状态栏高度
#define STATUS_HEIGHT (isIPhoneX ? 44 : 20)
//导航栏高
#define NAVI_HEIGHT (44 + STATUS_HEIGHT)

#define VC_WIDTH [UIScreen mainScreen].bounds.size.width
// 控制器的view不考虑手势区域的高度
#define HEIGHT [UIScreen mainScreen].bounds.size.height
// 控制器的view考虑手势区域的高度
#define VC_HEIGHT (isIPhoneX ? ([UIScreen mainScreen].bounds.size.height -13 ) :[UIScreen mainScreen].bounds.size.height)

#define indicatorViewH 40

typedef NS_ENUM(NSUInteger, VCHierarchy) {
    VCHierarchy_Scroll,     // 滚动
    VCHierarchy_Overlay     // 叠加
};

#endif /* YFPageConst_h */



