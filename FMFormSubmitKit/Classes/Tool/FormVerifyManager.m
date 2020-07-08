//
//  FormVerifyManager.m
//  QiaoKeApp
//
//  Created by 周发明 on 2020/3/18.
//

#import "FormVerifyManager.h"
#import "UITextView+FormExtension.h"
#import "UITextField+FormExtension.h"
#import "FormListCellConfigure.h"

@implementation FormVerifyManager

+ (void)handleTextFieldTextDidChange:(UITextField *)textF{
     if (textF.inputPredicate && [textF.inputPredicate isEqualToString:FormVerifyOnlyDecimal]) {
         if ([textF.text containsString:@"."]) {
             NSArray *texts = [textF.text componentsSeparatedByString:@"."];
             NSString *begin = [texts firstObject];
             if ([begin integerValue] == 0) {
                 begin = @"0";
             } else {
                 begin = [NSString stringWithFormat:@"%ld", [begin integerValue]];
             }
             if (texts.count > 1) {
                 NSString *last = texts[1];
                 if (last.length > [FormListCellConfigure defaultConfigure].inputDecimalCount) {
                     last = [last substringToIndex:[FormListCellConfigure defaultConfigure].inputDecimalCount];
                 }
                 textF.text = [@[begin, last] componentsJoinedByString:@"."];
             } else {
                 textF.text = [NSString stringWithFormat:@"%@.", begin];
             }
         } else {
             NSString *begin = textF.text;
             if (begin.length > 0) {
                 if ([begin integerValue] == 0) {
                     begin = @"0";
                 } else {
                     begin = [NSString stringWithFormat:@"%ld", [begin integerValue]];
                 }
                textF.text = begin;
             }
         }
     }
     
     if (textF.isChineseInput) {
         [textF matchWithPattern:textF.inputPredicate];
     }
    
     if (![textF hasInputPinYin]) {
         if (textF.limitCount > 0) {
             if (textF.text.length > textF.limitCount) {
                 textF.text = [textF.text substringToIndex:textF.limitCount];
             }
         }
     }
}

+ (void)handleTextViewTextDidChange:(UITextView *)textV{
    
    if (textV.isChineseInput) {
        [textV matchWithPattern:textV.inputPredicate];
    }
    
    if (![textV hasInputPinYin]) {
        if (textV.limitCount > 0) {
            if (textV.text.length > textV.limitCount) {
                textV.text = [textV.text substringToIndex:textV.limitCount];
            }
        }
    }
}

@end

@implementation NSString (FormVerifyManager)

- (BOOL)verifyPredicate:(NSString *)predicate{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicate];
    return [pre evaluateWithObject:self];
}

@end
