//
//  FormListBaseModel.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListBaseModel.h"

@implementation FormListBaseModel

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight bottomLineHeight:(CGFloat)bottomLineHeight bottomLineLRMargin:(CGFloat)bottomLineLRMargin{
    FormListBaseModel *model = [[self alloc] init];
    model.cellHeight = cellHeight;
    model.bottomLineHeight = bottomLineHeight;
    model.bottomLineLRMargin = bottomLineLRMargin;
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bottomLineLRMargin = FormCellLRMargin;
        self.bottomLineHeight = FormCellBottomLineDefaultHeight;
        self.reuseKey = @"FormListBaseCell";
        self.contentBg = [UIColor whiteColor];
        self.bottomLineBg = FormCellBottomLineColor;
    }
    return self;
}

- (BOOL)verifySuccess:(BOOL)alert{
    return YES;
}

- (id)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    return FormSubmitDefaultValue;
}

@end
