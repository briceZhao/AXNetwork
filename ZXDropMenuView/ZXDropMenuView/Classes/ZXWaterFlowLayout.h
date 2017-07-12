//
//  ZXWaterFlowLayout.h
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/6.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWaterFlowLayout;

@protocol ZXWaterFlowLayoutDataSource <NSObject>

@required

/**
 实现瀑布流流水布局的方法

 @param waterFlowLayout     CollectionView's flowLayout
 @param indexPath           IndexPath of each item
 @return                    The ratio of height/width
 */
- (CGFloat)waterFlowLayout:(ZXWaterFlowLayout *)waterFlowLayout heightToWidthRatioAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZXWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZXWaterFlowLayoutDataSource> dataSource;

/// 设置 collectionView 每行排列几个，默认为 3
@property (nonatomic, assign) NSUInteger columnCount;

/// 设置 每个 collectionViewCell 除去图片之外的高度（用于布局文字或其它子控件），默认为 0 
@property (nonatomic, assign) NSUInteger extraHeight;

@end

