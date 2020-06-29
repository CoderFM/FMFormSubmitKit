//
//  FormListImageUpModel.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "FormListTitleModel.h"

NS_ASSUME_NONNULL_BEGIN
@class FormListImageSelectModel, FormListUpImageConfigure;
@interface FormListImageUpModel : FormListTitleModel
@property(nonatomic, assign)BOOL canDynamicAdd;
@property(nonatomic, assign)NSInteger maxCount;
@property(nonatomic, copy)void(^refreshBlock)(void);
@property(nonatomic, strong)NSArray<FormListImageSelectModel *> *images;

@property(nonatomic, strong)FormListUpImageConfigure *imageConfigure;

@property(nonatomic, copy)void(^selectImageBlock)(FormListImageSelectModel *model, UIImage *image);

+ (instancetype)modelWithCongigure:(FormListUpImageConfigure *)configure images:(NSArray<FormListImageSelectModel *> *)images;
+ (instancetype)modelDynamicAddWithCongigure:(FormListUpImageConfigure *)configure maxCount:(NSInteger)maxCount;

@end

@interface FormListBaseModel (ConvertImage)

@property(readonly)FormListImageUpModel *convertImage;

@end

NS_ASSUME_NONNULL_END
