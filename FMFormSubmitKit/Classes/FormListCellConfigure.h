//
//  FormListCellConfigure.h
//  YaLeGou
//
//  Created by 周发明 on 2019/12/17.
//  Copyright © 2019 y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormListConfigure.h"

NS_ASSUME_NONNULL_BEGIN
@class FormListUpImageConfigure;
@interface FormListCellConfigure : NSObject

///默认支持的小数位数 2
@property(nonatomic, assign)NSInteger inputDecimalCount;

///默认左右边距 
@property(nonatomic, assign)CGFloat lrMargin;
///箭头左边边距
@property(nonatomic, assign)CGFloat arrowLMagin;
///默认分割线高度
@property(nonatomic, assign)CGFloat bottomLineDefaultHeight;

///默认TextFieldCell高度
@property(nonatomic, assign)CGFloat textDefaultHeight;
///默认TextField左边边距
@property(nonatomic, assign)CGFloat tfLMagin;
///默认TextFieldCell高度
@property(nonatomic, assign)CGFloat textVDefaultHeight;

@property(nonatomic, assign)CGFloat tvTitleTopMargin;

@property(nonatomic, strong)UIColor *bottomLineColor;
@property(nonatomic, strong)UIColor *titleColor;
@property(nonatomic, strong)UIColor *TFTVColor;
@property(nonatomic, strong)UIColor *imageIntroColor;

@property(nonatomic, strong)UIFont *titleFont;
@property(nonatomic, strong)UIFont *TFTVFont;
@property(nonatomic, strong)UIFont *imageIntroFont;

@property(nonatomic, strong)UIImage *selectNormalImage;
@property(nonatomic, strong)UIImage *selectSelectedImage;

@property(nonatomic, strong)UIImage *eyeNormalImage;
@property(nonatomic, strong)UIImage *eyeSelectedImage;

@property(nonatomic, strong)FormListUpImageConfigure *currentConfigure;

@property(nonatomic, copy)void(^verifyFailAlertBlock)(NSString *text);

+ (instancetype)defaultConfigure;

@end

NS_ASSUME_NONNULL_END
