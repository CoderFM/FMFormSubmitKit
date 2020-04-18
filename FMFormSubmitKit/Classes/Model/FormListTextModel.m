//
//  FormListTextModel.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListTextModel.h"
#import "FormListTextCell.h"
#import "FormListTextVCell.h"

@implementation FormListTextModel

- (instancetype)init{
    if (self = [super init]) {
        self.cellHeight = FormTextCellDefaultHeight;
        self.textFLeftMargin = FormTextCellTFLMagin;
        self.reuseKey = NSStringFromClass([FormListTextCell class]);
        self.alignment = NSTextAlignmentRight;
        self.titleFont = FormCellTitleFont;
        self.textFont = FormCellTFTVFont;
        self.titleColor = FormCellTitleColor;
    }
    return self;
}

+ (instancetype)modelWithPlaceholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type hasRight:(BOOL)hasRight righrContent:(id _Nullable)rightContent title:(NSString *)title{
    FormListTextModel *model = [[self alloc] init];
    model.title = title;
    model.placehoder = placeholder;
    model.keyboardType = type;
    model.hasRight = hasRight;
    model.rightC = rightContent;
    return model;
}

+ (instancetype)modelWithTVPlaceholder:(NSString *)placeholder title:(NSString *)title{
    FormListTextModel *model = [[self alloc] init];
    model.title = title;
    model.placehoder = placeholder;
    model.cellHeight = FormTextVCellDefaultHeight;
    model.reuseKey = NSStringFromClass([FormListTextVCell class]);
    return model;
}

+ (instancetype)modelShowWithTitle:(NSString *)title text:(NSString *)text aligment:(NSTextAlignment)aligment textFLeftMargin:(CGFloat)textFLeftMargin{
    FormListTextModel *model = [[self alloc] init];
    model.title = title;
    model.text = text;
    model.alignment = aligment;
    model.textFLeftMargin = textFLeftMargin;
    return model;
}

- (void)setText:(NSString *)text{
    _text = text;
    [[NSNotificationCenter defaultCenter] postNotificationName:FormSubmitModelValueChangeNotiKey object:self];
}

- (void)reloadTVHeight{
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(Form_SCREEN_WIDTH - self.textFLeftMargin - FormCellLRMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FormCellTFTVFont} context:nil].size.height;
    CGFloat lineH = FormCellTFTVFont.lineHeight;
    CGFloat margin = FormTextCellDefaultHeight - lineH;
    if (textH + margin < FormTextCellDefaultHeight) {
        self.cellHeight = FormTextCellDefaultHeight;
    } else {
        self.cellHeight = textH + margin;
    }
}

- (BOOL)verifySuccess:(BOOL)alert{
    BOOL success = YES;
    if (self.verifyBlock) {
        success = self.verifyBlock(self.text);
    } else {
        if (self.verifyPredicate && self.verifyPredicate.length > 0) {
            success = [self.text verifyPredicate:self.verifyPredicate];
        } else {
            success = self.text.length > 0;
        }
    }
    if (!success && alert) {
        FormVerifyFailAlert(self.placehoder);
    }
    return success;
}

- (id)submitValue{
    if (self.submitValueBlock) {
        return self.submitValueBlock(self);
    }
    return self.value;
}

@end

@implementation FormListBaseModel (ConvertText)

- (FormListTextModel *)convertText{
    if ([self isKindOfClass:[FormListTextModel class]]) {
        return (FormListTextModel *)self;
    }
    return nil;
}

@end
