//
//  FormListBaseCell.h
//  YaLeGou
//
//  Created by 周发明 on 2019/12/14.
//  Copyright © 2019 y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormListConfigure.h"

NS_ASSUME_NONNULL_BEGIN
@class FormListBaseModel;
@interface FormListBaseCell : UITableViewCell
@property(nonatomic, weak)UIView *bottomLineView;
@property(nonatomic, strong)FormListBaseModel *model;
@end

NS_ASSUME_NONNULL_END
