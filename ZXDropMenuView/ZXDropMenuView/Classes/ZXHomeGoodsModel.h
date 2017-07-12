//
//  ZXHomeGoodsModel.h
//  ZXDropMenuView
//
//  Created by brice Mac on 2017/4/7.
//  Copyright © 2017年 briceZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHomeGoodsModel : NSObject

@property (nonatomic, copy, readonly) NSString *icon;

@property (nonatomic, copy, readonly) NSString *price;

@property (nonatomic, assign, readonly) NSInteger width;

@property (nonatomic, assign, readonly) NSInteger height;


/**
 根据plist文件名返回一个模型数组
 
 @param fileName    plist文件的名字
 @return    模型数组
 */
+ (NSArray<ZXHomeGoodsModel *> *)goodsWithPlistFileName:(NSString *)fileName;


@end
