//
//  FormListImageUpCellItemView.h
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FormListImageSelectModel;
typedef void(^FormListImageUpCellItemClick)(BOOL add, FormListImageSelectModel *model);

@protocol FormListImageUpCellItemDelegate <NSObject>

@property(nonatomic, strong)FormListImageSelectModel *model;
@property(nonatomic, copy)FormListImageUpCellItemClick clickBlock;

@end

@interface FormListImageUpCellItemView : UIView<FormListImageUpCellItemDelegate>

- (void)delButtonClick;
- (void)addImageClick;

@end

NS_ASSUME_NONNULL_END
