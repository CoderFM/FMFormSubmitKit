//
//  FormListSelectModel.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/29.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListSelectModel.h"

#import "FormListSelectCell.h"

@implementation FormListSelectModel

- (instancetype)init{
    if (self = [super init]) {
        self.cellClassName = NSStringFromClass([FormListSelectCell class]);
        self.cellHeight = FormTextCellDefaultHeight;
    }
    return self;
}

- (BOOL)verifySuccess{
    return YES;
}

- (NSDictionary *)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    if (!self.submitKey) {
        return nil;
    }
    return @{self.submitKey:@(self.selectIndex)};
}

+ (instancetype)modelWithTitle:(NSString *)title{
    FormListSelectModel *model = [[self alloc] init];
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
