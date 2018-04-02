#YFPageViewControllerVC
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

- indicator_scrollEnable              默认NO,YES时顶部的item可以滑动
- indicator_scrollAnimation         默认NO,YES时顶部的item选中时有缩放的动画效果
- vc_hirearchy                             默认VCHierarchy_Scroll,控制器是以滚动的方式切换的

