//
//  UITextField+ChineseInput.h
//  QiaoKeApp
//
//  Created by 周发明 on 2020/3/30.
//

#import <UIKit/UIKit.h>
#import "FormVerifyTextDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (FormExtension)<FormVerifyTextDelegate>

@property(nonatomic, readonly)UILabel *placeholderLabel;

@end

NS_ASSUME_NONNULL_END
