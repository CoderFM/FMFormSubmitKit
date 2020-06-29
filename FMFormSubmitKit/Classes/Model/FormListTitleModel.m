//
//  FormListTitleModel.m
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/18.
//  Copyright © 2020 周发明. All rights reserved.
//

#import "FormListTitleModel.h"
#import "FormListTitleCell.h"

@implementation FormListTitleModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = FormTextCellDefaultHeight;
        self.titleFont = FormCellTitleFont;
        self.titleColor = FormCellTitleColor;
        self.titleAligment = NSTextAlignmentLeft;
        self.cellClassName = NSStringFromClass([FormListTitleCell class]);
    }
    return self;
}

+ (instancetype)modelWithTitle:(id)title{
    FormListTitleModel *model = [[self alloc] init];
    model.title = title;
    return model;
}

@end
