//
//  FormListTextModel.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListTextModel : FormListTitleModel

///NSString  NSAttributeString
@property(nonatomic, copy)id placehoder;
///NSString  NSAttributeString
@property(nonatomic, copy)id text;
///存储一些值
@property(nonatomic, copy)id value;
@property(nonatomic, assign)UIKeyboardType keyboardType;
@property(nonatomic, assign)BOOL hasRight;
///支持UIImage  NSString NSAttributeString
@property(nonatomic, strong)id rightC;
@property(nonatomic, assign)BOOL isSelect;
@property(nonatomic, assign)NSTextAlignment alignment;

@property(nonatomic, strong)UIFont *textFont;

@property(nonatomic, strong)UIColor *textColor;

@property(nonatomic, strong)UIColor *placeholderColor;
@property(nonatomic, strong)UIColor *textTintColor;

@property(nonatomic, assign)CGFloat textFLeftMargin;
@property(nonatomic, assign)CGFloat textVTopMargin;

@property(nonatomic, assign)BOOL eyeEnable;
@property(nonatomic, assign)BOOL isSecret;

@property(nonatomic, copy)NSString *verifyPredicate;
@property(nonatomic, copy)NSString *inputPredicate;
@property(nonatomic, assign)NSInteger limitCount;

@property(nonatomic, copy)BOOL(^verifyBlock)(id text);

@property(nonatomic, copy)void(^selectBlock)(id tftv, FormListTextModel *model);
@property(nonatomic, copy)void(^configurationBlock)(id tftv);

@property(nonatomic, copy)void(^textLengthChange)(NSInteger length);

+ (instancetype)modelWithPlaceholder:(id)placeholder keyboardType:(UIKeyboardType)type hasRight:(BOOL)hasRight righrContent:(id _Nullable)rightContent title:(id)title;

+ (instancetype)modelWithTVPlaceholder:(id)placeholder title:(id)title;

+ (instancetype)modelShowWithTitle:(id)title text:(id)text aligment:(NSTextAlignment)aligment textFLeftMargin:(CGFloat)textFLeftMargin;

- (void)reloadTVHeight;

- (void)setTextStyle:(NSTextAlignment)aligment textFont:( UIFont * _Nullable )textFont textColor:(UIColor *_Nullable)textColor;
- (void)setInputLimit:(NSString *)inputPredicate count:(NSInteger)count;
@end

@interface FormListBaseModel (ConvertText)

@property(readonly)FormListTextModel *convertText;

@end


NS_ASSUME_NONNULL_END
