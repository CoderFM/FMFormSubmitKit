//
//  FormListImageSelectModel.h
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormListImageSelectModel : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong, nullable)UIImage *image;
@property(nonatomic, strong, nullable)UIImage *placeholderImage;
@property(nonatomic, copy)NSString *imageUrl; // 上传完图片保存的地址
@property(nonatomic, copy)NSString *imageId; // 上传完图片id
+ (instancetype)modelWithPlaceholderImageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
