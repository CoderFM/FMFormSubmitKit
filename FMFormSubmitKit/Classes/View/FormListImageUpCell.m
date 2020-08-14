//
//  FormListImageUpCell.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListImageUpCell.h"
#import "FormListImageUpModel.h"
#import "FormListImageSelectModel.h"

#import "FormListImageUpCellItemView.h"
#import "FormListUpImageConfigure.h"

@interface FormListImageUpCell ()

@property(nonatomic, assign)BOOL scrollToLast;

@end

@implementation FormListImageUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        {
            UIScrollView *view = [[UIScrollView alloc] init];
            view.clipsToBounds = YES;
            [self.contentView addSubview:view];
            self.btnContentView = view;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.bottomLineView.mas_top);
                make.left.right.equalTo(@0);
                make.top.equalTo(self.contentView).offset(0);
            }];
        }
    }
    return self;
}

- (void)setModel:(FormListImageUpModel *)model{
    [super setModel:model];
    [self.btnContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if (model.imageConfigure.oneLineScroll) {
        CGFloat width = model.imageConfigure.inset.left + model.images.count * model.imageConfigure.imageWidth + (model.images.count - 1) * model.imageConfigure.imageItemSpace + model.imageConfigure.inset.right;
        self.btnContentView.contentSize = CGSizeMake(width, 0);
        [model.imageConfigure oneLineScrollMasonyMake];
        if (self.scrollToLast) {
            CGFloat scrollOffsetX = width - self.bounds.size.width;
            if (scrollOffsetX < 0) {
                scrollOffsetX = 0;
            }
            [self.btnContentView setContentOffset:CGPointMake(scrollOffsetX, 0) animated:YES];
        }
        self.scrollToLast = NO;
    } else {
        self.btnContentView.contentSize = CGSizeZero;
    }
    for (int i = 0; i < model.images.count; i++) {
        FormListImageSelectModel *btnModel = model.images[i];
        FormListImageUpCellItemView *view = [[model.imageConfigure.imageViewClass alloc] init];
        view.model = btnModel;
        __weak typeof(self) weakSelf = self;
        [view setClickMutibleBlock:^(BOOL add, FormListImageSelectModel * _Nonnull model, NSArray * _Nonnull images) {
            FormListImageUpModel *upModel = (FormListImageUpModel *)weakSelf.model;
            if (upModel.canDynamicAdd) {
                NSInteger index = [upModel.images indexOfObject:model];
                if (add) {
                    if (upModel.images.count < upModel.maxCount) {// 可以再添加
                        if (index == upModel.images.count - 1) {
                            NSMutableArray *arrm = [NSMutableArray arrayWithArray:upModel.images];
                            if (images.count > 1) {
                                NSInteger count = MIN(images.count - 1, upModel.maxCount - upModel.images.count);
                                for (int i = 0; i < count; i++) {
                                    FormListImageSelectModel *selModel = upModel.imageConfigure.createAddModel();
                                    selModel.image = images[i+1];
                                    [arrm addObject:selModel];
                                }
                            }
                            if (arrm.count < upModel.maxCount) {
                                [arrm addObject:upModel.imageConfigure.createAddModel()];
                            }
                            upModel.images = [NSArray arrayWithArray:arrm];
                            if (upModel.imageConfigure.oneLineScroll) {
                                weakSelf.scrollToLast = YES;
                            }
                        }
                    }
                    if (upModel.selectImageBlock) {
                        upModel.selectImageBlock(model, model.image);
                    }
                    if (upModel.selectMutibleBlock) {
                        upModel.selectMutibleBlock(model, images);
                    }
                } else {
                    NSMutableArray *arrm = [NSMutableArray arrayWithArray:upModel.images];
                    [arrm removeObject:model];
                    FormListImageSelectModel *lastModel = [arrm lastObject];
                    if (lastModel.image != nil) {
                        [arrm addObject:upModel.imageConfigure.createAddModel()];
                    }
                    if (arrm.count == 0) {
                        [arrm addObject:upModel.imageConfigure.createAddModel()];
                    }
                    upModel.images = [NSArray arrayWithArray:arrm];
                }
            } else {
                if (!add) {
                    model.image = nil;
                } else {
                    if (upModel.selectImageBlock) {
                        upModel.selectImageBlock(model, model.image);
                    }
                }
            }
            !upModel.refreshBlock ?: upModel.refreshBlock();
        }];
        [view setSelectMaxCount:^NSInteger(FormListImageSelectModel * _Nonnull model) {
            FormListImageUpModel *upModel = (FormListImageUpModel *)weakSelf.model;
            if (upModel.canDynamicAdd) {
                return upModel.maxCount - upModel.images.count + 1;
            } else {
                return 1;
            }
        }];
        [self.btnContentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            model.imageConfigure.masony_makeBlock(make, i);
        }];
    }
}

@end
