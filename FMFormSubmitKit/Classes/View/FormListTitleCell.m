//
//  FormListTitleCell.m
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/18.
//  Copyright © 2020 周发明. All rights reserved.
//

#import "FormListTitleCell.h"
#import "FormListTitleModel.h"

@interface FormListTitleCell ()

@end

@implementation FormListTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = FormCellTitleColor;
        label.font = FormCellTitleFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        self.titleLabel = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FormCellLRMargin);
            make.centerY.mas_equalTo(@0);
        }];
        
    }
    return self;
}

- (void)setModel:(FormListTitleModel *)model{
    [super setModel:model];
    
    self.titleLabel.font = model.titleFont;
    self.titleLabel.textColor = model.titleColor;
    self.titleLabel.textAlignment = model.titleAligment;
    
    if ([model.title isKindOfClass:[NSString class]]) {
        self.titleLabel.text = model.title;
    } else if ([model.title isKindOfClass:[NSAttributedString class]]) {
        self.titleLabel.attributedText = model.title;
    }
    
    if (model.masony_remakeBlock) {
        [self.titleLabel mas_remakeConstraints:model.masony_remakeBlock];
    }
}

@end
