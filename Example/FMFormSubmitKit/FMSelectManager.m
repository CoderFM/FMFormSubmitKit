//
//  FMSelectManager.m
//  qygt
//
//  Created by 周发明 on 17/3/13.
//  Copyright © 2017年 途购. All rights reserved.
//

#import "FMSelectManager.h"

@interface FMSelectManager ()

@property(nonatomic, strong)FMPickerView *pickerView;

@end

@implementation FMSelectManager

+ (instancetype)manager{
    static FMSelectManager *_BeeIssueSelectManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _BeeIssueSelectManager = [[FMSelectManager alloc] init];
        [_BeeIssueSelectManager pickerView];
    });
    return _BeeIssueSelectManager;
}

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle okBlock:(void (^)(NSDate *))okBlock{
    [self showSelectTimeMode:UIDatePickerModeDateAndTime middleTitle:middleTitle okBlock:okBlock];
}

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle showDate:(NSDate *)date okBlock:(void(^)(NSDate *date))okBlock{
    [self showSelectTimeWithMiddleTitle:middleTitle okBlock:okBlock];
    if (date) {
        self.pickerView.datePickerView.date = date;
    } else {
        self.pickerView.datePickerView.date = [NSDate date];
    }
}

- (void)showSelectTimeMode:(UIDatePickerMode)datePickerMode middleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock{
    self.pickerView.middleLabel.text = middleTitle;
    self.pickerView.timeOKBlock = okBlock;
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:self.pickerView];
    self.pickerView.datePickerView.datePickerMode = datePickerMode;
    [self.pickerView showWithType:FMPickerViewTimeType];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<FMPickerItem *>*)items components:(NSInteger)components okBlock:(FMSelectManagerFinishBlock)okBlock{
    [self showSelectDataWithMiddleTitle:middleTitle items:items selectedRow:nil components:components okBlock:okBlock];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<FMPickerItem *>*)items selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components okBlock:(FMSelectManagerFinishBlock)okBlock{
    [self showSelectDataWithMiddleTitle:middleTitle items:(NSArray<NSArray *> *)items selectedRow:selectedRows components:components linkageType:FMPickerViewLinkageNormalType okBlock:okBlock];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<FMPickerItem *> *)items  selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components linkageType:(FMPickerViewLinkageType)linkageType okBlock:(FMSelectManagerFinishBlock)okBlock{
    if (self.pickerView.items) {
        [self.pickerView.pickerView selectRow:0 inComponent:0 animated:YES];
    }
    self.pickerView.middleLabel.text = middleTitle;
    self.pickerView.dataOKBlock = okBlock;
    self.pickerView.linkageType = linkageType;
    self.pickerView.items = (NSMutableArray *)items;
    self.pickerView.components = components;
    [self.pickerView.pickerView reloadAllComponents];
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:self.pickerView];
    [self.pickerView showWithType:FMPickerViewDataType];
    if (selectedRows && selectedRows.count > 0) {
        [selectedRows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < components) {
                if (linkageType == FMPickerViewLinkageNormalType) { // 联动的
                    [self.pickerView.pickerView selectRow:obj.integerValue inComponent:idx animated:NO];
                    [self.pickerView pickerView:self.pickerView.pickerView didSelectRow:obj.integerValue inComponent:idx];
                } else {
                    [self.pickerView.pickerView selectRow:obj.integerValue inComponent:idx animated:NO];
                }
            }
        }];
    }
}

- (FMPickerView *)pickerView{
    if (_pickerView == nil) {
        FMPickerView *picker = [FMPickerView viewForXib];
        picker.datePickerView.minimumDate = [NSDate date];
        picker.hidden = YES;
        [picker hide];
        picker.frame = [UIScreen mainScreen].bounds;
        [[[[UIApplication sharedApplication] delegate] window] addSubview:picker];
        _pickerView = picker;
    } else {
        if (![[[[[UIApplication sharedApplication] delegate] window] subviews] containsObject:_pickerView]) {
            [[[[UIApplication sharedApplication] delegate] window] addSubview:_pickerView];
        }
    }
    return _pickerView;
}

@end


@implementation FMPickerItem

+ (instancetype)itemWithName:(NSString *)name subItems:(NSArray<FMPickerItem *> *)subItems{
    FMPickerItem *item = [[FMPickerItem alloc] init];
    item.name = name;
    item.subItems = subItems;
    return item;
}

@end
