//
//  NewsCell.h
//  AXNetwork
//
//  Created by briceZhao on 2017/6/28.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet UILabel *siteNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addtimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) NewsModel *model;

/// TODO: 后面去掉view中数据处理的逻辑，改用ViewModel代为处理
+ (NSString *)reuseIdentifierForNewsModel:(NewsModel *)model;

@end
