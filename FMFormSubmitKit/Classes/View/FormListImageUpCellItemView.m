//
//  FormListImageUpCellItemView.m
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import "FormListImageUpCellItemView.h"
#import "FormListImageSelectModel.h"

@implementation FormListImageUpCellItemView{
    FormListImageSelectModel *_model;
    FormListImageUpCellItemMutibleClick _clickMutibleBlock;
    FormListImageUpCanSelectMaxCount _selectMaxBlock;
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

- (void)setClickMutibleBlock:(FormListImageUpCellItemMutibleClick)clickMutibleBlock{
    _clickMutibleBlock = clickMutibleBlock;
}

- (FormListImageUpCellItemMutibleClick)clickMutibleBlock{
    return _clickMutibleBlock;
}

- (void)setSelectMaxCount:(FormListImageUpCanSelectMaxCount)selectMaxCount{
    _selectMaxBlock = selectMaxCount;
}

- (FormListImageUpCanSelectMaxCount)selectMaxCount{
    return _selectMaxBlock;
}

- (void)delButtonClick{
    !self.clickMutibleBlock ?: self.clickMutibleBlock(NO, self.model, nil);
}

- (void)addImageClick{
    NSInteger maxCount = self.selectMaxCount?self.selectMaxCount(self.model):1;
    NSLog(@"maxCount: %ld", maxCount);
    !self.clickMutibleBlock ?: self.clickMutibleBlock(YES, self.model, @[[[UIImage alloc] init], [[UIImage alloc] init], [[UIImage alloc] init]]);
}

@end
