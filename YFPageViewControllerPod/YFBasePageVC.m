//
//  YFBasePageVC.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/20.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "YFBasePageVC.h"
#import "YFPageConst.h"


@interface YFBasePageVC ()

@end

@implementation YFBasePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:lab];
    lab.center = self.view.center;
    lab.adjustsFontSizeToFitWidth = YES;
    lab.text = [NSString stringWithFormat:@"第 %ld 个界面",self.index + 1];
    self.view.backgroundColor = RandomColor;
    
//    NSLog(@"%@ viewDidLoad \n %@",[self class],NSStringFromCGRect(self.view.frame));
}

-(void)viewAppearToDoThing{
    
}

@end
