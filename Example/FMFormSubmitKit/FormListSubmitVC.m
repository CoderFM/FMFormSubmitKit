//
//  FormListSubmitVC.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListSubmitVC.h"

@interface FormListSubmitVC ()

@end

@implementation FormListSubmitVC

- (UITableViewStyle)tableStyle{
    return UITableViewStylePlain;
}

- (NSMutableArray *)dataSource
{
    return self.tableView.models;
}

- (void)setDataSource:(NSMutableArray<FormListBaseModel *> *)dataSource{
    self.tableView.models = dataSource;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        FormListSubmitView *table = [[FormListSubmitView alloc] initWithFrame:CGRectZero style:self.tableStyle];
        [self.view addSubview:table];
        _tableView = table;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    [self configurationTable];
    [self addData];
}

- (void)addData{
    
}

- (void)configurationTable{
    
}

- (BOOL)verifyDataSource{
    return [self.tableView verifyDataSource];
}
- (BOOL)verifyDataSource:(BOOL)alert{
    return [self.tableView verifyDataSource:alert];
}

@end
