//
//  FormListSubmitView.m
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/17.
//  Copyright © 2020 周发明. All rights reserved.
//

#import "FormListSubmitView.h"
#import "FormListTextCell.h"
#import "FormListTextVCell.h"
#import "FormListImageUpCell.h"
#import "FormListSelectCell.h"

@interface FormListSubmitView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation FormListSubmitView

- (NSMutableDictionary *)submitParam{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (FormListBaseModel *obj in self.models) {
        NSDictionary *submit = obj.submitValue;
        if (submit) {
            [result addEntriesFromDictionary:submit];
        }
    }
    return result;
}

- (NSMutableArray<FormListBaseModel *> *)models{
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (BOOL)verifyDataSource{
    return [self verifyDataSource:YES];
}

- (BOOL)verifyDataSource:(BOOL)alert{
    __block BOOL success = YES;
    [self.submitParam removeAllObjects];
    [self.models enumerateObjectsUsingBlock:^(FormListBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj verifySuccess:alert]) {
            success = NO;
            *stop = YES;
        }
    }];
    return success;
}


- (void)reloadData{
    [self registerCell];
    [super reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:FormSubmitModelValueChangeNotiKey object:nil];
}

- (void)registerCell
{
    for (FormListBaseModel *model in self.models) {
        if (model.cellIsNib) {
            [self registerNib:[UINib nibWithNibName:model.cellClassName bundle:nil] forCellReuseIdentifier:model.reuseKey];
        } else {
            [self registerClass:NSClassFromString(model.cellClassName) forCellReuseIdentifier:model.reuseKey];
        }
    }
}

#pragma mark --- tableView delegate / dataSource ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.models.count) {
        FormListBaseModel *model = self.models[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.reuseKey];
        if ([cell respondsToSelector:@selector(setModel:)]) {
            [cell performSelector:@selector(setModel:) withObject:model];
        }
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.models.count) {
        FormListBaseModel *model = self.models[indexPath.row];
        return model.cellHeight;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
