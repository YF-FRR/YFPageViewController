//
//  YFIndexIndicatorView.h
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/16.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFIndexIndicatorView;

@protocol YFIndexIndicatorViewDelegate<NSObject>
@optional
- (void)indexIndicatorView :(YFIndexIndicatorView *)indexIndicatorView didSelectItemAtIndex:(NSInteger)index;
@end


@interface YFIndexIndicatorView : UIView
@property(nonatomic,weak)id<YFIndexIndicatorViewDelegate> delegate;
@property(nonatomic,strong)NSArray *index_arr;
@property(nonatomic,assign,getter=current_index)NSInteger scrollToIndex;
@property(nonatomic,assign)BOOL scrollEnabled;
@property(nonatomic,assign)BOOL showAnmation;
@end
