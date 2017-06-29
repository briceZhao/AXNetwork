//
//  NewsCell.m
//  AXNetwork
//
//  Created by briceZhao on 2017/6/28.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

+ (NSString *)reuseIdentifierForNewsModel:(NewsModel *)model {
    NSString *identifier = @"newscell";
    // 如果服务器返回数据中 “img” 对应的 值为 nil，则没有图片
    if (model.img.length == 0) {
        identifier = @"newscell2";
    }
    return identifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NewsModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.summaryLabel.text = model.summary;
    self.siteNameLabel.text = model.sitename;
    self.addtimeLabel.text = model.formatedTime;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    [self.titleLabel layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //提前计算 titleLabel 所有文字单行显示的长度，再和 titleLabel 自动布局后的长度进行比较，若长度长于布局的长度，则标题不止一行
    CGFloat titleWidth = [self.model.title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    
    CGFloat labelWidth = self.titleLabel.frame.size.width;
    //标题超过一行，隐藏详情内容
    if (titleWidth > labelWidth) {
        self.summaryLabel.hidden = YES;
    } else {
        self.summaryLabel.hidden = NO;
    }
}


@end
