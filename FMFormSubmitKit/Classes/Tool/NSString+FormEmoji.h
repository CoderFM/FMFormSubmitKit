//
//  NSString+FormEmoji.h
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FormEmoji)

- (NSString *)removeEmoji;
- (BOOL)containEmoji;

@end

NS_ASSUME_NONNULL_END
