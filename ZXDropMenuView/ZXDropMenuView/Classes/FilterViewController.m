//
//  FilterViewController.m
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/5.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import "FilterViewController.h"

UIColor *color (NSUInteger count)
{
    UIColor *colorN;
    switch (count%3) {
        case 0:
            colorN = [UIColor redColor];
            break;
        case 1:
            colorN = [UIColor greenColor];
            break;
        case 2:
            colorN = [UIColor blueColor];
            break;
        default:
            break;
    }
    return colorN;
}

@interface FilterViewController () <UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
}


- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *waterFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    waterFlowLayout.minimumLineSpacing = 15;
    waterFlowLayout.minimumInteritemSpacing = 15;
    waterFlowLayout.sectionInset = UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0);
    waterFlowLayout.itemSize = CGSizeMake(160, 220);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:waterFlowLayout];
    _collectionView = collectionView;
    [self.view addSubview: collectionView];
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"re"];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *maker) {
        
        maker.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"re" forIndexPath:indexPath];
    
    cell.backgroundColor = color(indexPath.row);
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
