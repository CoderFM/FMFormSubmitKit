//
//  UITextField+ChineseInput.h
//  QiaoKeApp
//
//  Created by 周发明 on 2020/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (FormExtension)

- (BOOL)isChineseInput;

- (BOOL)isEmojiInput;

- (void)matchWithPattern:(NSString *)pattern;

- (BOOL)hasInputPinYin;

@end

NS_ASSUME_NONNULL_END
