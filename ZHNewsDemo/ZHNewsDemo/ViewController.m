//
//  ViewController.m
//  AXNetwork
//
//  Created by briceZhao on 2017/6/27.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "ViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import <MJRefresh.h>

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray<NewsModel *> *news;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)setNews:(NSArray<NewsModel *> *)news {
    _news = news;
    [self.tableView reloadData];
}

- (void)loadNews {
    [NewsModel newsListsuccess:^(NSArray *array) {
        self.news = array;
        
        [self.tableView.mj_header endRefreshing];
        
    } error:^{
        
        NSLog(@"下载数据失败");
        
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNews)];
    
    self.tableView.mj_header = header;
    
    
    [self loadNews];
    //设置loading的颜色
    [self.tableView.refreshControl setTintColor:[UIColor redColor]];
    
    //设置刷新的文字
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"正在努力加载" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    [self.tableView.refreshControl setAttributedTitle:attrStr];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.news[indexPath.row];
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCell reuseIdentifierForNewsModel:model] forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120.f;
}

@end
