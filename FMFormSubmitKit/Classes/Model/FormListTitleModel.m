//
//  FormListTitleModel.m
//  FormSubmitList
//
//  Created by 郑桂华 on 2020/4/18.
//  Copyright © 2020 郑桂华. All rights reserved.
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

@end
