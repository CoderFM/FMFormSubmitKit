//
//  FormListTitleModel.h
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/18.
//  Copyright © 2020 周发明. All rights reserved.
//

#import "FormListBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListTitleModel : FormListBaseModel
///可以NSString   NSAttrbuil..String
@property(nonatomic, copy)id title;

@property(nonatomic, assign)NSTextAlignment titleAligment;

@property(nonatomic, strong)UIColor *titleColor;

@property(nonatomic, strong)UIFont *titleFont;

@property(nonatomic, copy)void(^masony_remakeBlock)(MASConstraintMaker *make);

+ (instancetype)modelWithTitle:(id)title;

@end

NS_ASSUME_NONNULL_END
