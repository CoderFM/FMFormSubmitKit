//
//  FMPickerView.h
//  qygt
//
//  Created by 周发明 on 17/3/10.
//  Copyright © 2017年 途购. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef void(^FMSelectManagerFinishBlock)(id selectData, NSArray<NSNumber *> *selectRows);

typedef NS_ENUM(NSInteger, FMPickerViewType){
    FMPickerViewTimeType,
    FMPickerViewDataType
};

typedef NS_ENUM(NSInteger, FMPickerViewLinkageType){
    FMPickerViewLinkageNormalType, /// 联动
    FMPickerViewLinkageForbidType  /// 禁止联动
};


@class FMPickerItem;
@interface FMPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

+ (instancetype)viewForXib;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *middleLabel;

@property(nonatomic, copy)void(^timeOKBlock)(NSDate *date);

@property(nonatomic, copy)FMSelectManagerFinishBlock dataOKBlock;

@property(nonatomic, assign)NSInteger  components;

@property(nonatomic, strong)NSMutableArray *items;

@property(nonatomic, assign)FMPickerViewLinkageType linkageType;

- (void)showWithType:(FMPickerViewType)type;

- (void)hide;

@end


@interface FMPickerItem : NSObject
/// 显示的名称
@property(nonatomic, copy)NSString *name;
///下一级数据
@property(nonatomic, strong)NSArray *subItems;
///额外需要传输的数据
@property(nonatomic, strong)id extraValue;

+ (instancetype)itemWithName:(NSString *)name subItems:(NSArray<FMPickerItem *> *)subItems;

@end
