//
//  UITextView+FormExtension.m
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/27.
//

#import "UITextView+FormExtension.h"

@implementation UITextView (FormExtension)

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
