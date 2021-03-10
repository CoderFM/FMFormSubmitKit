//
//  FormListSubmitVC.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
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
    return self.tableView.handle.models;
}

- (void)setDataSource:(NSMutableArray<FormListBaseModel *> *)dataSource{
    self.tableView.handle.models = dataSource;
}

- (FormListSubmitView *)tableView{
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
    return [self.tableView.handle verifyDataSource];
}
- (BOOL)verifyDataSource:(BOOL)alert{
    return [self.tableView.handle verifyDataSource:alert];
}

@end
