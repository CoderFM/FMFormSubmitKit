//
//  FormListHandle.m
//  FMFormSubmitKit
//
//  Created by 郑桂华 on 2021/3/9.
//

#import "FormListHandle.h"
#import "FormListBaseCell.h"

@implementation FormListHandle

- (void)dealloc{
    NSLog(@"FormListHandle dealloc");
}

- (instancetype)initWithTableView:(UITableView *)tableView{
    if (self = [super init]) {
        self.tableView = tableView;
        self.models = [NSMutableArray array];
    }
    return self;
}

- (NSMutableDictionary *)submitParam{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSMutableArray *arrM in self.groupModels) {
        for (FormListBaseModel *obj in arrM) {
            NSDictionary *submit = obj.submitValue;
            if (submit) {
                [result addEntriesFromDictionary:submit];
            }
        }
    }
    return result;
}

- (void)setModels:(NSMutableArray<FormListBaseModel *> *)models{
    _models = models;
    self.groupModels = [NSMutableArray arrayWithArray:@[models]];
}

- (void)registerCell
{
    for (NSMutableArray *arrM in self.groupModels) {
        for (FormListBaseModel *model in arrM) {
            if (model.cellIsNib) {
                [self.tableView registerNib:[UINib nibWithNibName:model.cellClassName bundle:nil] forCellReuseIdentifier:model.reuseKey];
            } else {
                [self.tableView registerClass:NSClassFromString(model.cellClassName) forCellReuseIdentifier:model.reuseKey];
            }
        }
    }
}

- (BOOL)verifyDataSource{
    return [self verifyDataSource:YES];
}

- (BOOL)verifyDataSource:(BOOL)alert{
    __block BOOL success = YES;
    [self.groupModels enumerateObjectsUsingBlock:^(NSMutableArray<FormListBaseModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(FormListBaseModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull innerStop) {
            if (![model verifySuccess:alert]) {
                success = NO;
                *innerStop = YES;
                *stop = YES;
            }
        }];
    }];
    return success;
}


#pragma mark --- tableView delegate / dataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupModels[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.groupModels.count) {
        NSMutableArray *arrM = self.groupModels[indexPath.section];
        if (indexPath.row < arrM.count) {
            FormListBaseModel *model = arrM[indexPath.row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.reuseKey];
            if ([cell isKindOfClass:[FormListBaseCell class]]) {
                [(FormListBaseCell *)cell setModel:model];
            }
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.groupModels.count) {
        NSMutableArray *arrM = self.groupModels[indexPath.section];
        if (indexPath.row < arrM.count) {
            FormListBaseModel *model = arrM[indexPath.row];
            return model.cellHeight;
        }
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cardCornerReadus <= 0) {
        return;
    }
    FormListBaseModel *model;
    if (indexPath.section < self.groupModels.count) {
        NSMutableArray *arrM = self.groupModels[indexPath.section];
        if (indexPath.row < arrM.count) {
            model = arrM[indexPath.row];
        }
    }
    
    //圆率
    CGFloat cornerRadius = 10.0;
    //大小
    CGRect bounds = cell.bounds;
    //行数
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    //绘制曲线
    UIBezierPath *bezierPath = nil;
    if (indexPath.row == 0 && numberOfRows == 1) {
        //一个为一组时，四个角都为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == 0) {
        //为组的第一行时，左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == numberOfRows - 1) {
        //为组的最后一行，左下、右下角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else {
        //中间的都为矩形
        bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    }
    //cell的背景色透明
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    //新建一个图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    //图层边框路径
    layer.path = bezierPath.CGPath;
    //图层填充色，也就是cell的底色
    layer.fillColor = (model.contentBg ?: [UIColor whiteColor]).CGColor;
    //图层边框线条颜色
    /*
     如果self.tableView.style = UITableViewStyleGrouped时，每一组的首尾都会有一根分割线，目前我还没找到去掉每组首尾分割线，保留cell分割线的办法。
     所以这里取巧，用带颜色的图层边框替代分割线。
     这里为了美观，最好设为和tableView的底色一致。
     设为透明，好像不起作用。
     */
    layer.strokeColor = [UIColor grayColor].CGColor;
    //将图层添加到cell的图层中，并插到最底层
    NSMutableArray *removeArr = [NSMutableArray array];
    for (CAShapeLayer *layerItem in [cell.layer sublayers]) {
        if ([layerItem isKindOfClass:[CAShapeLayer class]]) {
            [removeArr addObject:layerItem];
        }
    }
    if (removeArr.count > 0) {
        for (CAShapeLayer *layerItem in removeArr) {
            [layerItem removeFromSuperlayer];
        }
    }
    [cell.layer insertSublayer:layer atIndex:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return self.sectionMargin < 0.01 ? 0.01 : self.sectionMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
