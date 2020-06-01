//
//  FormListImageUpModel.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListImageUpModel.h"
#import "FormListImageUpCell.h"
#import "FormListImageSelectModel.h"
#import "FormListUpImageConfigure.h"

@interface FormListImageUpModel ()

@property(nonatomic, assign)CGFloat interiorHeight;

@end

@implementation FormListImageUpModel
- (CGFloat)cellHeight{
    return self.interiorHeight;
}

- (CGFloat)interiorHeight{
    NSInteger count = self.canDynamicAdd ? (self.maxCount > 0 ? MIN(self.images.count, self.maxCount) : self.images.count) : self.images.count;
    _interiorHeight = [self.imageConfigure heightWithCount:count] + self.bottomLineHeight;
    return _interiorHeight;
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
    if (self.canDynamicAdd) {
        return YES;
    }
    __block BOOL success = YES;
    __block NSString *message = @"";
    __weak typeof(self) weakSelf = self;
    [self.images enumerateObjectsUsingBlock:^(FormListImageSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj verifySuccess]) {
            success = NO;
            message = [NSString stringWithFormat:@"%@ %@\n未上传", weakSelf.title, obj.title];
            *stop = YES;
        }
    }];
    if (!success && alert) {
        FormVerifyFailAlert(message);
    }
    return success;
}

- (id)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    NSMutableArray *arrM = [NSMutableArray array];
    [self.images enumerateObjectsUsingBlock:^(FormListImageSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.imageUrl) {
            [arrM addObject:obj.imageUrl];
        }
    }];
    return arrM;
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
