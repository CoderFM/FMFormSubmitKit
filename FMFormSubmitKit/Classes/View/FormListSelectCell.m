//
//  FormListSelectCell.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/29.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListSelectCell.h"
#import "FormListSelectModel.h"

@interface FormListSelectCell ()

@end

@implementation FormListSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *btnView = [[UIView alloc] init];
        [self.contentView insertSubview:btnView atIndex:0];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
            make.right.mas_equalTo(-FormCellLRMargin);
        }];
        self.btnView = btnView;
    }
    return self;
}

- (void)btnSelectClick:(UIButton *)sender{
    self.selectBtn = sender;
    FormListSelectModel *selModel = (FormListSelectModel *)self.model;
    selModel.selectIndex = sender.tag;
}

- (void)setSelectBtn:(UIButton *)selectBtn{
    _selectBtn.selected = NO;
    _selectBtn = selectBtn;
    _selectBtn.selected = YES;
}

- (void)setModel:(FormListSelectModel *)model{
    [super setModel:model];
    [self createBtns:model.selects selectIndex:model.selectIndex];
}

- (void)createBtns:(NSArray *)titles selectIndex:(NSInteger)select{
    
    [self.btnView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    id left = self.contentView.mas_right;
    
    for (int i = 0; i<titles.count; i++) {
        NSInteger index = titles.count - 1 - i;
        NSString *title = titles[index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = FormCellTitleFont;
        [btn setTitle:[NSString stringWithFormat:@"   %@", title] forState:UIControlStateNormal];
        [btn setTitleColor:FormCellTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:FormCellTitleColor forState:UIControlStateSelected];
        [btn setImage:FormSelectCellNormalImage forState:UIControlStateNormal];
        [btn setImage:FormSelectCellSelectImage forState:UIControlStateSelected];
        if (self.model.convertSelect.configurationBtn) {
            self.model.convertSelect.configurationBtn(i, btn, title);
        }
        [btn addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(left).offset(-FormCellLRMargin);
            make.top.bottom.equalTo(@0);
        }];
        
        left = btn.mas_left;
        if (index == select) {
            self.selectBtn = btn;
        }
    }
}

@end
