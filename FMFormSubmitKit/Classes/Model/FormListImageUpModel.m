//
//  FormListImageUpModel.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListImageUpModel.h"
#import "FormListImageUpCell.h"
#import "FormListImageSelectModel.h"
#import "FormListUpImageConfigure.h"

@interface FormListImageUpModel ()

@property(nonatomic, assign)CGFloat interiorHeight;

@end

@implementation FormListImageUpModel

+ (instancetype)modelWithCongigure:(FormListUpImageConfigure *)configure images:(NSArray<FormListImageSelectModel *> *)images{
    FormListImageUpModel *model = [[self alloc] init];
    model.imageConfigure = configure;
    model.images = images;
    return model;
}
+ (instancetype)modelDynamicAddWithCongigure:(FormListUpImageConfigure *)configure maxCount:(NSInteger)maxCount{
    FormListImageUpModel *model = [[self alloc] init];
    model.imageConfigure = configure;
    model.canDynamicAdd = YES;
    model.maxCount = maxCount;
    FormListImageSelectModel *selModel = [[FormListImageSelectModel alloc] init];
    selModel.placeholderImage = configure.placeholderImage;
    model.images = @[selModel];
    return model;
}

- (CGFloat)cellHeight{
    return self.interiorHeight;
}

- (CGFloat)interiorHeight{
    if (self.imageConfigure.oneLineScroll) {
        _interiorHeight = self.imageConfigure.inset.top + self.imageConfigure.imageHeight + self.imageConfigure.inset.bottom;
        return _interiorHeight;
    } else {
        NSInteger count = self.canDynamicAdd ? (self.maxCount > 0 ? MIN(self.images.count, self.maxCount) : self.images.count) : self.images.count;
        _interiorHeight = [self.imageConfigure heightWithCount:count] + self.bottomLineHeight;
        return _interiorHeight;
    }
}

- (instancetype)init{
    if (self = [super init]) {
        self.cellClassName = NSStringFromClass([FormListImageUpCell class]);
        self.bottomLineHeight = 0.5;
        self.imageConfigure = [FormListCellConfigure defaultConfigure].currentConfigure;
        self.maxCount = NSIntegerMax;
    }
    return self;
}

- (BOOL)verifySuccess:(BOOL)alert{
    if (self.canDynamicAdd && self.minCount == 0) {
        return YES;
    }
    __block BOOL success = YES;
    __block NSString *message = @"";
    __weak typeof(self) weakSelf = self;
    __block NSInteger selectCount = 0;
    [self.images enumerateObjectsUsingBlock:^(FormListImageSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj verifySuccess]) {
            success = NO;
            message = [NSString stringWithFormat:@"%@ %@\n未上传", weakSelf.title, obj.title];
            *stop = YES;
        } else {
            selectCount += 1;
        }
    }];
    if (self.canDynamicAdd) {
        if (selectCount > self.minCount) {
            return YES;
        } else {
            message = [NSString stringWithFormat:@"%@未上传", self.title];
        }
    }
    if (!success && alert) {
        FormVerifyFailAlert(message);
    }
    return success;
}

- (NSDictionary *)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    if (self.submitKey) {
        NSMutableArray *arrM = [NSMutableArray array];
        [self.images enumerateObjectsUsingBlock:^(FormListImageSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.imageUrl) {
                [arrM addObject:obj.imageUrl];
            }
        }];
        return @{self.submitKey:[arrM componentsJoinedByString:@"|"]};
    } else {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [self.images enumerateObjectsUsingBlock:^(FormListImageSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.imageUrl && obj.submitKey) {
                [result setValue:obj.imageUrl forKey:obj.submitKey];
            }
        }];
        return result;
    }
}

@end


@implementation FormListImageUpModel (ConvertImage)

- (FormListImageUpModel *)convertImage{
    if ([self isKindOfClass:[FormListImageUpModel class]]) {
        return (FormListImageUpModel *)self;
    }
    return nil;
}

@end
