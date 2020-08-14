//
//  FormListImageUpCellItemView.h
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FormListImageSelectModel;
///是否是添加图片, 点击的model, 添加时选中的所有图片
typedef void(^FormListImageUpCellItemMutibleClick)(BOOL add, FormListImageSelectModel *model, NSArray * __nullable images);
typedef NSInteger(^FormListImageUpCanSelectMaxCount)(FormListImageSelectModel *model);

@protocol FormListImageUpCellItemDelegate <NSObject>

@property(nonatomic, strong)FormListImageSelectModel *model;
@property(nonatomic, copy)FormListImageUpCellItemMutibleClick clickMutibleBlock;
@property(nonatomic, copy)FormListImageUpCanSelectMaxCount selectMaxCount;

@end

@interface FormListImageUpCellItemView : UIView<FormListImageUpCellItemDelegate>

- (void)delButtonClick;
- (void)addImageClick;

@end

NS_ASSUME_NONNULL_END
