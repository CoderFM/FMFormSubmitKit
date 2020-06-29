//
//  FormListSubmitVC.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMFormSubmitKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface FormListSubmitVC : UIViewController
@property(nonatomic, assign)UITableViewStyle tableStyle;
@property(nonatomic, weak)FormListSubmitView *tableView;
@property (nonatomic, strong)NSMutableArray<FormListBaseModel *> *dataSource;
- (void)addData;
- (void)configurationTable;

- (BOOL)verifyDataSource;
- (BOOL)verifyDataSource:(BOOL)alert;
@end

NS_ASSUME_NONNULL_END
