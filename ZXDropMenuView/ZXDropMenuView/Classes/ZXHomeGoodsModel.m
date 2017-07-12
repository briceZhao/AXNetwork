//
//  ZXHomeGoodsModel.m
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/7.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import "ZXHomeGoodsModel.h"

@interface ZXHomeGoodsModel ()

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@implementation ZXHomeGoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (NSArray<ZXHomeGoodsModel *> *)goodsWithPlistFileName:(NSString *)fileName
{
    NSArray *goods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"]];
    
    NSMutableArray *goodsModels = [NSMutableArray arrayWithCapacity:goods.count];
    
    for (NSDictionary *dict in goods)
    {
        [goodsModels addObject:[[self alloc]initWithDict:dict]];
    }
    
    return goodsModels.copy;
}

@end

