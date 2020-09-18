//
//  FormListSelectModel.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/29.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListSelectModel : FormListTitleModel

@property(nonatomic, strong)NSArray *selects;
@property(nonatomic, assign)NSInteger selectIndex;
@property(nonatomic, copy)void(^configurationBtn)(NSInteger index, UIButton *btn, NSString *title);
@property(nonatomic, copy)void(^selectClick)(NSInteger index, UIButton *btn);
+ (instancetype)modelWithTitle:(NSString *)title;

@end

@interface FormListBaseModel (ConvertSelect)

@property(readonly)FormListSelectModel *convertSelect;

@end

NS_ASSUME_NONNULL_END
