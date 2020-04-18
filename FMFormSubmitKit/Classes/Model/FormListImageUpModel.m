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

@implementation FormListImageUpModel
- (CGFloat)cellHeight{
    return 100;
}
- (instancetype)init{
    if (self = [super init]) {
        self.reuseKey = NSStringFromClass([FormListImageUpCell class]);
        self.bottomLineHeight = 0.5;
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
        if (obj.imageId == nil && obj.imageId.length > 0) {
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
