# YFPageViewControllerVC

## Initialize


```
/**
初始化PageVC

@param titleArr    inicatorView的titles
@param vcArr       控制器数组
@return            返回PageVC控制器
*/
-(instancetype)initWith:(NSArray *)titleArr vcArr:(NSArray <YFBasePageVC *>*)vcArr;
```
## Property

```
// 默认NO,YES时顶部的item可以滑动
@property(nonatomic,assign)BOOL indicator_scrollEnable;
// 默认NO,YES时顶部的item选中时有缩放的动画效果
@property(nonatomic,assign)BOOL indicator_scrollAnimation;
// 默认VCHierarchy_Scroll,控制器是以滚动的方式切换的
@property(nonatomic,assign)VCHierarchy vc_hirearchy;

# YFIndexIndicatorView
```

## Property

```
// 点击事件的代理
@property(nonatomic,weak)id<YFIndexIndicatorViewDelegate> delegate;
// indicator的数据源
@property(nonatomic,strong)NSArray *index_arr;
// 指定滚动到那个index
@property(nonatomic,assign,getter=current_index)NSInteger scrollToIndex;
// 是否可以滑动
@property(nonatomic,assign)BOOL scrollEnabled;
// 选中item的时候是否有缩放的效果
@property(nonatomic,assign)BOOL showAnmation;
```

# YFCollectionViewAutoFlowLayout
## Property

```
// 流水布局的代理
@property(nonatomic,weak)id <YFCollectionViewAutoFlowLayoutDelegate>delegate;

// 每个item的间隔
@property (nonatomic, assign)CGFloat interSpace;
```

# YFCollectionViewAutoFlowLayoutDelegate

## 代理方法
```
/**
*  每个item的尺寸
*
*  @param indexPath 所在的分组
*
*  @return item的尺寸
*/
-(CGSize)collectionViewItemSizeForIndexPath:(NSIndexPath *)indexPath;


/**
每个section的headerView的大小

@param section 分区
@return 返回section的headerView的大小
*/
-(CGSize)collectionViewSectionHeadSizeForSection:(NSInteger)section;
```
