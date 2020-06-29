//
//  FormListImageSelectModel.h
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormListImageSelectModel : NSObject
@property(nonatomic, copy)NSString *submitKey;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong, nullable)UIImage *image;
@property(nonatomic, strong, nullable)UIImage *placeholderImage;
@property(nonatomic, copy)NSString *imageUrl; // 上传完图片保存的地址
@property(nonatomic, strong)id otherData; // 其他数据
+ (instancetype)modelWithPlaceholderImageName:(NSString *)imageName;

- (BOOL)verifySuccess;

@end

NS_ASSUME_NONNULL_END
