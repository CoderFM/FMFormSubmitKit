//
//  FormVerifyTextDelegate.h
//  FMFormSubmitKit
//
//  Created by 郑桂华 on 2020/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static void *FormTextLimitCountKey = &FormTextLimitCountKey;
static void *FormTextInputPredicateKey = &FormTextInputPredicateKey;

@protocol FormVerifyTextDelegate <NSObject>

@property(nonatomic, assign)NSInteger limitCount;
@property(nonatomic, copy)NSString *inputPredicate;

- (void)handleTextDidChange;

- (BOOL)isChineseInput;

- (BOOL)isEmojiInput;

- (void)matchWithPattern:(NSString *)pattern;

- (BOOL)hasInputPinYin;

@end

NS_ASSUME_NONNULL_END
