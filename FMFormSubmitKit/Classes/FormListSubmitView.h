//
//  FormListSubmitView.h
//  FormSubmitList
//
//  Created by 郑桂华 on 2020/4/17.
//  Copyright © 2020 郑桂华. All rights reserved.
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
