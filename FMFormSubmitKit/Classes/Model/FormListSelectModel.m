//
//  FormListSelectModel.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/29.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListSelectModel.h"

#import "FormListSelectCell.h"

@implementation FormListSelectModel

- (instancetype)init{
    if (self = [super init]) {
        self.reuseKey = NSStringFromClass([FormListSelectCell class]);
        self.cellHeight = FormTextCellDefaultHeight;
    }
    return self;
}

- (BOOL)verifySuccess{
    return YES;
}

- (id)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    return @(self.selectIndex);
}

+ (instancetype)modelWithTitle:(NSString *)title{
    FormListSelectModel *model = [[FormListSelectModel alloc] init];
    model.title = title;
    return model;
}

@end

@implementation FormListBaseModel (ConvertSelect)

- (FormListSelectModel *)convertSelect{
    if ([self isKindOfClass:[FormListSelectModel class]]) {
        return (FormListSelectModel *)self;
    }
    return nil;
}

@end
