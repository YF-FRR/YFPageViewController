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
// 是否可以滑动
@property(nonatomic,assign)BOOL scrollEnabled;
// 选中item的时候是否有缩放的效果
@property(nonatomic,assign)BOOL showAnmation;
@end
