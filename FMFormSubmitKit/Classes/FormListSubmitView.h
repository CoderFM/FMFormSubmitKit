//
//  FormListSubmitView.h
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/17.
//  Copyright © 2020 周发明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormListBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListSubmitView : UITableView

@property (nonatomic, strong)NSMutableArray<FormListBaseModel *> *models;
@property(nonatomic, strong, readonly)NSMutableDictionary *submitParam;
- (BOOL)verifyDataSource;
- (BOOL)verifyDataSource:(BOOL)alert;

@end

NS_ASSUME_NONNULL_END
