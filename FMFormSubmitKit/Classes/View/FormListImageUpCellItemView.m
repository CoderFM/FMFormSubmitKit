//
//  FormListImageUpCellItemView.m
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import "FormListImageUpCellItemView.h"

@implementation FormListImageUpCellItemView{
    FormListImageSelectModel *_model;
    FormListImageUpCellItemClick _clickBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setModel:(FormListImageSelectModel *)model{
    _model = model;
}

- (FormListImageSelectModel *)model{
    return _model;
}

- (void)setClickBlock:(FormListImageUpCellItemClick)clickBlock{
    _clickBlock = clickBlock;
}

- (FormListImageUpCellItemClick)clickBlock{
    return _clickBlock;
}

- (void)delButtonClick{
    !self.clickBlock ?: self.clickBlock(NO, self.model);
}

- (void)addImageClick{
    !self.clickBlock ?: self.clickBlock(YES, self.model);
}

@end
