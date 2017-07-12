//
//  ZXWaterFlowLayout.m
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/6.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import "ZXWaterFlowLayout.h"

@interface ZXWaterFlowLayout ()

/// UICollectionViewLayoutAttributes
@property (nonatomic, strong) NSMutableArray *fixedAttributes;

/// max Y numbers
@property (nonatomic, strong) NSMutableArray *ordinates;

@property (nonatomic, assign) CGFloat minY;

@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) NSUInteger index;

@end

@implementation ZXWaterFlowLayout

- (NSMutableArray *)fixedAttributes
{
    if (!_fixedAttributes) {
        _fixedAttributes = [NSMutableArray array];
    }
    return _fixedAttributes;
}

- (NSUInteger)columnCount
{
    if (_columnCount == 0) _columnCount = 3;
    return _columnCount;
}

- (void)prepareLayout
{
    self.fixedAttributes = nil;
    self.ordinates = nil;
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.fixedAttributes addObject:attribute];
    }
    
    UICollectionViewLayoutAttributes *footerAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    footerAttribute.frame = CGRectMake(0, self.maxY + self.sectionInset.bottom, self.collectionView.bounds.size.width, self.footerReferenceSize.height);
    
    [self.fixedAttributes addObject:footerAttribute];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.fixedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *currentAttribute =  [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat attributeW = (self.collectionView.bounds.size.width - (self.columnCount - 1)* self.minimumInteritemSpacing  - self.sectionInset.left - self.sectionInset.right)/ self.columnCount;
    
    CGFloat attributeH = [self.dataSource waterFlowLayout:self heightToWidthRatioAtIndexPath:indexPath] * attributeW + self.extraHeight;
    
    //计算Y  从数组中获取最小的Y + 行间距
    CGFloat attributeY = self.minY + self.minimumLineSpacing;
    
    //计算x   间距 + 索引 * （间距 + 控件的宽）
    CGFloat attributeX = self.sectionInset.left + self.index * (self.minimumInteritemSpacing + attributeW);
    
    self.ordinates[self.index] = @(attributeY + attributeH);
    
    
    currentAttribute.frame = CGRectMake(attributeX,attributeY, attributeW, attributeH);
    
    return currentAttribute;
}


- (CGSize)collectionViewContentSize
{
    // contentSize = 找到最大的Y + sectioninsetBottom+ footerView高
    return CGSizeMake(0, self.maxY + self.sectionInset.bottom + self.footerReferenceSize.height);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}


#pragma mark - 初始化记录最大Y值的数组 -
- (NSMutableArray *)ordinates
{
    if (!_ordinates) {
        _ordinates = [NSMutableArray array];
        for (NSInteger i = 0; i < self.columnCount; i++) {
            [_ordinates addObject:@"0"];
        }
    }
    return _ordinates;
}

- (CGFloat)minY
{
    _minY = MAXFLOAT;
    
    for (int i = 0 ; i < self.ordinates.count; i ++) {
        CGFloat currentY = [self.ordinates[i] doubleValue];
        
        if (currentY < _minY) {
            _minY = currentY;
            _index = i;
        }
    }
    
    return _minY;
}

- (CGFloat)maxY
{
    _maxY = 0 ;
    
    for (int i = 0 ; i < self.ordinates.count; i ++) {
        CGFloat currentY = [self.ordinates[i] doubleValue];
        
        if (currentY > _maxY) {
            _maxY = currentY;
        }
        
    }
    return _maxY;
}


@end


