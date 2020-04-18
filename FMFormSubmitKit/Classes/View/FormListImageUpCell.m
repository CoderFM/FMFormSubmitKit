//
//  FormListImageUpCell.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListImageUpCell.h"
#import "FormListImageUpModel.h"
#import "FormListImageSelectModel.h"

typedef void(^FormListImageUpCellItemClick)(BOOL add, FormListImageSelectModel *model);

@protocol FormListImageUpCellItemDelegate <NSObject>

@property(nonatomic, strong)FormListImageSelectModel *model;
@property(nonatomic, copy)FormListImageUpCellItemClick clickBlock;

@end


//#import <TZImagePickerController.h> TZImagePickerControllerDelegate

@interface FormListImageUpCellItemView : UIView< FormListImageUpCellItemDelegate>
@property(nonatomic, weak)UIImageView *placehodelImageView;
@property(nonatomic, weak)UIButton *addButton;
@property(nonatomic, weak)UIButton *delButton;
@property(nonatomic, weak)UILabel *introLabel;
@end

@implementation FormListImageUpCellItemView{
    FormListImageSelectModel *_model;
    FormListImageUpCellItemClick _clickBlock;
}

-(UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:FormUpCellDefaultImage]];
//        imageV.backgroundColor = BackgroundGrayColor;
//        [self addSubview:imageV];
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(@0);
//            make.height.mas_equalTo(Form_BaseSize(102));
//        }];
//        self.placehodelImageView = imageV;
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.textColor = FormCellTitleColor;
//        label.font = FormUpCellIntroFont;
//        [self addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(@0);
//            make.top.equalTo(imageV.mas_bottom).offset(Form_BaseSize(5));
//        }];
//        self.introLabel = label;
//        
//        {
//            UIButton *btn = [[UIButton alloc] init];
//            btn.titleLabel.font = SystemFontOfSize(30);
//            [btn addTarget:self action:@selector(addImageWithSender:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:btn];
//            [btn setTitle:@"+" forState:UIControlStateNormal];
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.top.bottom.equalTo(imageV);
//            }];
//            self.addButton = btn;
//        }
//    }
//    return self;
//}
//
//- (void)setModel:(FormListImageSelectModel *)model{
//    _model = model;
//    
//    self.introLabel.text = model.title;
//    self.placehodelImageView.image = model.placeholderImage;
//    if (model.image) {
//        [self.addButton setTitle:@"" forState:UIControlStateNormal];
//        [self.addButton setBackgroundImage:model.image forState:UIControlStateNormal];
//    } else if (model.imageUrl && model.imageUrl.length > 0) {
//         [self.addButton setTitle:@"" forState:UIControlStateNormal];
//        [self.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imageUrl] forState:UIControlStateNormal];
//    } else {
//         [self.addButton setTitle:@"+" forState:UIControlStateNormal];
//    }
//}
//
//- (FormListImageSelectModel *)model{
//    return _model;
//}
//
//- (void)setClickBlock:(FormListImageUpCellItemClick)clickBlock{
//    _clickBlock = clickBlock;
//}
//
//- (FormListImageUpCellItemClick)clickBlock{
//    return _clickBlock;
//}
//
//- (void)delButtonClick{
//    !self.clickBlock ?: self.clickBlock(NO, self.model);
//}
//
//- (void)addImageWithSender:(UIButton *)sender{
//    QKWeakSelf;
//    [[QK_ImagePickerManager manager] presentPickerFrom:[self getCurrentVC] maxImageCount:1 complete:^(NSArray * _Nullable images) {
//        if (images.count > 0) {
//            [weakSelf.addButton setBackgroundImage:images[0] forState:UIControlStateNormal];
//            weakSelf.model.image = images[0];
//            !weakSelf.clickBlock ?: self.clickBlock(YES, self.model);
//        }
//    }];
//}

@end


@interface FormListImageUpCell ()

@property(nonatomic, weak)UIButton *currentClickBtn;

@end

@implementation FormListImageUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        {
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(FormCellLRMargin);
                make.top.mas_equalTo(FormCellTVTitleTopMargin);
            }];
        }
        {
            UIView *view = [[UIView alloc] init];
            view.clipsToBounds = YES;
            [self.contentView addSubview:view];
            self.btnContentView = view;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.bottomLineView.mas_top);
                make.left.right.equalTo(@0);
                make.top.equalTo(self.contentView).offset(Form_BaseSize(10));
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
    for (int i = 0; i < model.images.count; i++) {
        FormListImageSelectModel *btnModel = model.images[i];
        FormListImageUpCellItemView *view = [[FormListImageUpCellItemView alloc] init];
//        view.layer.borderColor = FormCellBottomLineColor.CGColor;
//        view.layer.borderWidth = 1;
        view.model = btnModel;
        __weak typeof(self) weakSelf = self;
        [view setClickBlock:^(BOOL add, FormListImageSelectModel *model) {
            FormListImageUpModel *upModel = (FormListImageUpModel *)weakSelf.model;
            if (upModel.canDynamicAdd) {
                NSInteger index = [upModel.images indexOfObject:model];
                if (add) {
                    if (upModel.images.count < upModel.maxCount) {// 可以再添加
                        if (index == upModel.images.count - 1) {
                            NSMutableArray *arrm = [NSMutableArray arrayWithArray:upModel.images];
                            FormListImageSelectModel *addModel = [[FormListImageSelectModel alloc] init];
                            addModel.title = model.title;
                            [arrm addObject:addModel];
                            upModel.images = [NSArray arrayWithArray:arrm];
                        }
                    }
                    if (upModel.selectImageBlock) {
                        upModel.selectImageBlock(model, model.image);
                    }
                } else {
                    NSMutableArray *arrm = [NSMutableArray arrayWithArray:upModel.images];
                    [arrm removeObject:model];
                    if (index == upModel.images.count - 1) {
                        FormListImageSelectModel *addModel = [[FormListImageSelectModel alloc] init];
                        addModel.title = model.title;
                        [arrm addObject:addModel];
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
        [self.btnContentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(FormUpCellImageLRMagin + (FormUpCellImageWidth + FormUpCellImageSpace) * (i % 2));
//            make.top.mas_equalTo((FormUpCellImageHeight + FormUpCellImageSpace) * (i / 2));
//            make.width.mas_equalTo(FormUpCellImageWidth);
//            make.height.mas_equalTo(FormUpCellImageHeight);
        }];
    }
}

@end
