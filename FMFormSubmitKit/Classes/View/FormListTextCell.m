//
//  FormListTextCell.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListTextCell.h"
#import "FormListTextModel.h"
#import "FormListConfigure.h"

@interface FormListTextCell()<UITextFieldDelegate>
@property(nonatomic, weak)UITextField *textF;
@property(nonatomic, weak)UIButton *eyeBtn;
@end

@implementation FormListTextCell

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
            make.right.mas_equalTo(-FormTextCellTFLMagin);
            make.width.mas_equalTo(Form_BaseSize(30 + 16));
        }];
        self.eyeBtn = eye;
    }
    return self;
}

- (void)setModel:(FormListTextModel *)model{
    [super setModel:model];
    
    self.textF.textColor = model.textColor;
    self.textF.font = model.textFont;
    self.textF.placeholder = model.placehoder;
    self.textF.text = model.text;
    self.textF.keyboardType = model.keyboardType;
    self.textF.textAlignment = model.alignment;
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(model.textFLeftMargin);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.bottomLineHeight);
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

- (void)textFieldTextDidChange:(NSNotification *)noti{
    FormListTextModel *model = (FormListTextModel *)self.model;
    
    if (self.textF.isChineseInput) {
        [self.textF matchWithPattern:model.inputPredicate];
    }
    
    model.text = self.textF.text;
    if (!model.isSelect) {
        model.value = model.text;
    }
    
    if (![self.textF hasInputPinYin]) {
        if (model.limitCount > 0) {
            if (self.textF.text.length > model.limitCount) {
                self.textF.text = [self.textF.text substringToIndex:model.limitCount];
                model.text = self.textF.text;
            }
        }
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
