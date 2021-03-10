//
//  FormListHandle.h
//  FMFormSubmitKit
//
//  Created by 郑桂华 on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormListBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FormListHandle : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray<NSMutableArray<FormListBaseModel *> *> *groupModels;
@property (nonatomic, strong)NSMutableArray<FormListBaseModel *> *models;
@property (nonatomic, strong, readonly)NSMutableDictionary *submitParam;
@property (nonatomic, assign)CGFloat cardCornerReadus;
@property (nonatomic, assign)CGFloat sectionMargin;

@property(nonatomic, weak)UITableView *tableView;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)registerCell;

- (BOOL)verifyDataSource;
- (BOOL)verifyDataSource:(BOOL)alert;

@end

NS_ASSUME_NONNULL_END
