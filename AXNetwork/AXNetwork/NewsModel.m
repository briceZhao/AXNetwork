//
//  NewsModel.m
//  AXNetwork
//
//  Created by briceZhao on 2017/6/28.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (NSString *)formatedTime {
    
    NSDate *oldTime = [NSDate dateWithTimeIntervalSince1970:self.addtime.intValue];
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //比较
    NSDateComponents *dcp = [calendar components:NSCalendarUnitMinute fromDate:oldTime toDate:[NSDate date] options:0];
    
    if (dcp.minute < 60) {
        //小于一小时
        return [NSString stringWithFormat:@"%zd分钟之前", dcp.minute];
    }
    
    dcp = [calendar components:NSCalendarUnitHour fromDate:oldTime toDate:[NSDate date] options:0];
    
    if (dcp.hour < 24) {
        //小于一天
        return [NSString stringWithFormat:@"%zd小时之前", dcp.hour];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"MM:dd HH:mm";
    return [format stringFromDate:oldTime];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    NewsModel *model = [[NewsModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (void)newsListsuccess:(void (^)(NSArray *))successBlock error:(void (^)())errorBlock
{
    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1472281297/type/0?channel=appstore&uuid=8FCC46AD-2B0C-4DC2-89C8-9631855FAB13&net=5&model=iPhone&ver=1.0.5"];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"POST";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            //连接错误
            if (errorBlock) {
                errorBlock();
            }
            return ;
        }
        //服务器内部问题
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            
            NSMutableArray<NewsModel *> *news = [NSMutableArray array];
            //json反序列化 转模型
            NSArray *datas = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            //遍历数组，把字典转成模型
            [datas enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NewsModel *model = [NewsModel modelWithDictionary:obj];
                [news addObject:model];
            }];
            
            if (successBlock) {
                //成功 拿到数据 
                successBlock(news);
            }
        } else {
            if (errorBlock) {
                errorBlock();//服务器错误，请求失败
            }
        }
        
    }];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@{title = %@,summary = %@,img = %@,sitename = %@,addtime = %d}",[super description],self.title,self.summary,self.img,self.sitename,self.addtime.intValue];
}


@end
