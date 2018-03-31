//
//  YFPageViewController.h
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/20.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBasePageVC.h"

@interface YFPageViewController : UIViewController
-(instancetype)initWith:(NSArray *)titleArr vcArr:(NSArray <YFBasePageVC *>*)vcArr;
@end
