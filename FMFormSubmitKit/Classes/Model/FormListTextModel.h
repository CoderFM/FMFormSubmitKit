//
//  FormListTextModel.h
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListTextModel : FormListTitleModel


@property(nonatomic, copy)NSString *placehoder;
@property(nonatomic, copy)NSString *text;
@property(nonatomic, copy)NSString *value;
@property(nonatomic, assign)UIKeyboardType keyboardType;
@property(nonatomic, assign)BOOL hasRight;
@property(nonatomic, strong)id rightC;
@property(nonatomic, assign)BOOL isSelect;
@property(nonatomic, assign)NSTextAlignment alignment;

@property(nonatomic, strong)UIFont *textFont;

@property(nonatomic, strong)UIColor *textColor;

@property(nonatomic, assign)CGFloat textFLeftMargin;
@property(nonatomic, assign)CGFloat textVTopMargin;

@property(nonatomic, assign)BOOL eyeEnable;
@property(nonatomic, assign)BOOL isSecret;

@property(nonatomic, copy)NSString *verifyPredicate;
@property(nonatomic, copy)NSString *inputPredicate;
@property(nonatomic, assign)NSInteger limitCount;

@property(nonatomic, copy)BOOL(^verifyBlock)(NSString *text);

@property(nonatomic, copy)void(^selectBlock)(UITextField *tf, FormListTextModel *model);
@property(nonatomic, copy)void(^configurationBlock)(UITextField *tf);

+ (instancetype)modelWithPlaceholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type hasRight:(BOOL)hasRight righrContent:(id _Nullable)rightContent title:(NSString *)title;

+ (instancetype)modelWithTVPlaceholder:(NSString *)placeholder title:(NSString *)title;

+ (instancetype)modelShowWithTitle:(NSString *)title text:(NSString *)text aligment:(NSTextAlignment)aligment textFLeftMargin:(CGFloat)textFLeftMargin;

- (void)reloadTVHeight;

@end

@interface FormListBaseModel (ConvertText)

@property(readonly)FormListTextModel *convertText;

@end


NS_ASSUME_NONNULL_END
