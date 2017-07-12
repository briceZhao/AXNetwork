//
//  HomeViewController.m
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/3.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#define NAVIGATION_BAR_HEIGHT 64.0

#import "HomeViewController.h"
#import "FilterViewController.h"
#import "ZXDropMenuView.h"
#import "ZXDropMenuItem.h"
#import "ZXHomeGoodsCell.h"
#import "ZXHomeGoodsModel.h"
#import "ZXWaterFlowLayout.h"
#import "UIBarButtonItem+Badge.h"
#import <UIViewController+ZXExtension.h>

static NSString *const kHomeReuseId = @"kHomeReuseId";

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ZXWaterFlowLayoutDataSource, ScrollingNavigationBarDelegate>

@property (nonatomic, strong) ZXDropMenuView *menu;

@property (nonatomic, copy) NSArray<ZXHomeGoodsModel *> *goods;

@property (nonatomic, weak) ZXWaterFlowLayout *waterFlowLayout;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger collection;

@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.zx_interactiveNavigationBarHidden = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSArray<ZXHomeGoodsModel *> *)goods {
    
    if (!_goods) {
        _goods = [ZXHomeGoodsModel goodsWithPlistFileName:@"goods"];
    }
    return _goods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *rightBar = [UIBarButtonItem customBarButtonItemWithClick:^(UIButton *button) {
        // click barButtonItem
    }];
    
    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"Home"];
    item.rightBarButtonItem = rightBar;
    [self.navigationBar pushNavigationItem:item animated:NO];
    [self.navigationBar setTranslucent:NO];
    [self.view addSubview:self.navigationBar];
    
    
    [self setupMenu];
    
    [self setupCollectionView];
}


- (void)setupMenu {
    
    ZXDropMenuItem *item1 = [[ZXDropMenuItem alloc]
                             initWithTitle:@"分类"
                             options:@[@"裙子", @"上衣", @"裤子", @"鞋子", @"包包", @"套装", @"儿童装", @"配饰", @"美妆个护"]
                             image:[UIImage imageNamed:@"filter_category_normal"]
                             selectedImage:[UIImage imageNamed:@"filter_category_selected"]];
    
    ZXDropMenuItem *item2 = [[ZXDropMenuItem alloc]
                             initWithTitle:@"筛选"
                             options:@[]
                             image:[UIImage imageNamed:@"filter_filter_normal"]
                             selectedImage:[UIImage imageNamed:@"filter_filter_selected"]];
    
    ZXDropMenuItem *item3 = [[ZXDropMenuItem alloc]
                             initWithTitle:@"排序"
                             options:@[@"热销款", @"最新款", @"价格从低到高", @"价格从高到低"]
                             image:[UIImage imageNamed:@"filter_sort"]
                             selectedImage:[UIImage imageNamed:@"filter_sort"]
                             initialOptionIndex:0];
    
    ZXDropMenuView *menu = [[ZXDropMenuView alloc]init];
    self.menu = menu;
    [self.view addSubview: menu];
    
    [menu makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(40.f);
    }];
    
    item1.usingOptionAsTitle = YES;
    
    menu.items = @[item1, item2, item3];
    
    @weakify(self);
    [[RACObserve(item1, selectedOptionIndex) skip:1] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, 0) animated:YES];
        
    }];
    
    [item2.itemClickSignal subscribeNext:^(ZXDropMenuItem * _Nullable x) {
        @strongify(self);
        
        FilterViewController *filterVc = [[FilterViewController alloc]init];
        [self.menu dismissDropMenuWithAnimated:NO];
        [self.navigationController pushViewController:filterVc animated:YES];
    }];
}

- (void)setupCollectionView {
    
    ZXWaterFlowLayout *waterFlowLayout = [[ZXWaterFlowLayout alloc]init];
    self.waterFlowLayout = waterFlowLayout;
    waterFlowLayout.dataSource = self;
    waterFlowLayout.extraHeight = 35;
    waterFlowLayout.columnCount = 2;
    waterFlowLayout.minimumLineSpacing = 15;
    waterFlowLayout.minimumInteritemSpacing = 15;
    waterFlowLayout.sectionInset = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:waterFlowLayout];
    _collectionView = collectionView;
    [self.view addSubview: collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[ZXHomeGoodsCell class] forCellWithReuseIdentifier:kHomeReuseId];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.top.equalTo(self.menu.bottom);
        maker.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - ZXWaterFlowLayoutDataSource -
- (CGFloat)waterFlowLayout:(ZXWaterFlowLayout *)waterFlowLayout heightToWidthRatioAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZXHomeGoodsModel *model = self.goods[indexPath.item];
    
    return (CGFloat)(model.height) / (CGFloat)model.width;
}


#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXHomeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeReuseId forIndexPath:indexPath];
    
    cell.goods = self.goods[indexPath.item];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    //use super to call Method Swizzling: hideNavigationBar_viewWillAppear
    [super viewWillAppear:animated];
    
    //set the scrollableView that self.navigationBar is tracking with.
    [self followScrollView:self.collectionView];
    
}

- (void)dealloc
{
    [self stopFollowingScrollView];
}


@end


