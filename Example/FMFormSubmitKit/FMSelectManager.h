//
//  FMSelectManager.h
//  qygt
//
//  Created by 周发明 on 17/3/13.
//  Copyright © 2017年 途购. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMPickerView.h"

@interface FMSelectManager : NSObject

+ (instancetype)manager;

- (void)showSelectTimeMode:(UIDatePickerMode)datePickerMode middleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock;

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock;

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle showDate:(NSDate *)date okBlock:(void(^)(NSDate *date))okBlock;

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<FMPickerItem *>*)items components:(NSInteger)components okBlock:(FMSelectManagerFinishBlock)okBlock;

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<FMPickerItem *>*)items selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components okBlock:(FMSelectManagerFinishBlock)okBlock;

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<NSArray *>*)items  selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components linkageType:(FMPickerViewLinkageType)linkageType okBlock:(FMSelectManagerFinishBlock)okBlock;

@end
