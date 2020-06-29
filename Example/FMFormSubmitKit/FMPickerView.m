//
//  FMPickerView.m
//  qygt
//
//  Created by 周发明 on 17/3/10.
//  Copyright © 2017年 途购. All rights reserved.
//

#import "FMPickerView.h"

@interface FMPickerView ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerBottomHeight;

@property(nonatomic, assign)FMPickerViewType type;

@end

CGFloat FMPickerViewHeight = 256;

@implementation FMPickerView

+ (instancetype)viewForXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)okButtonClick{
    self.hidden = YES;
    if (self.type == FMPickerViewTimeType) {
        if (self.timeOKBlock) {
            self.timeOKBlock(self.datePickerView.date);
        }
    } else {
        if (self.linkageType == FMPickerViewLinkageForbidType) {
            NSMutableArray *arrM = [NSMutableArray array];
            NSMutableArray *rows = [NSMutableArray array];
            for (int i = 0; i<self.components; i++) {
                NSArray *arr = self.items[i];
                NSInteger row = [self.pickerView selectedRowInComponent:i];
                if (row < arr.count) {
                    [arrM addObject:arr[row]];
                    [rows addObject:@(row)];
                } else {
                    [rows addObject:@(0)];
                }
            }
            if (self.dataOKBlock){
                self.dataOKBlock(arrM, rows);
            }
        } else {
            NSArray *items = self.items;
            FMPickerItem *item = nil;
            NSMutableArray *rows = [NSMutableArray array];
            for (int i = 0; i<self.components; i++) {
                if (items && items.count > 0) {
                    item = items[[self.pickerView selectedRowInComponent:i]];
                    items = item.subItems;
                    [rows addObject:@([self.pickerView selectedRowInComponent:i])];
                } else {
                    break;
                }
            }
            if (self.dataOKBlock){
                self.dataOKBlock(item, rows);
            }
        }
    }
}

- (void)showWithType:(FMPickerViewType)type{
    self.type = type;
    if (type == FMPickerViewTimeType) {
        self.datePickerView.hidden = NO;
        self.pickerView.hidden = YES;
    } else {
        self.datePickerView.hidden = YES;
        self.pickerView.hidden = NO;
    }
    self.hidden = NO;
    self.pickerBottomHeight.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    if (self.type == FMPickerViewDataType) {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
    self.pickerBottomHeight.constant = - FMPickerViewHeight;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)cancelButtonClick{
    [self hide];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.pickerBottomHeight.constant = - FMPickerViewHeight;
}

- (void)setItems:(NSMutableArray *)items{
    _items = items;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.linkageType == FMPickerViewLinkageForbidType) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            return arr.count;
        } else {
            return 0;
        }
    }
    NSArray *items = self.items;
    NSInteger row = [pickerView selectedRowInComponent:0];
    FMPickerItem *item = nil;
    if (row < self.items.count) {
        item = self.items[[pickerView selectedRowInComponent:0]];
    } else {
        return 0;
    }
    if (component == 1) {
        items = item.subItems;
    } else {
        for (int i = 1; i <= component; i++) {
            NSInteger selectRow = [pickerView selectedRowInComponent:component];
            item = items[selectRow];
            items = item.subItems;
        }
    }
    return items.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UILabel alloc] init];
    }
    NSString *name = nil;
    
    if (self.linkageType == FMPickerViewLinkageForbidType) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            if (row < arr.count) {
                FMPickerItem *item = arr[row];
                name = item.name;
            }
        } else {
            name = @"";
        }
    } else {
        if (component == 0) {
            FMPickerItem *item = self.items[row];
            name = item.name;
        } else {
            FMPickerItem *item = self.items[[self.pickerView selectedRowInComponent:0]];
            for (NSInteger i = 1; i <= component; i++) {
                if (row < item.subItems.count) {
                    item = item.subItems[row];
                    name = item.name;
                }
            }
        }
    }
    UILabel *label = (UILabel *)view;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = name;
    label.font = [UIFont systemFontOfSize:[self fontSize]];
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return SCREEN_WIDTH / self.components;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [self rowHeight];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.linkageType == FMPickerViewLinkageForbidType) {
        return;
    }
    self.userInteractionEnabled = NO;
    FMPickerItem *item = self.items[[pickerView selectedRowInComponent:0]];
    NSArray *items = item.subItems;
//    if (items && items.count > 0){
//        
//    }
    for (int i = 1; i <= component; i++) {
        NSInteger selectRow = [pickerView selectedRowInComponent:component];
        if (selectRow < items.count) {
             item = items[selectRow];
        }
    }
    if (component < self.components - 1) {
            [pickerView reloadComponent:component+1];
    }
    self.userInteractionEnabled = YES;
}

- (CGFloat)fontSize{
    return [self rowHeight] / 2;
}

- (CGFloat)rowHeight{
    if (self.components == 1 && self.linkageType == FMPickerViewLinkageNormalType) {
        switch (self.items.count) {
            case 2:
                return 42;
                break;
            case 3:
                return 38;
                break;
            case 4:
                return 34;
                break;
            default:
                return 30;
                break;
        }
    }
    return 30;
}

@end
