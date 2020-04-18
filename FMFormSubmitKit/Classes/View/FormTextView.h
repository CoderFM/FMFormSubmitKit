//
//  FormTextView.h
//  FormSubmitList
//
//  Created by 郑桂华 on 2019/12/20.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormTextView : UITextView

@property(nullable, nonatomic,copy) IBInspectable NSString    *placeholder;

@property(nullable, nonatomic,copy) IBInspectable NSAttributedString    *attributedPlaceholder;

@property(nullable, nonatomic,copy) IBInspectable UIColor    *placeholderTextColor;

@end

NS_ASSUME_NONNULL_END
