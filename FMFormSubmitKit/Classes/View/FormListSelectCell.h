//
//  FormListSelectCell.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/29.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTitleCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListSelectCell : FormListTitleCell

@property(nonatomic, weak)UIView *btnView;
@property(nonatomic, weak)UIButton *selectBtn;

@end

NS_ASSUME_NONNULL_END
