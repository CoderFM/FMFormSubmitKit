//
//  FormListBaseModel.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListBaseModel.h"

@implementation FormListBaseModel

- (NSString *)reuseKey{
    if (_reuseKey == nil) {
        _reuseKey = self.cellClassName;
    }
    return _reuseKey;
}

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
        self.cellClassName = @"FormListBaseCell";
        self.contentBg = [UIColor whiteColor];
        self.bottomLineBg = FormCellBottomLineColor;
    }
    return self;
}

- (void)setLineHeight:(CGFloat)lineHeight leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin{
    self.bottomLineHeight = lineHeight;
    self.bottomLineLMargin = leftMargin;
    self.bottomLineRMargin = rightMargin;
}

- (void)setBottomLineLRMargin:(CGFloat)bottomLineLRMargin{
    _bottomLineLRMargin = bottomLineLRMargin;
    self.bottomLineRMargin = bottomLineLRMargin;
    self.bottomLineLMargin = bottomLineLRMargin;
}

- (BOOL)verifySuccess:(BOOL)alert{
    return YES;
}

@end
