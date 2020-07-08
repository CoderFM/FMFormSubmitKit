//
//  FormListTextCell.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTextCell.h"
#import "FormListTextModel.h"
#import "FormListConfigure.h"

#import "NSString+FormEmoji.h"

@interface FormListTextCell()<UITextFieldDelegate>

@end

@implementation FormListTextCell

#pragma mark ----- UI_APPEARANCE_SELECTOR ----

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *tf = [[UITextField alloc] init];
        tf.font = FormCellTFTVFont;
        tf.keyboardType = UIKeyboardTypeDefault;
        tf.textColor = FormCellTFTVColor;
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentRight;
        tf.rightViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:tf];
        self.textF = tf;
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FormTextCellTFLMagin);
            make.right.mas_equalTo(-FormCellLRMargin);
            make.top.bottom.mas_equalTo(0);
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:tf];
        
        UIButton *eye = [[UIButton alloc] init];
        eye.hidden = YES;
        [eye setImage:FormEyeNormalImage forState:UIControlStateNormal];
        [eye setImage:FormEyeCellSelectImage forState:UIControlStateSelected];
        [eye addTarget:self action:@selector(eyeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:eye];
        [eye mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(tf);
        }];
        self.eyeBtn = eye;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldRightViewTap)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setModel:(FormListTextModel *)model{
    [super setModel:model];
    
    
     self.textF.inputPredicate = model.inputPredicate;
     self.textF.limitCount = model.limitCount;
    
    self.textF.textColor = model.textColor;
    self.textF.font = model.textFont;
    self.textF.placeholder = model.placehoder;
    self.textF.text = model.text;
    self.textF.keyboardType = model.keyboardType;
    self.textF.textAlignment = model.alignment;
    [self.textF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(model.textFLeftMargin);
    }];
    
    if (model.hasRight && model.rightC) {
        UIView *view = [[UIView alloc] init];
        if ([model.rightC isKindOfClass:[UIImage class]]) {
            view.bounds = CGRectMake(0, 0, FormCellArrowLMagin + [(UIImage *)model.rightC size].width, model.cellHeight);
            UIImageView *image = [[UIImageView alloc] initWithImage:model.rightC];
            image.contentMode = UIViewContentModeRight;
            [view addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(FormCellArrowLMagin);
                make.right.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
            }];
            self.textF.rightView = view;
        } else if ([model.rightC isKindOfClass:[NSString class]] || [model.rightC isKindOfClass:[NSAttributedString class]]) {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentRight;
            CGFloat width;
            if ([model.rightC isKindOfClass:[NSString class]]) {
                width = [(NSString *)model.rightC boundingRectWithSize:CGSizeMake(MAXFLOAT, model.cellHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:model.textFont} context:nil].size.width;
                label.text = model.rightC;
                label.textColor = model.textColor;
                label.font = model.textFont;
            } else {
                width = [(NSAttributedString *)model.rightC boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
                label.attributedText = model.rightC;
            }
            view.bounds = CGRectMake(0, 0, FormCellArrowLMagin + width, model.cellHeight);
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(FormCellArrowLMagin);
                make.right.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
            }];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldRightViewTap)];
            [view addGestureRecognizer:tap];
            self.textF.rightView = view;
        } else {
            self.textF.rightView = nil;
        }
    } else {
        self.textF.rightView = nil;
    }
    !model.configurationBlock ? : model.configurationBlock(self.textF);
    if (model.eyeEnable) {
        self.eyeBtn.hidden = NO;
        self.textF.secureTextEntry = model.isSecret;
    } else {
        self.eyeBtn.hidden = YES;
        self.textF.secureTextEntry = NO;
    }
 
}

- (void)textFieldRightViewTap{
    if (self.model.convertText) {
        if (self.model.convertText.isSelect) {
            !self.model.convertText.selectBlock?:self.model.convertText.selectBlock(self.textF, self.model.convertText);
        }
    }
}

- (void)textFieldTextDidChange:(NSNotification *)noti{
    FormListTextModel *model = (FormListTextModel *)self.model;
    
    [FormVerifyManager handleTextFieldTextDidChange:self.textF];
    
    model.text = self.textF.text;
    if (!model.isSelect) {
        model.value = model.text;
    }
    
    if (model.textLengthChange) {
        model.textLengthChange(self.textF.text.length);
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    FormListTextModel *model = (FormListTextModel *)self.model;
    if (model.isSelect) {
        !model.selectBlock ?: model.selectBlock(self.textF, model);
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    FormListTextModel *model = (FormListTextModel *)self.model;
    if (textField.isChineseInput) {
        return YES;
    }
    if (model.inputPredicate && string.length > 0) {
        return [string verifyPredicate:model.inputPredicate];
    } else {
        return YES;
    }
}

- (void)eyeClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    FormListTextModel *model = (FormListTextModel *)self.model;
    model.isSecret = !sender.isSelected;
    self.textF.secureTextEntry = !sender.isSelected;
}

@end
