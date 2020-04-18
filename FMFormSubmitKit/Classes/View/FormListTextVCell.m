//
//  FormListTextVCell.m
//  Project_ZhongAnXiao
//
//  Created by 郑桂华 on 2019/11/30.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListTextVCell.h"
#import "FormTextView.h"
#import "FormListTextModel.h"

@interface FormListTextVCell ()
@property(nonatomic, weak)FormTextView *textV;
@end

@implementation FormListTextVCell

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FormCellLRMargin);
            make.top.mas_equalTo(FormCellTVTitleTopMargin);
        }];
        
        FormTextView *tf = [[FormTextView alloc] init];
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:tf];
    }
    return self;
}

- (void)setModel:(FormListTextModel *)model{
    [super setModel:model];
    
    self.textV.font = model.textFont;
    
    self.textV.placeholder = model.placehoder;
    self.textV.textAlignment = model.alignment;
    self.textV.text = model.text;
    self.textV.editable = !model.isSelect;
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
}

- (void)textViewTextDidChange:(NSNotification *)noti{
    FormListTextModel *model = (FormListTextModel *)self.model;
    model.text = self.textV.text;
    model.value = model.text;
}

@end
