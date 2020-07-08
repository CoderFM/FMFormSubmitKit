//
//  UITextView+FormExtension.m
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/27.
//

#import "UITextView+FormExtension.h"
#import <objc/runtime.h>
#import "FormVerifyManager.h"

@implementation UITextView (FormExtension)

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
    [FormVerifyManager handleTextViewTextDidChange:self];
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
