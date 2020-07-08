//
//  UITextField+ChineseInput.m
//  QiaoKeApp
//
//  Created by 周发明 on 2020/3/30.
//

#import "UITextField+FormExtension.h"
#import <objc/runtime.h>
#import "FormListConfigure.h"

@implementation UITextField (FormExtension)

+ (void)load{
    {
        Method m1 = class_getInstanceMethod(self, @selector(setPlaceholder:));
        Method m2 = class_getInstanceMethod(self, @selector(_ex_setPlaceholder:));
        method_exchangeImplementations(m1, m2);
    }
}

- (void)_ex_setPlaceholder:(NSString *)placeholder{
    [self _ex_setPlaceholder:placeholder];
    
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.textColor = FormUIColorFromRGB(0x999999);
}

- (void)setLimitCount:(NSInteger)limitCount{
    objc_setAssociatedObject(self, FormTextLimitCountKey, @(limitCount), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)limitCount{
    NSNumber *obj = objc_getAssociatedObject(self, FormTextLimitCountKey);
    if (obj == nil) {
        obj = @0;
        objc_setAssociatedObject(self, FormTextLimitCountKey, obj, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [obj integerValue];
}

- (void)setInputPredicate:(NSString *)inputPredicate{
    objc_setAssociatedObject(self, FormTextInputPredicateKey, inputPredicate, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)inputPredicate{
    NSString *obj = objc_getAssociatedObject(self, FormTextInputPredicateKey);
    return obj;
}

- (void)handleTextDidChange{
    [FormVerifyManager handleTextFieldTextDidChange:self];
}

- (BOOL)isChineseInput{
    NSString *lang = [[self textInputMode] primaryLanguage];
    if([lang isEqualToString:@"zh-Hans"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isEmojiInput{
    return [[[self textInputMode] primaryLanguage] isEqualToString:@"emoji"];
}

- (void)matchWithPattern:(NSString *)pattern{
    if (![self hasInputPinYin] && pattern && pattern.length > 0) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[pattern stringByReplacingOccurrencesOfString:@"[" withString:@"[^"] options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:self.text
                                                                   options:0
                                                                     range:NSMakeRange(0, [self.text length])
                                                              withTemplate:@""];
        self.text = modifiedString;
    }
}

- (BOOL)hasInputPinYin{
    UITextRange *selectedRange = self.markedTextRange;
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        return NO;
    } else {
        return YES;
    }
}

@end
