//
//  NewsModel.h
//  AXNetwork
//
//  Created by briceZhao on 2017/6/28.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *summary;

@property(nonatomic,copy) NSString *img;

@property(nonatomic,copy) NSString *sitename;

@property(nonatomic,copy) NSNumber *addtime;

/// TODO: 不标准的模型，后面要把多余字段去掉
@property(nonatomic,copy) NSString *formatedTime;

+(instancetype)modelWithDictionary:(NSDictionary *)dic;

+(void)newsListsuccess:(void(^)(NSArray *))successBlock error:(void(^)())errorBlock;

@end
/* 数据结构如下:
 {
    "id":"612427",
    "type_id":"5",
    "title":"贾跃亭：乐视资金风波远比我们想象的要更大",
    "summary":"【TechWeb报道】6月28日消息，今天下午，乐视网召开2016年度股东大会，乐视网董事长贾跃亭在回答股东问题...",
    "img":"http://news.coolban.com/Upload/thumb/170628/80-60-160005K24-0.jpg",
    "src_img":"http://upload.techweb.com.cn/2017/0523/1495529941258.jpg",
    "sitename":"techweb",
    "addtime":"1498636914",
    "use_thumb":false
 }
 */
