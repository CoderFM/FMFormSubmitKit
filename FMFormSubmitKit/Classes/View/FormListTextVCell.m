//
//  FormListTextVCell.m
//  Project_ZhongAnXiao
//
//  Created by 周发明 on 2019/11/30.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTextVCell.h"
#import "FormTextView.h"
#import "FormListTextModel.h"
#import "UITextView+FormExtension.h"

#import "NSString+FormEmoji.h"

@interface FormListTextVCell ()<UITextViewDelegate>

@end

@implementation FormListTextVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FormCellLRMargin);
            make.top.mas_equalTo(FormCellTVTitleTopMargin);
        }];
        
        FormTextView *tf = [[FormTextView alloc] init];
        tf.delegate = self;
        tf.textColor = FormCellTFTVColor;
        tf.placeholderTextColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
        tf.font = FormCellTFTVFont;
        tf.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FormCellLRMargin - 5);
            make.right.mas_equalTo(-FormCellLRMargin + 5);
            make.top.mas_equalTo(FormCellTVTitleTopMargin + FormCellTitleFont.lineHeight + FormCellTVTitleTopMargin - 8);
            make.bottom.mas_equalTo(self.bottomLineView.mas_top);
        }];
        self.textV = tf;
    }
    return self;
}

- (void)setModel:(FormListTextModel *)model{
    [super setModel:model];
    
    self.textV.limitCount = model.limitCount;
    self.textV.inputPredicate = model.inputPredicate;
    
    self.textV.font = model.textFont;
    self.textV.textColor = model.textColor;
    self.textV.placeholder = model.placehoder;
    self.textV.textAlignment = model.alignment;
    self.textV.text = model.text;
    if (model.textVTopMargin > 0) {
        [self.textV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(model.textVTopMargin - 8);
        }];
    } else {
        [self.textV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FormCellTVTitleTopMargin + FormCellTitleFont.lineHeight + FormCellTVTitleTopMargin - 8);
        }];
    }
    if (model.textFLeftMargin > 0) {
        [self.textV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(model.textFLeftMargin - 8);
        }];
    }
    if (model.configurationBlock) {
        model.configurationBlock(self.textV);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    FormListTextModel *model = (FormListTextModel *)self.model;
    if (model.isSelect) {
        !model.selectBlock ?: model.selectBlock(self.textV, model);
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    FormListTextModel *model = (FormListTextModel *)self.model;
    if (textView.isChineseInput) {
        return YES;
    }
    if (model.inputPredicate && text.length > 0) {
        return [text verifyPredicate:model.inputPredicate];
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    FormListTextModel *model = (FormListTextModel *)self.model;
    
    [FormVerifyManager handleTextViewTextDidChange:self.textV];
    
    model.text = self.textV.text;
    if (!model.isSelect) {
        model.value = model.text;
    }
    
    if (model.textLengthChange) {
        model.textLengthChange(self.textV.text.length);
    }
}

@end
