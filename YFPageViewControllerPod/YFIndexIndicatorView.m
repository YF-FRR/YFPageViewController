//
//  YFIndexIndicatorView.m
//  YFPageViewControllerVC
//
//  Created by ios_yangfei on 2017/12/16.
//  Copyright © 2017年 jianghu3. All rights reserved.
//

#import "YFIndexIndicatorView.h"
#import "YFCollectionViewAutoFlowLayout.h"
#import "IndexIndicatorCell.h"
#import "UIView+Extension.h"
#import "YFPageConst.h"

#define getSize(str,h,font)  [str boundingRectWithSize:CGSizeMake(10000, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size

@interface YFIndexIndicatorView()<UICollectionViewDelegate,UICollectionViewDataSource,YFCollectionViewAutoFlowLayoutDelegate>{
    NSInteger current_selected_index;
}
@property(nonatomic,weak)UICollectionView *collectionView;

@end

@implementation YFIndexIndicatorView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{

    YFCollectionViewAutoFlowLayout * flowLayout=[[YFCollectionViewAutoFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSizeType = ItemSizeEqualHeight;
    flowLayout.numberOfLines = 1;
    flowLayout.interSpace = 0;
    flowLayout.delegate = self;
    
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[IndexIndicatorCell class] forCellWithReuseIdentifier:@"IndexIndicatorCell"];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [self.collectionView addLayoutConstraint:UIEdgeInsetsZero];
  
}

#pragma mark ====== YFCollectionViewAutoFlowLayoutDelegate =======
-(CGSize)collectionView:(UICollectionView *)collectionView itemSizeForIndexPath:(NSIndexPath *)indexPath{
    if (self.scrollEnabled) {
        NSString *title = self.index_arr[indexPath.item][@"title"];
        CGFloat width = getSize(title,self.collectionView.frame.size.height,14).width + 20;
        return CGSizeMake(width, self.collectionView.frame.size.height);
    }else{
        CGFloat width = self.collectionView.frame.size.width / self.index_arr.count;
        return CGSizeMake(width, self.collectionView.frame.size.height);
    }
}

#pragma mark ====== UICollectionViewDataSource =======
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.index_arr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IndexIndicatorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexIndicatorCell" forIndexPath:indexPath];
    [cell realoadCellWith:self.index_arr[indexPath.item][@"title"] count:self.index_arr[indexPath.item][@"badge"]];
    cell.show_scale_animation = self.showAnmation;
    cell.backgroundColor = RandomColor;
    return cell;
}

#pragma mark ====== UICollectionViewDelegate =======

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    current_selected_index = indexPath.item;
    if (self.delegate && [self.delegate respondsToSelector:@selector(indexIndicatorView:didSelectItemAtIndex:)]) {
        [self.delegate indexIndicatorView:self didSelectItemAtIndex:indexPath.item];
    }
    
    if (self.scrollEnabled) {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark ====== Functions =======
-(void)setScrollToIndex:(NSInteger)scrollToIndex{
    
    current_selected_index = scrollToIndex;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:scrollToIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
}

-(NSInteger)current_index{
    return current_selected_index;
}

-(void)setIndex_arr:(NSArray *)index_arr{
    _index_arr = index_arr;
    [self.collectionView reloadData];
}

-(void)setScrollEnabled:(BOOL)scrollEnabled{
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = scrollEnabled;
    [self.collectionView reloadData];
}
@end
