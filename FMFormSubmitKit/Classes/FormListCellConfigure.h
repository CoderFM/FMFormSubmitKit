//
//  FormListCellConfigure.h
//  YaLeGou
//
//  Created by 郑桂华 on 2019/12/17.
//  Copyright © 2019 y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormListConfigure.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormListCellConfigure : NSObject

@property(nonatomic, assign)CGFloat lrMargin;
@property(nonatomic, assign)CGFloat arrowLMagin;
@property(nonatomic, assign)CGFloat bottomLineDefaultHeight;

@property(nonatomic, assign)CGFloat textDefaultHeight;
@property(nonatomic, assign)CGFloat tfLMagin;
@property(nonatomic, assign)CGFloat textVDefaultHeight;
//@property(nonatomic, assign)CGFloat imageSpace;
//@property(nonatomic, assign)CGFloat imageLRMagin;
//@property(nonatomic, assign)CGFloat imageHeight;
//@property(nonatomic, assign)CGFloat imageWidth;
//@property(nonatomic, assign)CGFloat imageIntroTopMargin;
@property(nonatomic, assign)CGFloat cellArrowLMagin;

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

@property(nonatomic, copy)void(^verifyFailAlertBlock)(NSString *text);

+ (instancetype)defaultConfigure;

@end

NS_ASSUME_NONNULL_END
