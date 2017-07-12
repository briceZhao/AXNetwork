//
//  ZXHomeGoodsCell.m
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/7.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import "ZXHomeGoodsCell.h"
#import "ZXHomeGoodsModel.h"

@interface ZXHomeGoodsCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation ZXHomeGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)setGoods:(ZXHomeGoodsModel *)goods
{
    _goods = goods;
    
    UIImage *icon = [UIImage imageNamed:goods.icon];
    
    self.imageView.image = icon;
    self.priceLabel.text = goods.price;
}


- (void)commonInit
{
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    [self.contentView addSubview:imageView];
    
    // 使用instrument测试性能 FPS = 60左右
    imageView.layer.cornerRadius = 12;
    imageView.layer.masksToBounds = YES;
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-30);
    }];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    [self.contentView addSubview:priceLabel];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.bottom).offset(5);
        make.centerX.equalTo(self.contentView);
    }];
}


@end


