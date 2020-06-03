//
//  FormListTextVCell.h
//  Project_ZhongAnXiao
//
//  Created by 郑桂华 on 2019/11/30.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListTitleCell.h"

NS_ASSUME_NONNULL_BEGIN
@class FormTextView;
@interface FormListTextVCell : FormListTitleCell
@property(nonatomic, weak)FormTextView *textV;
@end

NS_ASSUME_NONNULL_END
