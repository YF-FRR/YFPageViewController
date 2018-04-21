//
//  YFBasePageVC.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/20.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "YFBasePageVC.h"

@interface YFBasePageVC ()

@end

@implementation YFBasePageVC

-(void)loadView{
    [super loadView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:lab];
    lab.center = self.view.center;
    lab.adjustsFontSizeToFitWidth = YES;
    lab.text = [NSString stringWithFormat:@"第 %ld 个界面",self.index + 1];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%256 /255.0) green:(arc4random()%256 /255.0) blue:(arc4random()%256/255.0) alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewAppearToDoThing{
    
}

@end
