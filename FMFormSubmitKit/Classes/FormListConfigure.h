//
//  FormListConfigure.h
//  FormSubmitList
//
//  Created by 周发明 on 2019/12/20.
//  Copyright © 2019 周发明. All rights reserved.
//

#ifndef FormListConfigure_h
#define FormListConfigure_h

#import <Masonry/Masonry.h>
#import "FormVerifyManager.h"
#import "UITextField+FormExtension.h"
#import "FormListCellConfigure.h"

#define FormUIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Form_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define Form_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Form_BaseSize(x) Form_SCREEN_WIDTH*(x)/375.0 // 适配比例

#define FormCellLRMargin [FormListCellConfigure defaultConfigure].lrMargin // 左右边距
#define FormCellArrowLMagin [FormListCellConfigure defaultConfigure].arrowLMagin // 箭头左边距
#define FormCellBottomLineDefaultHeight [FormListCellConfigure defaultConfigure].bottomLineDefaultHeight // 底部分割线默认高度

#define FormCellBottomLineColor [FormListCellConfigure defaultConfigure].bottomLineColor // 底部分割线颜色

#define FormCellTitleColor [FormListCellConfigure defaultConfigure].titleColor // 标题颜色
#define FormCellTitleFont [FormListCellConfigure defaultConfigure].titleFont // 标题字体

#define FormCellTFTVColor [FormListCellConfigure defaultConfigure].TFTVColor // 文本颜色
#define FormCellTFTVFont [FormListCellConfigure defaultConfigure].TFTVFont // 文本字体

#define FormCellPlaceholderColor [FormListCellConfigure defaultConfigure].placeholderColor // 标题颜色

#define FormCellTVTitleTopMargin [FormListCellConfigure defaultConfigure].tvTitleTopMargin // TV的Title的顶部边距

#define FormTextCellDefaultHeight [FormListCellConfigure defaultConfigure].textDefaultHeight // 默认TFCell的高度
#define FormTextCellTFLMagin [FormListCellConfigure defaultConfigure].tfLMagin // 默认TF左边的边距
#define FormTextVCellDefaultHeight [FormListCellConfigure defaultConfigure].textVDefaultHeight // 默认TVCell的高度

#define FormUpCellDefaultImage @"form_list_image_add" // 添加图片默认
#define FormSelectCellNormalImage [FormListCellConfigure defaultConfigure].selectNormalImage
#define FormSelectCellSelectImage [FormListCellConfigure defaultConfigure].selectSelectedImage
#define FormEyeNormalImage [FormListCellConfigure defaultConfigure].eyeNormalImage
#define FormEyeCellSelectImage [FormListCellConfigure defaultConfigure].eyeSelectedImage
#define FormVerifyFailAlert(message) ![FormListCellConfigure defaultConfigure].verifyFailAlertBlock?:[FormListCellConfigure defaultConfigure].verifyFailAlertBlock(message) // 验证失败的提示

#define FormSubmitDefaultValue @"" // 提交默认值

#define FormSubmitModelValueChangeNotiKey @"FormSubmitModelValueChangeNotiKey" //值改变的通知

#endif /* FormListConfigure_h */
