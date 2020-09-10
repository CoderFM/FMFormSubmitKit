//
//  FormListBaseCell.m
//  YaLeGou
//
//  Created by 周发明 on 2019/12/14.
//  Copyright © 2019 y. All rights reserved.
//

#import "FormListBaseCell.h"
#import "FormListBaseModel.h"

NSInteger initCount = 0;

@implementation FormListBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = FormCellBottomLineColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Form_BaseSize(0));
            make.right.mas_equalTo(-Form_BaseSize(0));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(FormCellBottomLineDefaultHeight);
        }];
        self.bottomLineView = line;
        initCount += 1;
        NSLog(@"initCount: %ld", initCount);
    }
    return self;
}

- (void)setModel:(FormListBaseModel *)model{
    _model = model;
    self.contentView.backgroundColor = model.contentBg;
    self.bottomLineView.backgroundColor = model.bottomLineBg;
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.bottomLineHeight);
        make.left.mas_equalTo(model.bottomLineLMargin);
        make.right.mas_equalTo(-model.bottomLineRMargin);
        make.bottom.mas_equalTo(-model.bottomLineBMargin);
    }];
    if (model.configureCell) {
        model.configureCell(self);
    }
}

@end
